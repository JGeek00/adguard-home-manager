// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/models/server.dart';

Future<http.Response> getRequest({
  required String urlPath,
  required Server server
}) {
  return http.get(
    Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control$urlPath"),
    headers: {
      'Authorization': 'Basic ${server.authToken}'
    },
  ).timeout(const Duration(seconds: 10));
}

Future<http.Response> postRequest({
  required String urlPath, 
  required Server server, 
  Map<String, dynamic>? body,
  String? stringBody
}) {
  return http.post(
    Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control$urlPath"),
    headers: {
      'Authorization': 'Basic ${server.authToken}'
    },
    body: body ?? stringBody
  ).timeout(const Duration(seconds: 10));
}

Future login(Server server) async {
  try {
    final result = await postRequest(
      urlPath: '/login', 
      server: server,
      body: {
        "name": server.user,
        "password": server.password
      }
    );
    
    if (result.statusCode == 200) {
      return {'result': 'success'};
    }
    else if (result.statusCode == 400) {
      return {
        'result': 'invalid_username_password',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'invalid_username_password',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
    else if (result.statusCode == 429) {
      return {
        'result': 'many_attempts',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'many_attempts',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
    else {
      return {
        'result': 'error', 
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
  } on SocketException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'login', 
        dateTime: DateTime.now(), 
        message: 'SocketException'
      )
    };
  } on TimeoutException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'login', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } on HandshakeException {
    return {
      'result': 'ssl_error', 
      'message': 'HandshakeException',
      'log': AppLog(
        type: 'login', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } catch (e) {
    return {
      'result': 'error', 
      'log': AppLog(
        type: 'login', 
        dateTime: DateTime.now(), 
        message: e.toString()
      )
    };
  }
}

Future getServerStatus(Server server) async {
  try {
    final result = await Future.wait([
      getRequest(urlPath: '/stats', server: server),
      getRequest(urlPath: '/status', server: server),
      getRequest(urlPath: '/filtering/status', server: server),
      getRequest(urlPath: '/safesearch/status', server: server),
      getRequest(urlPath: '/safebrowsing/status', server: server),
      getRequest(urlPath: '/parental/status', server: server),
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

Future updateFiltering(Server server, bool enable) async {
  try {
    final result = await postRequest(
      urlPath: '/filtering/config', 
      server: server, 
      body: {
        'enabled': enable
      }
    );

    if (result.statusCode == 200) {
      return {'result': 'success'};
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

Future updateSafeSearch(Server server, bool enable) async {
  try {
    final result = enable == true 
      ? await postRequest(urlPath: '/safesearch/enable', server: server)
      : await postRequest(urlPath: '/safesearch/disable', server: server);

    if (result.statusCode == 200) {
      return {'result': 'success'};
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

Future updateSafeBrowsing(Server server, bool enable) async {
  try {
    final result = enable == true 
      ? await postRequest(urlPath: '/safebrowsing/enable', server: server)
      : await postRequest(urlPath: '/safebrowsing/disable', server: server);

    if (result.statusCode == 200) {
      return {'result': 'success'};
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

Future updateParentalControl(Server server, bool enable) async {
  try {
    final result = enable == true 
      ? await postRequest(urlPath: '/parental/enable', server: server)
      : await postRequest(urlPath: '/parental/disable', server: server);

    if (result.statusCode == 200) {
      return {'result': 'success'};
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

Future updateGeneralProtection(Server server, bool enable) async {
  try {
    final result = await postRequest(
      urlPath: '/dns_config', 
      server: server,
      body: {
        'protection_enabled': enable
      }
    );

    if (result.statusCode == 200) {
      return {'result': 'success'};
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

Future getClients(Server server) async {
  try {
    final result = await Future.wait([
      getRequest(urlPath: '/clients', server: server),
      getRequest(urlPath: '/access/list', server: server),
    ]);

    if (result[0].statusCode == 200 && result[1].statusCode == 200) {
      final clients = ClientsData.fromJson(jsonDecode(result[0].body));
      clients.clientsAllowedBlocked = ClientsAllowedBlocked.fromJson(jsonDecode(result[1].body));
      return {
        'result': 'success',
        'data': clients
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

Future requestAllowedBlockedClientsHosts(Server server, Map<String, List<String>?> body) async {
  try {
    final result = await postRequest(
      urlPath: '/access/set', 
      server: server,
      body: body
    );
    
    if (result.statusCode == 200) {
      return {'result': 'success'};
    }
    else if (result.statusCode == 400) {
      return {
        'result': 'error',
        'message': 'client_another_list'
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

Future getLogs({
  required Server server, 
  required int count, 
  int? offset,
  DateTime? olderThan,
  String? responseStatus,
}) async {
    final result = await getRequest(
      urlPath: '/querylog?limit=$count${offset != null ? '&offset=$offset' : ''}${olderThan != null ? '&older_than=${olderThan.toIso8601String()}' : ''}${responseStatus != null ? '&response_status=$responseStatus' : ''}', 
      server: server
    );
    
    if (result.statusCode == 200) {
      return {
        'result': 'success',
        'data': LogsData.fromJson(jsonDecode(result.body))
      };
    }
    else {
      return {
        'result': 'error', 
        'log': AppLog(
          type: 'logs', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
  try {
  } on SocketException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'logs', 
        dateTime: DateTime.now(), 
        message: 'SocketException'
      )
    };
  } on TimeoutException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'logs', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } on HandshakeException {
    return {
      'result': 'ssl_error', 
      'message': 'HandshakeException',
      'log': AppLog(
        type: 'logs', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } catch (e) {
    return {
      'result': 'error', 
      'log': AppLog(
        type: 'logs', 
        dateTime: DateTime.now(), 
        message: e.toString()
      )
    };
  }
}

Future getFilteringRules({
  required Server server, 
}) async {
  try {
    final result = await getRequest(
      urlPath: '/filtering/status', 
      server: server
    );
    
    if (result.statusCode == 200) {
      return {
        'result': 'success',
        'data': FilteringStatus.fromJson(jsonDecode(result.body))
      };
    }
    else {
      return {
        'result': 'error', 
        'log': AppLog(
          type: 'filtering_status', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
  } on SocketException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'filtering_status', 
        dateTime: DateTime.now(), 
        message: 'SocketException'
      )
    };
  } on TimeoutException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'filtering_status', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } on HandshakeException {
    return {
      'result': 'ssl_error', 
      'message': 'HandshakeException',
      'log': AppLog(
        type: 'filtering_status', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } catch (e) {
    return {
      'result': 'error', 
      'log': AppLog(
        type: 'filtering_status', 
        dateTime: DateTime.now(), 
        message: e.toString()
      )
    };
  }
}

Future postFilteringRules({
  required Server server, 
  required String data, 
}) async {
  try {
    final result = await postRequest(
      urlPath: '/filtering/set_rules', 
      server: server,
      stringBody: data
    );
    
    if (result.statusCode == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error', 
        'log': AppLog(
          type: 'filtering_set_rules', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result.statusCode,
          resBody: result.body
        )
      };
    }
  } on SocketException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'filtering_set_rules', 
        dateTime: DateTime.now(), 
        message: 'SocketException'
      )
    };
  } on TimeoutException {
    return {
      'result': 'no_connection', 
      'log': AppLog(
        type: 'filtering_set_rules', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } on HandshakeException {
    return {
      'result': 'ssl_error', 
      'message': 'HandshakeException',
      'log': AppLog(
        type: 'filtering_set_rules', 
        dateTime: DateTime.now(), 
        message: 'TimeoutException'
      )
    };
  } catch (e) {
    return {
      'result': 'error', 
      'log': AppLog(
        type: 'filtering_set_rules', 
        dateTime: DateTime.now(), 
        message: e.toString()
      )
    };
  }
}