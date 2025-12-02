import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

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
  // Legacy login for AdGuard Home (kept for reference, but likely unused in transformed app)
  static Future<AuthStatus> login(Server server) async {
    // ... existing implementation ...
    return AuthStatus.unknown;
  }

  // New method for AdGuard Private DNS
  static Future<AuthStatus> validateApiKey(String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.adguard-dns.io/oapi/v1/account/limits'),
        headers: {
          'Authorization': 'ApiKey $apiKey',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return AuthStatus.success;
      }
      else if (response.statusCode == 401 || response.statusCode == 403) {
        return AuthStatus.invalidCredentials;
      }
      else if (response.statusCode == 429) {
        return AuthStatus.manyAttepts;
      }
      else if (response.statusCode >= 500) {
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
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return AuthStatus.unknown;
    }
  }

  static Future<AuthStatus> loginHA(Server server) async {
     // ... legacy ...
     return AuthStatus.unknown;
  }
}
