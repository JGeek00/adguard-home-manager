// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:adguard_home_manager/models/dns_statistics.dart';
import 'package:adguard_home_manager/models/server.dart';

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

Future getDnsStatistics(Server server) async {
  try {
    final result = await http.get(
      Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control/stats"),
      headers: {
        'Authorization': 'Basic ${server.authToken}'
      }
    );
    if (result.statusCode == 200) {
      return {
        'result': 'success',
        'data': DnsStatistics.fromJson(jsonDecode(result.body))
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