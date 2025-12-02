import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:adguard_home_manager/models/adguard_dns/account_limits.dart';
import 'package:adguard_home_manager/models/adguard_dns/device.dart';
import 'package:adguard_home_manager/models/adguard_dns/dns_server.dart';
import 'package:adguard_home_manager/models/adguard_dns/filter_list.dart';
import 'package:adguard_home_manager/models/adguard_dns/query_log.dart';
import 'package:adguard_home_manager/models/adguard_dns/statistics.dart';

class AdGuardDNSApi {
  final String baseUrl = 'https://api.adguard-dns.io/oapi/v1';
  final String apiKey;

  AdGuardDNSApi({required this.apiKey});

  Map<String, String> get _headers => {
    'Authorization': 'ApiKey $apiKey',
    'Content-Type': 'application/json',
  };

  Future<AccountLimits> getAccountLimits() async {
    final response = await http.get(Uri.parse('$baseUrl/account/limits'), headers: _headers);
    if (response.statusCode == 200) {
      return AccountLimits.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load account limits: ${response.body}');
    }
  }

  Future<List<Device>> listDevices() async {
    final response = await http.get(Uri.parse('$baseUrl/devices'), headers: _headers);
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Device.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load devices: ${response.body}');
    }
  }

  Future<Device> createDevice(Map<String, dynamic> deviceCreate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/devices'),
      headers: _headers,
      body: jsonEncode(deviceCreate),
    );
    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create device: ${response.body}');
    }
  }

  Future<Device> updateDevice(String deviceId, Map<String, dynamic> deviceUpdate) async {
    final response = await http.put(
      Uri.parse('$baseUrl/devices/$deviceId'),
      headers: _headers,
      body: jsonEncode(deviceUpdate),
    );
    if (response.statusCode == 200) {
      // The API returns 200 OK on success, but documentation says "Device updated" description.
      // It might not return the device object. Let's fetch it again or assume success.
      // Based on Swagger, it says "Device updated" (no content schema specified for 200).
      // But getDevice returns Device.
      return getDevice(deviceId);
    } else {
      throw Exception('Failed to update device: ${response.body}');
    }
  }

  Future<Device> getDevice(String deviceId) async {
    final response = await http.get(Uri.parse('$baseUrl/devices/$deviceId'), headers: _headers);
    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get device: ${response.body}');
    }
  }

  Future<void> deleteDevice(String deviceId) async {
    final response = await http.delete(Uri.parse('$baseUrl/devices/$deviceId'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete device: ${response.body}');
    }
  }

  Future<List<DnsServer>> listDnsServers() async {
    final response = await http.get(Uri.parse('$baseUrl/dns_servers'), headers: _headers);
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => DnsServer.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load DNS servers: ${response.body}');
    }
  }

  Future<DnsServer> createDnsServer(Map<String, dynamic> dnsServerCreate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/dns_servers'),
      headers: _headers,
      body: jsonEncode(dnsServerCreate),
    );
    if (response.statusCode == 200) {
      return DnsServer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create DNS server: ${response.body}');
    }
  }

  Future<DnsServer> updateDnsServer(String dnsServerId, Map<String, dynamic> dnsServerUpdate) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dns_servers/$dnsServerId'),
      headers: _headers,
      body: jsonEncode(dnsServerUpdate),
    );
    if (response.statusCode == 200) {
        return getDnsServer(dnsServerId);
    } else {
      throw Exception('Failed to update DNS server: ${response.body}');
    }
  }

  Future<DnsServer> getDnsServer(String dnsServerId) async {
    final response = await http.get(Uri.parse('$baseUrl/dns_servers/$dnsServerId'), headers: _headers);
    if (response.statusCode == 200) {
      return DnsServer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get DNS server: ${response.body}');
    }
  }

  Future<void> deleteDnsServer(String dnsServerId) async {
    final response = await http.delete(Uri.parse('$baseUrl/dns_servers/$dnsServerId'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete DNS server: ${response.body}');
    }
  }

  Future<List<FilterList>> listFilterLists() async {
    final response = await http.get(Uri.parse('$baseUrl/filter_lists'), headers: _headers);
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => FilterList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load filter lists: ${response.body}');
    }
  }

  Future<QueryLogResponse> getQueryLog({
    required int timeFromMillis,
    required int timeToMillis,
    int? limit,
    String? cursor,
    String? search,
  }) async {
    final queryParams = {
      'time_from_millis': timeFromMillis.toString(),
      'time_to_millis': timeToMillis.toString(),
      if (limit != null) 'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
      if (search != null) 'search': search,
    };
    final uri = Uri.parse('$baseUrl/query_log').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      return QueryLogResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load query log: ${response.body}');
    }
  }

  Future<CategoryQueriesStatsList> getCategoryQueriesStats({
    required int timeFromMillis,
    required int timeToMillis,
  }) async {
    final queryParams = {
      'time_from_millis': timeFromMillis.toString(),
      'time_to_millis': timeToMillis.toString(),
    };
    final uri = Uri.parse('$baseUrl/stats/categories').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      return CategoryQueriesStatsList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load category stats: ${response.body}');
    }
  }

  // Add more stats methods as needed
}
