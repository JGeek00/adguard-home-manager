import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:adguard_home_manager/classes/http_client.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/auth.dart';
import 'package:adguard_home_manager/services/glinet_auth.dart';

class _Router {
  final HttpServer http;
  int logins = 0;
  int challenges = 0;
  int calls = 0;
  int statusRequests = 0;
  int? failStatusRequest;
  int? loginError;
  bool rejectNextCall = false;
  String sid = 'sid-0';

  _Router(this.http);

  int get port => http.port;

  static Future<_Router> start({bool notGlinet = false}) async {
    final http = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final router = _Router(http);
    router.http.listen((request) async {
      if (notGlinet) {
        request.response.statusCode = 404;
        await request.response.close();
        return;
      }
      if (request.uri.path == '/rpc') {
        final body = jsonDecode(await utf8.decoder.bind(request).join()) as Map;
        final method = body['method'];
        if (method == 'challenge') {
          router.challenges += 1;
          _json(request, {
            'jsonrpc': '2.0',
            'id': 1,
            'result': {
              'salt': 'abcdefghijklmnop',
              'nonce': 'nonce-${router.challenges}',
              'alg': 5,
              'hash-method': 'sha256',
            },
          });
          return;
        }
        if (method == 'login') {
          router.logins += 1;
          if (router.loginError != null) {
            _json(request, {
              'jsonrpc': '2.0',
              'id': 1,
              'error': {'code': router.loginError, 'message': 'no'},
            });
            return;
          }
          router.sid = 'sid-${router.logins}';
          _json(request, {
            'jsonrpc': '2.0',
            'id': 1,
            'result': {'sid': router.sid},
          });
          return;
        }
        if (method == 'call') {
          router.calls += 1;
          final denied = router.rejectNextCall;
          router.rejectNextCall = false;
          if (denied) {
            _json(request, {
              'jsonrpc': '2.0',
              'id': 1,
              'error': {'code': -32000, 'message': 'Access denied'},
            });
            return;
          }
          _json(request, {
            'jsonrpc': '2.0',
            'id': 1,
            'result': {'enabled': true},
          });
          return;
        }
      }
      if (request.uri.path == '/control/status') {
        router.statusRequests += 1;
        final cookie = request.headers.value('cookie') ?? '';
        final ok = cookie == 'Admin-Token=${router.sid}' &&
            router.statusRequests != router.failStatusRequest;
        request.response.statusCode = ok ? 200 : 401;
        request.response.write(ok ? '{"version":"0.107.73"}' : '');
        await request.response.close();
        return;
      }
      request.response.statusCode = 404;
      await request.response.close();
    });
    return router;
  }

  Server get server => Server(
        id: 'router',
        name: 'router',
        connectionMethod: 'http',
        domain: '127.0.0.1',
        port: port,
        password: 'secret',
        defaultServer: false,
        runningOnHa: false,
        glinetAuth: true,
      );
}

void _json(HttpRequest request, Map<String, dynamic> body) {
  request.response.headers.contentType = ContentType.json;
  request.response.write(jsonEncode(body));
  request.response.close();
}

void main() {
  setUp(GlinetAuth.debugReset);

  test('logs in once and sends the Admin-Token cookie', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    final status = await GlinetAuth.login(router.server);
    expect(status, AuthStatus.success);
    expect(router.logins, 1);
    expect(router.challenges, 2);

    final again = await Future.wait([
      GlinetAuth.sessionCookie(router.server),
      GlinetAuth.sessionCookie(router.server),
    ]);
    expect(again, ['sid-1', 'sid-1']);
    expect(router.logins, 1);

    final response = await HttpRequestClient.get(urlPath: '/status', server: router.server);
    expect(response.successful, isTrue);
    expect(response.body, contains('0.107.73'));
  });

  test('a 401 logs in again and retries the request once', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    router.failStatusRequest = 2;
    final response = await HttpRequestClient.get(urlPath: '/status', server: router.server);
    expect(response.successful, isTrue);
    expect(router.logins, 2);
  });

  test('refreshes an idle session with an authenticated call', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    expect(await GlinetAuth.login(router.server), AuthStatus.success);
    final callsAfterLogin = router.calls;
    GlinetAuth.refreshAfter = Duration.zero;
    expect(await GlinetAuth.sessionCookie(router.server), 'sid-1');
    expect(router.calls, callsAfterLogin + 1);
    expect(router.logins, 1);
  });

  test('an expired session is replaced with a new login', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    expect(await GlinetAuth.login(router.server), AuthStatus.success);
    GlinetAuth.refreshAfter = Duration.zero;
    router.rejectNextCall = true;
    expect(await GlinetAuth.sessionCookie(router.server), 'sid-2');
    expect(router.logins, 2);
  });

  test('maps router login errors', () async {
    final denied = await _Router.start();
    addTearDown(denied.http.close);
    denied.loginError = -32000;
    expect(await GlinetAuth.login(denied.server), AuthStatus.invalidCredentials);

    final limited = await _Router.start();
    addTearDown(limited.http.close);
    limited.loginError = -32003;
    expect(await GlinetAuth.login(limited.server), AuthStatus.manyAttepts);
  });

  test('probe finds a router and a missing port', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    final found = await GlinetAuth.probe(router.server);
    expect(found.found, isTrue);
    expect(found.clearPort, isFalse);

    GlinetAuth.debugFallbackPort = router.port;
    final onDefaultPort = await GlinetAuth.probe(Server(
      id: 'other',
      name: 'other',
      connectionMethod: 'http',
      domain: '127.0.0.1',
      port: 1,
      password: 'secret',
      defaultServer: false,
      runningOnHa: false,
      glinetAuth: true,
    ));
    expect(onDefaultPort.found, isTrue);
    expect(onDefaultPort.clearPort, isTrue);
  });

  test('a non-router address is not a GL.iNet login', () async {
    final router = await _Router.start(notGlinet: true);
    addTearDown(router.http.close);
    expect(await GlinetAuth.login(router.server), AuthStatus.glinetNotFound);
  });

  test('glinet auth is chosen when both flags are set', () async {
    final router = await _Router.start();
    addTearDown(router.http.close);
    final server = router.server..runningOnHa = true;
    expect(await ServerAuth.authenticate(server), AuthStatus.success);
    expect(router.logins, 1);
  });
}
