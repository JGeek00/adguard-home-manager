import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'package:adguard_home_manager/functions/unix_crypt.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/auth_status.dart';
import 'package:adguard_home_manager/services/local_network_permission.dart';

/// Where a GL.iNet `challenge` request answered.
class GlinetProbe {
  final bool found;

  /// The address only answered after the entered port was dropped, so the
  /// connection form should clear it.
  final bool clearPort;

  const GlinetProbe({required this.found, required this.clearPort});

  static const none = GlinetProbe(found: false, clearPort: false);
}

class _Challenge {
  final String salt;
  final String nonce;
  final int alg;
  final String? hashMethod;

  const _Challenge({
    required this.salt,
    required this.nonce,
    required this.alg,
    required this.hashMethod,
  });
}

class _GlinetSession {
  final String sid;
  DateTime touched;

  _GlinetSession(this.sid, this.touched);
}

class _Cipher {
  final int alg;
  final String salt;
  final String value;

  const _Cipher({required this.alg, required this.salt, required this.value});
}

enum _Touch { ok, denied, failed }

/// GL.iNet firmware 4.x admin login.
///
/// AdGuard started with `--glinet` ignores `POST /control/login` and accepts
/// the `Admin-Token` cookie from the router's `/rpc` API. The router session
/// expires after a few minutes without an RPC call, so [sessionCookie] refreshes
/// it. SHA-256-crypt is slow relative to the nonce lifetime, so the cipher is
/// cached per salt and a fresh nonce is taken immediately before `login`.
class GlinetAuth {
  static const _username = 'root';

  /// Touch the router session once it has been idle this long. A GL.iNet
  /// session id expires after 5 minutes without an RPC call.
  static Duration refreshAfter = const Duration(minutes: 2);

  /// When set, a probe that misses [Server.port] retries on this port instead
  /// of the scheme default. Production leaves it null.
  static int? debugFallbackPort;

  static final Map<String, _GlinetSession> _sessions = {};
  static final Map<String, _Cipher> _ciphers = {};
  static final Map<String, Future<AuthStatus>> _logins = {};
  static final Map<String, Future<String?>> _cookies = {};

  static void debugReset() {
    _sessions.clear();
    _ciphers.clear();
    _logins.clear();
    _cookies.clear();
    refreshAfter = const Duration(minutes: 2);
    debugFallbackPort = null;
  }

  static void invalidate(Server server) {
    _sessions.remove(server.id);
  }

  static Future<AuthStatus> login(Server server) {
    final existing = _logins[server.id];
    if (existing != null) return existing;
    final future = _login(server);
    _logins[server.id] = future;
    return future.whenComplete(() {
      if (identical(_logins[server.id], future)) {
        _logins.remove(server.id);
      }
    });
  }

  /// Sid for the `Admin-Token` cookie, logging in or refreshing as needed.
  /// Concurrent callers for the same server share one attempt.
  static Future<String?> sessionCookie(Server server) {
    final existing = _cookies[server.id];
    if (existing != null) return existing;
    final future = _sessionCookie(server);
    _cookies[server.id] = future;
    return future.whenComplete(() {
      if (identical(_cookies[server.id], future)) {
        _cookies.remove(server.id);
      }
    });
  }

  static Future<GlinetProbe> probe(Server server) async {
    if (await _isRouter(server, fallbackPort: false)) {
      return const GlinetProbe(found: true, clearPort: false);
    }
    if (server.port != null && await _isRouter(server, fallbackPort: true)) {
      return const GlinetProbe(found: true, clearPort: true);
    }
    return GlinetProbe.none;
  }

  static Future<String?> _sessionCookie(Server server) async {
    final current = _sessions[server.id];
    if (current != null && DateTime.now().difference(current.touched) < refreshAfter) {
      return current.sid;
    }
    if (current != null) {
      final touch = await _touch(server, current.sid);
      if (touch == _Touch.ok) {
        current.touched = DateTime.now();
        return current.sid;
      }
      if (touch == _Touch.failed) {
        return current.sid;
      }
      _sessions.remove(server.id);
    }
    final status = await login(server);
    if (status != AuthStatus.success) return null;
    return _sessions[server.id]?.sid;
  }

