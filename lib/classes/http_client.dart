import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/glinet_auth.dart';

enum ExceptionType { socket, timeout, handshake, http, unknown }

class HttpResponse {
  final bool successful;
  final String? body;
  final int? statusCode;
  final ExceptionType? exception;

  const HttpResponse({
    required this.successful,
    required this.body,
    required this.statusCode,
    this.exception,
  });
}

String getConnectionString({
  required Server server,
  required String urlPath,
}) {
  return "${server.connectionMethod}://${server.domain}${server.port != null ? ':${server.port}' : ""}${server.path ?? ""}/control$urlPath";
}

class HttpRequestClient {
  static Future<HttpResponse> get({
    required String urlPath,
    required Server server,
    int timeout = 10,
  }) {
    return _send(method: 'get', urlPath: urlPath, server: server, timeout: timeout);
  }

  static Future<HttpResponse> post({
    required String urlPath,
    required Server server,
    dynamic body,
    int timeout = 10,
  }) {
    return _send(method: 'post', urlPath: urlPath, server: server, body: body, timeout: timeout);
  }

  static Future<HttpResponse> put({
    required String urlPath,
    required Server server,
    dynamic body,
    int timeout = 10,
  }) {
    return _send(method: 'put', urlPath: urlPath, server: server, body: body, timeout: timeout);
  }

  static Future<HttpResponse> _send({
    required String method,
    required String urlPath,
    required Server server,
    dynamic body,
    int timeout = 10,
    bool allowRetry = true,
  }) async {
    // Resolve the router session before opening the AdGuard connection.
    // SHA-256-crypt is slow enough that an already-open request can sit idle
    // past the nonce, and the router session is not needed to build the URL.
    String? sid;
    if (server.glinetAuth) {
      sid = await GlinetAuth.sessionCookie(server);
      if (sid == null) {
        return const HttpResponse(
          successful: false,
          body: null,
          statusCode: null,
          exception: ExceptionType.unknown,
        );
      }
    }
    final String connectionString = getConnectionString(server: server, urlPath: urlPath);
    final client = HttpClient();
    try {
      final request = await _open(client, method, connectionString);
      if (sid != null) {
        request.headers.set('Cookie', 'Admin-Token=$sid');
      } else if (server.authToken != null) {
        request.headers.set('Authorization', 'Basic ${server.authToken}');
      }
      if (method != 'get') {
        request.headers.set('content-type', 'application/json');
        request.add(utf8.encode(json.encode(body)));
      }
      final response = await request.close().timeout(Duration(seconds: timeout));
      final reply = await response.transform(utf8.decoder).join();
      if (server.glinetAuth && response.statusCode == 401 && allowRetry) {
        GlinetAuth.invalidate(server);
        return await _send(
          method: method,
          urlPath: urlPath,
          server: server,
          body: body,
          timeout: timeout,
          allowRetry: false,
        );
      }
      return HttpResponse(
        successful: response.statusCode < 400,
        body: reply,
        statusCode: response.statusCode,
      );
    } on SocketException {
      return const HttpResponse(
        successful: false,
        body: null,
        statusCode: null,
        exception: ExceptionType.socket,
      );
    } on TimeoutException {
      return const HttpResponse(
        successful: false,
        body: null,
        statusCode: null,
        exception: ExceptionType.timeout,
      );
    } on HandshakeException {
      return const HttpResponse(
        successful: false,
        body: null,
        statusCode: null,
        exception: ExceptionType.handshake,
      );
    } on HttpException {
      return const HttpResponse(
        successful: false,
        body: null,
        statusCode: null,
        exception: ExceptionType.http,
      );
    } catch (_) {
      return const HttpResponse(
        successful: false,
        body: null,
        statusCode: null,
        exception: ExceptionType.unknown,
      );
    } finally {
      client.close();
    }
  }

  static Future<HttpClientRequest> _open(HttpClient client, String method, String url) {
    final uri = Uri.parse(url);
    switch (method) {
      case 'post':
        return client.postUrl(uri);
      case 'put':
        return client.putUrl(uri);
      default:
        return client.getUrl(uri);
    }
  }
}
