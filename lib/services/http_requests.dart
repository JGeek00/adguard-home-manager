// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/dns_statistics.dart';
import 'package:adguard_home_manager/models/server.dart';

Future<http.Response> getRequest(String urlPath, Server server) {
  return http.get(
    Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control$urlPath"),
    headers: {
      'Authorization': 'Basic ${server.authToken}'
    }
  );
}

Future login(Server server) async {
  try {
    final result = await http.post(
      Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control/login"),
      body: jsonEncode({
        "name": server.user,
        "password": server.password
      })
    );
    if (result.statusCode == 200) {
      return {'result': 'success'};
    }
    else if (result.statusCode == 400) {
      return {
        'result': 'error',
        'message': 'invalid_username_password'
      };
    }
    else if (result.statusCode == 429) {
      return {
        'result': 'error',
        'message': 'many_attempts'
      };
    }
    else {
      return {'result': 'error'};
    }
  } on SocketException {
    return {'result': 'no_connection'};
  } on TimeoutException {
    return {'result': 'no_connection'};
  } on HandshakeException {
    return {'result': 'ssl_error'};
  } catch (e) {
    return {'result': 'error'};
  }
}

Future getServerStatus(Server server) async {
  try {
    final result = await Future.wait([
      getRequest('/stats', server),
      getRequest('/status', server),
      getRequest('/filtering/status', server),
      getRequest('/safesearch/status', server),
      getRequest('/safebrowsing/status', server),
      getRequest('/parental/status', server),
    ]);

    if (
      result[0].statusCode == 200 &&
      result[1].statusCode == 200 &&
      result[2].statusCode == 200 &&
      result[3].statusCode == 200 &&
      result[4].statusCode == 200 &&
      result[5].statusCode == 200 
    ) {
      final Map<String, dynamic> mappedData = {
        'stats': jsonDecode(result[0].body),
        'generalEnabled': jsonDecode(result[1].body),
        'filteringEnabled': jsonDecode(result[2].body),
        'safeSearchEnabled': jsonDecode(result[3].body),
        'safeBrowsingEnabled': jsonDecode(result[4].body),
        'parentalControlEnabled': jsonDecode(result[5].body),
      };

      return {
        'result': 'success',
        'data': ServerStatusData.fromJson(mappedData)
      };
    }
    else {
      return {'result': 'error'};
    }
  } on SocketException {
    return {'result': 'no_connection'};
  } on TimeoutException {
    return {'result': 'no_connection'};
  } on HandshakeException {
    return {'result': 'ssl_error'};
  } catch (e) {
    return {'result': 'error'};
  }
}