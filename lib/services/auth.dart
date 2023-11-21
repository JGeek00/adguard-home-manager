import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adguard_home_manager/classes/http_client.dart';
import 'package:adguard_home_manager/models/server.dart';

enum AuthStatus { 
  success, 
  invalidCredentials, 
  manyAttepts, 
  serverError, 
  socketException,
  timeoutException,
  handshakeException,
  unknown 
}

class ServerAuth {
  static Future<AuthStatus> login(Server server) async {
    try {
      final body = {
        "name": server.user,
        "password": server.password
      };
      final connectionString = "${server.connectionMethod}://${server.domain}${server.port != null ? ':${server.port}' : ""}${server.path ?? ""}/control/login";
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(connectionString));
      request.headers.set('content-type', 'application/json');
      request.headers.contentLength = utf8.encode(jsonEncode(body)).length;
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close().timeout(const Duration(seconds: 10));
      httpClient.close();
      if (response.statusCode == 200) {
        return AuthStatus.success;
      }
      else if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 403) {
        return AuthStatus.invalidCredentials;
      }
      else if (response.statusCode == 429) {
        return AuthStatus.manyAttepts;
      }
      else if (response.statusCode == 500) {
        return AuthStatus.serverError;
      }
      else {
        return AuthStatus.unknown;
      }
    } on SocketException {
      return AuthStatus.socketException;
    } on TimeoutException {
      return AuthStatus.timeoutException;
    } on HandshakeException {
      return AuthStatus.handshakeException;
    } catch (e) {
      return AuthStatus.unknown;
    }
  }

  static Future<AuthStatus> loginHA(Server server) async {
    try {
      final result = await HttpRequestClient.get(urlPath: "/status", server: server);
      if (result.successful) {
        return AuthStatus.success;
      }
      else if (result.statusCode == 401 || result.statusCode == 403) {
        return AuthStatus.invalidCredentials;
      }
      else {
        return AuthStatus.unknown;
      }
    } on SocketException {
      return AuthStatus.socketException;
    } on TimeoutException {
      return AuthStatus.timeoutException;
    } on HandshakeException {
      return AuthStatus.handshakeException;
    } catch (e) {
      return AuthStatus.unknown;
    }
  }
}