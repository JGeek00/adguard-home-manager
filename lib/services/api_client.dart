import 'dart:convert';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/models/encryption.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/models/server_info.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/classes/http_client.dart';

class ApiResponse {
  final bool successful;
  final dynamic content;
  final int? statusCode;

  const ApiResponse({
    required this.successful,
    this.content,
    this.statusCode,
  });
}

class ApiClientV2 {
  final Server server;

  ApiClientV2({
    required this.server
  });

  Future<ApiResponse> getServerVersion() async {
    final result = await HttpRequestClient.get(urlPath: '/status', server: server);
    if (result.successful == true) {
      try {
        return ApiResponse(
          successful: true,
          content: jsonDecode(result.body!)['version']
        );
      } on FormatException {
        return const ApiResponse(successful: false);
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> getServerStatus() async {
    final results = await Future.wait([
      HttpRequestClient.get(urlPath: "/stats", server: server),
      HttpRequestClient.get(urlPath: "/status", server: server),
      HttpRequestClient.get(urlPath: "/filtering/status", server: server),
      HttpRequestClient.get(urlPath: "/safesearch/status", server: server),
      HttpRequestClient.get(urlPath: "/safebrowsing/status", server: server),
      HttpRequestClient.get(urlPath: "/parental/status", server: server),
      HttpRequestClient.get(urlPath: "/clients", server: server),
    ]);
    if (
      results.map((e) => e.successful).every((e) => e == true) &&
      results.map((e) => e.body).every((e) => e != null)
    ) {
      try {
        final Map<String, dynamic> mappedData = {
          'stats': jsonDecode(results[0].body!),
          'clients': jsonDecode(results[6].body!)['clients'],
          'status': jsonDecode(results[1].body!),
          'filtering': jsonDecode(results[2].body!),
          'safeSearch': jsonDecode(results[3].body!),
          'safeBrowsingEnabled': jsonDecode(results[4].body!),
          'parentalControlEnabled': jsonDecode(results[5].body!),
        };
        return ApiResponse(
          successful: true,
          content: ServerStatus.fromJson(mappedData)
        );
      } on FormatException {
        return const ApiResponse(successful: false);
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> updateFiltering({
    required bool enable
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: "/filtering/config", 
      server: server,
      body: {
        'enabled': enable
      }
    );
    return ApiResponse(
      successful: result.successful,
    );
  }

  Future<ApiResponse> updateSafeBrowsing({
    required bool enable
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: enable == true
        ? "/safebrowsing/enable"
        : "/safebrowsing/disable", 
      server: server,
    );
    return ApiResponse(
      successful: result.successful,
    );
  }

  Future<ApiResponse> updateParentalControl({
    required bool enable
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: enable == true
        ? "/parental/enable"
        : "/parental/disable", 
      server: server,
    );
    return ApiResponse(
      successful: result.successful,
    );
  }

  Future<ApiResponse> updateGeneralProtection({
    required bool enable,
    int? time,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: "/protection", 
      server: server,
      body: {
        'enabled': enable,
        'duration': time
      }
    );
    return ApiResponse(
      successful: result.successful,
    );
  }

  Future<ApiResponse> getClients() async {
    final results = await Future.wait([
      HttpRequestClient.get(urlPath: "/clients", server: server),
      HttpRequestClient.get(urlPath: "/access/list", server: server),
    ]);
    if (
      results.map((e) => e.successful).every((e) => e == true) &&
      results.map((e) => e.body).every((e) => e != null)
    ) {
      try {
        final clients = Clients.fromJson(jsonDecode(results[0].body!));
        clients.clientsAllowedBlocked = ClientsAllowedBlocked.fromJson(jsonDecode(results[1].body!));
        return ApiResponse(
          successful: true,
          content: clients
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": results.map((e) => e.statusCode.toString()) })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> requestAllowedBlockedClientsHosts({
    required Map<String, List<String>?> body
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: "/access/set",
      server: server,
      body: body
    );
    if (result.statusCode == 400) {
      return const ApiResponse(
        successful: false,
        content: "client_another_list"
      );
    }
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getLogs({
    required int count, 
    int? offset,
    DateTime? olderThan,
    String? responseStatus,
    String? search
  }) async {
    final result = await HttpRequestClient.get(
      urlPath: '/querylog?limit=$count${offset != null ? '&offset=$offset' : ''}${olderThan != null ? '&older_than=${olderThan.toIso8601String()}' : ''}${responseStatus != null ? '&response_status=$responseStatus' : ''}${search != null ? '&search=$search' : ''}', 
      server: server
    );
    if (result.successful == true) {
      try {
        return ApiResponse(
          successful: true,
          content: LogsData.fromJson(jsonDecode(result.body!))
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> getFilteringRules() async {
    final result = await HttpRequestClient.get(urlPath: '/filtering/status', server: server);
    if (result.successful == true) {
      try {
        return ApiResponse(
          successful: true,
          content: FilteringStatus.fromJson(jsonDecode(result.body!))
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> postFilteringRules({
    required Map<String, List<String>> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/set_rules', 
      server: server,
      body: data
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> postAddClient({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/clients/add', 
      server: server,
      body: data
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> postUpdateClient({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/clients/update', 
      server: server,
      body: data
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> postDeleteClient({
    required String name, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/clients/delete', 
      server: server,
      body: {'name': name},
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getFiltering() async {
    final results = await Future.wait([
      HttpRequestClient.get(urlPath: '/filtering/status', server: server),
      HttpRequestClient.get(urlPath: '/blocked_services/list', server: server),
    ]);
    if (results[0].successful == true && results[0].body != null) {
      try {
        return ApiResponse(
          successful: true,
          content: Filtering.fromJson({
            ...jsonDecode(results[0].body!),
            "blocked_services": results[1].body != null 
              ? jsonDecode(results[1].body!)
              : []
          })
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": results.map((e) => e.statusCode.toString()) })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> setCustomRules({
    required List<String> rules, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/set_rules', 
      server: server,
      body: {'rules': rules},
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> addFilteringList({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/add_url', 
      server: server,
      body: data,
    );
    return ApiResponse(
      successful: result.successful,
      content: result.body,
      statusCode: result.statusCode
    );
  }

  Future<ApiResponse> updateFilterList({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/set_url', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> deleteFilterList({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/remove_url', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getServerInfo() async {
    final result = await HttpRequestClient.get(urlPath: "/status", server: server);
    if (result.successful) {
      try {
        return ApiResponse(
          successful: true,
          content: ServerInfoData.fromJson(jsonDecode(result.body!))
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> updateLists() async {
    final results = await Future.wait([
      HttpRequestClient.post(
        urlPath: '/filtering/refresh', 
        server: server,
        body: {'whitelist': true},
      ),
      HttpRequestClient.post(
        urlPath: '/filtering/refresh', 
        server: server,
        body: {'whitelist': false},
      ),
    ]);
    if (
      results.map((e) => e.successful).every((e) => e == true) &&
      results.map((e) => e.body).every((e) => e != null)
    ) {
      try {
        final clients = Clients.fromJson(jsonDecode(results[0].body!));
        clients.clientsAllowedBlocked = ClientsAllowedBlocked.fromJson(jsonDecode(results[1].body!));
        return ApiResponse(
          successful: true,
          content: {'updated': jsonDecode(results[0].body!)['updated']+jsonDecode(results[1].body!)['updated']} 
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": results.map((e) => e.statusCode.toString()) })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> checkHostFiltered({
    required String host
  }) async {
    final result = await HttpRequestClient.get(urlPath: '/filtering/check_host?name=$host', server: server);
    if (result.successful) {
      return ApiResponse(
        successful: true,
        content: jsonDecode(result.body!)
      );
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> requestChangeUpdateFrequency({
    required Map<String, dynamic> data, 
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/filtering/config', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> setBlockedServices({
    required List<String> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/blocked_services/set', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getDhcpData() async {
    final results = await Future.wait([
      HttpRequestClient.get(urlPath: '/dhcp/interfaces', server: server),
      HttpRequestClient.get(urlPath: '/dhcp/status', server: server),
    ]);
    if (
      results.map((e) => e.successful).every((e) => e == true) &&
      results.map((e) => e.body).every((e) => e != null)
    ) {
      try {
        List<NetworkInterface> interfaces = List<NetworkInterface>.from(jsonDecode(results[0].body!).entries.map((entry) => NetworkInterface.fromJson(entry.value)));
        return ApiResponse(
          successful: true,
          content: DhcpModel(
            dhcpAvailable: jsonDecode(results[1].body!)['message'] != null
              ? false
              : true,
            networkInterfaces: interfaces, 
            dhcpStatus: jsonDecode(results[1].body!)['message'] != null
              ? null
              : DhcpStatus.fromJson(jsonDecode(results[1].body!))
          )
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": results.map((e) => e.statusCode.toString()) })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> saveDhcpConfig({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/dhcp/set_config', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> resetDhcpConfig() async {
    final result = await HttpRequestClient.post(
      urlPath: '/dhcp/reset', 
      server: server,
      body: {},
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> deleteStaticLease({
    required Map<String, dynamic> data
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/dhcp/remove_static_lease', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> createStaticLease({
    required Map<String, dynamic> data
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/dhcp/add_static_lease', 
      server: server,
      body: data,
    );
    if (result.statusCode == 400 && result.body != null && result.body!.contains('static lease already exists')) {
      return const ApiResponse(
        successful: false,
        content: "already_exists",
        statusCode: 400
      );
    }
    if (result.statusCode == 400 && result.body != null && result.body!.contains('server is unconfigured')) {
      return const ApiResponse(
        successful: false,
        content: "server_not_configured",
        statusCode: 400
      );
    }
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> restoreAllLeases() async {
    final result = await HttpRequestClient.post(
      urlPath: '/dhcp/reset_leases', 
      server: server,
      body: {},
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getDnsRewriteRules() async {
    final result = await HttpRequestClient.get(urlPath: '/rewrite/list', server: server);
    if (result.successful) {
      try {
        final List<RewriteRules> data = List<RewriteRules>.from(
          jsonDecode(result.body!).map((item) => RewriteRules.fromJson(item))
        );
        return ApiResponse(
          successful: true,
          content: data
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> deleteDnsRewriteRule({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/rewrite/delete', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> addDnsRewriteRule({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/rewrite/add', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getQueryLogInfo() async {
    final result = await HttpRequestClient.get(urlPath: '/querylog/config', server: server);
    if (result.successful) {
      return ApiResponse(
        successful: true,
        content: jsonDecode(result.body!) 
      );
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> updateQueryLogParameters({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.put(
      urlPath: '/querylog/config/update', 
      server: server,
      body: data,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> clearLogs() async {
    final result = await HttpRequestClient.post(
      urlPath: '/querylog_clear', 
      server: server,
      body: {},
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getDnsInfo() async {
    final result = await HttpRequestClient.get(urlPath: '/dns_info', server: server);
    if (result.successful) {
      try {
        return ApiResponse(
          successful: true,
          content: DnsInfo.fromJson(jsonDecode(result.body!))
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> setDnsConfig({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/dns_config', 
      server: server,
      body: data,
    );
    if (result.statusCode == 400) {
      return ApiResponse(
        successful: result.successful,
        content: "data_not_valid",
        statusCode: result.statusCode
      );
    }
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> getEncryptionSettings() async {
    final result = await HttpRequestClient.get(urlPath: '/tls/status', server: server);
    if (result.successful) {
      try {
        return ApiResponse(
          successful: true,
          content: EncryptionData.fromJson(jsonDecode(result.body!))
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> getBlockedServices() async {
    final result = await HttpRequestClient.get(urlPath: '/blocked_services/all', server: server);
    if (result.successful) {
      try {
        return ApiResponse(
          successful: true,
          content: List<BlockedService>.from(
            BlockedServicesFromApi.fromJson(jsonDecode(result.body!)).blockedServices
          )
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> checkEncryptionSettings({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/tls/validate', 
      server: server,
      body: data,
    );
    try {
      return ApiResponse(
        successful: result.successful,
        content: result.body != null ? EncryptionValidationResult(
          isObject: true,
          encryptionValidation: EncryptionValidation.fromJson(jsonDecode(result.body!))
        ) : null
      );
    } on FormatException {
      return ApiResponse(
        successful: result.successful,
        content: result.body != null ? EncryptionValidationResult(
          isObject: false,
          message: result.body
        ) : null
      );
    } catch (e, stackTrace) {
      Sentry.captureException(
        e, 
        stackTrace: stackTrace, 
        hint: Hint.withMap({ "statusCode": result.statusCode.toString() })
      );
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> saveEncryptionSettings({
    required Map<String, dynamic> data,
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/tls/configure', 
      server: server,
      body: data,
    );
    return ApiResponse(
      successful: result.successful,
      content: result.body
    );
  }

  Future<ApiResponse> resetDnsCache() async {
    final result = await HttpRequestClient.post(
      urlPath: '/cache_clear', 
      server: server,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> checkServerUpdates() async {
    final results = await Future.wait([
      HttpRequestClient.post(urlPath: '/version.json', server: server, body: { "recheck_now": true }),
      HttpRequestClient.get(urlPath: '/status', server: server),
    ]);
    if (
      results.map((e) => e.successful).every((e) => e == true) &&
      results.map((e) => e.body).every((e) => e != null)
    ) {
      try {
        final Map<String, dynamic> obj = {
          ...jsonDecode(results[0].body!),
          'current_version': ServerInfoData.fromJson(jsonDecode(results[1].body!)).version
        };
        return ApiResponse(
          successful: true,
          content: obj
        );
      } catch (e, stackTrace) {
        Sentry.captureException(
          e, 
          stackTrace: stackTrace, 
          hint: Hint.withMap({ "statusCode": results.map((e) => e.statusCode.toString()) })
        );
        return const ApiResponse(successful: false);
      }
    }
    else {
      return const ApiResponse(successful: false);
    }
  }

  Future<ApiResponse> requestUpdateServer() async {
    final result = await HttpRequestClient.post(
      urlPath: '/update', 
      server: server,
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> updateSafeSearchSettings({
    required Map<String, bool> body
  }) async {
    final result = await HttpRequestClient.put(
      urlPath: '/safesearch/settings', 
      server: server,
      body: body
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> updateRewriteRule({
    required Map<String, dynamic> body
  }) async {
    final result = await HttpRequestClient.put(
      urlPath: '/rewrite/update', 
      server: server,
      body: body
    );
    return ApiResponse(successful: result.successful);
  }

  Future<ApiResponse> testUpstreamDns({
    required Map<String, dynamic> body
  }) async {
    final result = await HttpRequestClient.post(
      urlPath: '/test_upstream_dns', 
      server: server,
      body: body
    );
    return ApiResponse(
      successful: result.successful,
      content: result.body != null ? jsonDecode(result.body!) : null
    );
  }
}