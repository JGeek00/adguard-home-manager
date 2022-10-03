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
      'Authorization': 'Basic ${server.authToken}',
      'Content-Type': 'application/json'
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
      "Authorization": "Basic ${server.authToken}",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body)
  ).timeout(const Duration(seconds: 10));
}

Future<Map<String, dynamic>> apiRequest({
  required Server server, 
  required String method, 
  required String urlPath, 
  Map<String, dynamic>? jsonBody,
  String? stringBody,
  bool? withAuth,
}) async {
  try {
    HttpClient httpClient = HttpClient();
    if (method == 'get') {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control$urlPath"));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      if (response.statusCode == 200) {
        return {
          'hasResponse': true,
          'error': false,
          'statusCode': response.statusCode,
          'body': reply
        };
      }
      else {
        return {
          'hasResponse': true,
          'error': true,
          'statusCode': response.statusCode,
          'body': reply
        };
      }    
    }
    else if (method == 'post') {
      HttpClientRequest request = await httpClient.postUrl(Uri.parse("${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}/control$urlPath"));
      
      if (withAuth != null && withAuth == true) {
        request.headers.set('authorization', 'Basic ${server.authToken}');
      }

      request.headers.set('content-type', 'application/json');
      if (jsonBody != null && stringBody == null) {
        request.add(utf8.encode(json.encode(jsonBody)));
      }
      else if (jsonBody == null && stringBody != null) {
        request.write(stringBody);
      }
      else if (jsonBody != null && stringBody != null) {
        throw Exception("Don't add a jsonBody and a stringBody");
      }

      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        return {
          'hasResponse': true,
          'error': false,
          'statusCode': response.statusCode,
          'body': reply
        };
      }
      else {
        return {
          'hasResponse': true,
          'error': true,
          'statusCode': response.statusCode,
          'body': reply
        };
      }    
    }
    else {
      throw Exception('Method is required');
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

Future login(Server server) async {
  final result = await apiRequest(
    server: server,
    method: 'post',
    urlPath: '/login', 
    jsonBody: {
      "name": server.user,
      "password": server.password
    }
  );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else if (result['statusCode'] == 400) {
      return {
        'result': 'invalid_username_password',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'invalid_username_password',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
    else if (result['statusCode'] == 429) {
      return {
        'result': 'many_attempts',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'many_attempts',
          statusCode: result['statusCode'],
          resBody: result['body']
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
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
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
  final result = await apiRequest(
    urlPath: '/filtering/config', 
    method: 'post',
    server: server, 
    jsonBody: {
      'enabled': enable
    },
    withAuth: true
  );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}

Future updateSafeSearch(Server server, bool enable) async {
  final result = enable == true 
    ? await apiRequest(
        urlPath: '/safesearch/enable', 
        method: 'post',
        server: server, 
        withAuth: true
      )
    : await apiRequest(
        urlPath: '/safesearch/disable', 
        method: 'post',
        server: server, 
        withAuth: true
      );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}

Future updateSafeBrowsing(Server server, bool enable) async {
  final result = enable == true 
    ? await apiRequest(
        urlPath: '/safebrowsing/enable', 
        method: 'post',
        server: server, 
        withAuth: true
      )
    : await apiRequest(
        urlPath: '/safebrowsing/disable', 
        method: 'post',
        server: server, 
        withAuth: true
      );
print(result);
  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}

Future updateParentalControl(Server server, bool enable) async {
  final result = enable == true 
    ? await apiRequest(
        urlPath: '/parental/enable', 
        method: 'post',
        server: server, 
        withAuth: true
      )
    : await apiRequest(
        urlPath: '/parental/disable', 
        method: 'post',
        server: server, 
        withAuth: true
      );
print(result);
  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}

Future updateGeneralProtection(Server server, bool enable) async {
    final result = await apiRequest(
    urlPath: '/dns_config', 
    method: 'post',
    server: server, 
    jsonBody: {
      'protection_enabled': enable
    },
    withAuth: true
  );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
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
  final result = await apiRequest(
    urlPath: '/access/set', 
    method: 'post',
    server: server, 
    jsonBody: body,
    withAuth: true
  );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    if (result['statusCode'] == 400) {
      return {
        'result': 'error',
        'message': 'client_another_list'
      };
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}

Future getLogs({
  required Server server, 
  required int count, 
  int? offset,
  DateTime? olderThan,
  String? responseStatus,
  String? search
}) async {
  try {
    final result = await getRequest(
      urlPath: '/querylog?limit=$count${offset != null ? '&offset=$offset' : ''}${olderThan != null ? '&older_than=${olderThan.toIso8601String()}' : ''}${responseStatus != null ? '&response_status=$responseStatus' : ''}${search != null ? '&search=$search' : ''}', 
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
    final result = await apiRequest(
    urlPath: '/filtering/set_rules', 
    method: 'post',
    server: server, 
    stringBody: data,
    withAuth: true
  );

  if (result['hasResponse'] == true) {
    if (result['statusCode'] == 200) {
      return {'result': 'success'};
    }
    else {
      return {
        'result': 'error',
        'log': AppLog(
          type: 'login', 
          dateTime: DateTime.now(), 
          message: 'error_code_not_expected',
          statusCode: result['statusCode'],
          resBody: result['body']
        )
      };
    }
  }
  else {
    return result;
  }
}