  static Future<AuthStatus> _login(Server server) async {
    try {
      await LocalNetworkPermission.ensureGranted(server.domain);
      final first = await _challenge(server);
      if (first == null) return AuthStatus.glinetNotFound;
      final cipher = _cipherFor(server, first);
      // The nonce only lasts about a second, and crypt can use most of that.
      // Take another nonce now that the cipher is known. The salt stays put
      // until the router password changes.
      final second = await _challenge(server);
      if (second == null) return AuthStatus.glinetNotFound;
      final ready = second.salt == cipher.salt && second.alg == cipher.alg
          ? cipher
          : _cipherFor(server, second);
      final hash = glinetLoginHash(
        username: _username,
        cipher: ready.value,
        nonce: second.nonce,
        hashMethod: second.hashMethod,
      );
      final loggedIn = await _rpc(
        server,
        fallbackPort: false,
        body: {
          'jsonrpc': '2.0',
          'id': 1,
          'method': 'login',
          'params': {'username': _username, 'hash': hash},
        },
      );
      final failure = _loginFailure(loggedIn.json);
      if (failure != null) return failure;
      final sid = _sid(loggedIn.json);
      if (sid == null) return AuthStatus.glinetNotFound;

      // An authenticated call refreshes /tmp/gl_token_<sid>, which AdGuard's
      // --glinet mode requires. Firmware 4.10 writes that file at login;
      // older firmware writes it only from this call.
      final touch = await _touch(server, sid);
      if (touch == _Touch.denied) return AuthStatus.glinetSessionRejected;

      final status = await _getControl(server, '/status', sid);
      if (status == 200) {
        _sessions[server.id] = _GlinetSession(sid, DateTime.now());
        return AuthStatus.success;
      }
      if (status == null) return AuthStatus.socketException;
      return AuthStatus.glinetSessionRejected;
    } on SocketException {
      return AuthStatus.socketException;
    } on TimeoutException {
      return AuthStatus.timeoutException;
    } on HandshakeException {
      return AuthStatus.handshakeException;
    } on HttpException {
      return AuthStatus.socketException;
    } on UnsupportedError {
      return AuthStatus.glinetNotFound;
    }
  }

  static Future<bool> _isRouter(Server server, {required bool fallbackPort}) async {
    try {
      final challenge = await _challenge(server, fallbackPort: fallbackPort);
      return challenge != null;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    } on HandshakeException {
      return false;
    } on HttpException {
      return false;
    }
  }

  static _Cipher _cipherFor(Server server, _Challenge challenge) {
    final cached = _ciphers[server.id];
    if (cached != null && cached.alg == challenge.alg && cached.salt == challenge.salt) {
      return cached;
    }
    final value = unixCrypt(server.password ?? '', challenge.alg, challenge.salt);
    final cipher = _Cipher(alg: challenge.alg, salt: challenge.salt, value: value);
    _ciphers[server.id] = cipher;
    return cipher;
  }

  static Future<_Challenge?> _challenge(Server server, {bool fallbackPort = false}) async {
    final response = await _rpc(
      server,
      fallbackPort: fallbackPort,
      body: {
        'jsonrpc': '2.0',
        'id': 1,
        'method': 'challenge',
        'params': {'username': _username},
      },
    );
    final result = response.json?['result'];
    if (result is! Map) return null;
    final salt = result['salt'];
    final nonce = result['nonce'];
    final alg = result['alg'];
    if (salt is! String || nonce is! String || alg is! int) return null;
    final hashMethod = result['hash-method'];
    return _Challenge(
      salt: salt,
      nonce: nonce,
      alg: alg,
      hashMethod: hashMethod is String ? hashMethod : null,
    );
  }

  static Future<_Touch> _touch(Server server, String sid) async {
    try {
      final response = await _rpc(
        server,
        fallbackPort: false,
        body: {
          'jsonrpc': '2.0',
          'id': 1,
          'method': 'call',
          'params': [sid, 'adguardhome', 'get_config', <String, dynamic>{}],
        },
      );
      final error = response.json?['error'];
      if (error is Map && error['code'] == -32000) return _Touch.denied;
      if (response.status != null && response.status! < 400 && response.json != null) {
        return _Touch.ok;
      }
      return _Touch.failed;
    } on SocketException {
      return _Touch.failed;
    } on TimeoutException {
      return _Touch.failed;
    } on HandshakeException {
      return _Touch.failed;
    } on HttpException {
      return _Touch.failed;
    }
  }

  static AuthStatus? _loginFailure(Map<String, dynamic>? json) {
    final error = json?['error'];
    if (error is! Map) return null;
    if (error['code'] == -32003) return AuthStatus.manyAttepts;
    return AuthStatus.invalidCredentials;
  }

  static String? _sid(Map<String, dynamic>? json) {
    final result = json?['result'];
    if (result is! Map) return null;
    final sid = result['sid'];
    if (sid is! String || sid.isEmpty) return null;
    return sid;
  }

  static Future<_RpcResponse> _rpc(
    Server server, {
    required bool fallbackPort,
    required Map<String, dynamic> body,
  }) async {
    final uri = _uri(server, '/rpc', fallbackPort: fallbackPort);
    final client = HttpClient();
    try {
      final request = await client.postUrl(uri).timeout(const Duration(seconds: 10));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(jsonEncode(body)));
      final response = await request.close().timeout(const Duration(seconds: 10));
      final text = await response.transform(utf8.decoder).join();
      return _RpcResponse(response.statusCode, _decode(text));
    } finally {
      client.close();
    }
  }

  static Future<int?> _getControl(Server server, String path, String sid) async {
    final uri = _uri(server, '/control$path', fallbackPort: false);
    final client = HttpClient();
    try {
      final request = await client.getUrl(uri).timeout(const Duration(seconds: 10));
      request.headers.set('Cookie', 'Admin-Token=$sid');
      final response = await request.close().timeout(const Duration(seconds: 10));
      await response.drain();
      return response.statusCode;
    } on SocketException {
      return null;
    } on TimeoutException {
      return null;
    } on HandshakeException {
      return null;
    } on HttpException {
      return null;
    } finally {
      client.close();
    }
  }

  static Uri _uri(Server server, String path, {required bool fallbackPort}) {
    final int? port;
    if (fallbackPort) {
      port = debugFallbackPort;
    } else {
      port = server.port;
    }
    final extra = server.path ?? '';
    return Uri(
      scheme: server.connectionMethod,
      host: server.domain,
      port: port,
      path: '$extra$path',
    );
  }

  static Map<String, dynamic>? _decode(String text) {
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      return null;
    } on FormatException {
      return null;
    }
  }
}

class _RpcResponse {
  final int? status;
  final Map<String, dynamic>? json;

  const _RpcResponse(this.status, this.json);
}

/// `{username}:{cipher}:{nonce}` hashed the way the GL.iNet web UI does.
///
/// `hash-method` is `sha256` on firmware 4.10. Older firmware omits it and
/// uses MD5.
String glinetLoginHash({
  required String username,
  required String cipher,
  required String nonce,
  String? hashMethod,
}) {
  final material = utf8.encode('$username:$cipher:$nonce');
  if (hashMethod == null || hashMethod == 'md5') {
    return md5.convert(material).toString();
  }
  if (hashMethod == 'sha256') {
    return sha256.convert(material).toString();
  }
  throw UnsupportedError('Unsupported GL.iNet hash-method $hashMethod');
}
