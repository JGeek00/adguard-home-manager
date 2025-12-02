import 'package:flutter/material.dart';
import 'package:adguard_home_manager/models/adguard_dns/account_limits.dart';
import 'package:adguard_home_manager/models/adguard_dns/device.dart';
import 'package:adguard_home_manager/models/adguard_dns/dns_server.dart';
import 'package:adguard_home_manager/models/adguard_dns/filter_list.dart';
import 'package:adguard_home_manager/models/adguard_dns/query_log.dart';
import 'package:adguard_home_manager/services/adguard_dns_api.dart';
import 'package:adguard_home_manager/models/server.dart';

class PrivateDnsProvider with ChangeNotifier {
  AdGuardDNSApi? _apiClient;

  // Data
  AccountLimits? _accountLimits;
  List<Device> _devices = [];
  List<DnsServer> _dnsServers = [];
  List<FilterList> _filterLists = [];
  QueryLogResponse? _queryLog;

  // Loading states
  bool _loadingDevices = false;
  bool _loadingDnsServers = false;
  bool _loadingFilterLists = false;
  bool _loadingAccountLimits = false;
  bool _loadingQueryLog = false;

  // Getters
  AccountLimits? get accountLimits => _accountLimits;
  List<Device> get devices => _devices;
  List<DnsServer> get dnsServers => _dnsServers;
  List<FilterList> get filterLists => _filterLists;
  QueryLogResponse? get queryLog => _queryLog;

  bool get loadingDevices => _loadingDevices;
  bool get loadingDnsServers => _loadingDnsServers;
  bool get loadingFilterLists => _loadingFilterLists;
  bool get loadingAccountLimits => _loadingAccountLimits;
  bool get loadingQueryLog => _loadingQueryLog;

  void initializeClient(Server server) {
    if (server.authToken != null) {
      _apiClient = AdGuardDNSApi(apiKey: server.authToken!);
    }
  }

  Future<void> fetchData() async {
    if (_apiClient == null) return;

    await Future.wait([
      fetchAccountLimits(),
      fetchDevices(),
      fetchDnsServers(),
      fetchFilterLists(),
    ]);
  }

  Future<void> fetchAccountLimits() async {
    _loadingAccountLimits = true;
    notifyListeners();
    try {
      _accountLimits = await _apiClient!.getAccountLimits();
    } catch (e) {
      print('Error fetching account limits: $e');
    } finally {
      _loadingAccountLimits = false;
      notifyListeners();
    }
  }

  Future<void> fetchDevices() async {
    _loadingDevices = true;
    notifyListeners();
    try {
      _devices = await _apiClient!.listDevices();
    } catch (e) {
      print('Error fetching devices: $e');
    } finally {
      _loadingDevices = false;
      notifyListeners();
    }
  }

  Future<bool> createDevice(Map<String, dynamic> data) async {
    try {
      await _apiClient!.createDevice(data);
      await fetchDevices();
      await fetchAccountLimits();
      return true;
    } catch (e) {
      print('Error creating device: $e');
      return false;
    }
  }

  Future<bool> updateDevice(String id, Map<String, dynamic> data) async {
    try {
      await _apiClient!.updateDevice(id, data);
      await fetchDevices();
      return true;
    } catch (e) {
      print('Error updating device: $e');
      return false;
    }
  }

  Future<bool> deleteDevice(String id) async {
    try {
      await _apiClient!.deleteDevice(id);
      await fetchDevices();
      await fetchAccountLimits();
      return true;
    } catch (e) {
      print('Error deleting device: $e');
      return false;
    }
  }

  Future<void> fetchDnsServers() async {
    _loadingDnsServers = true;
    notifyListeners();
    try {
      _dnsServers = await _apiClient!.listDnsServers();
    } catch (e) {
      print('Error fetching DNS servers: $e');
    } finally {
      _loadingDnsServers = false;
      notifyListeners();
    }
  }

  Future<bool> createDnsServer(Map<String, dynamic> data) async {
    try {
      await _apiClient!.createDnsServer(data);
      await fetchDnsServers();
      await fetchAccountLimits();
      return true;
    } catch (e) {
      print('Error creating DNS server: $e');
      return false;
    }
  }

  Future<bool> updateDnsServer(String id, Map<String, dynamic> data) async {
    try {
      await _apiClient!.updateDnsServer(id, data);
      await fetchDnsServers();
      return true;
    } catch (e) {
      print('Error updating DNS server: $e');
      return false;
    }
  }

  Future<bool> deleteDnsServer(String id) async {
    try {
      await _apiClient!.deleteDnsServer(id);
      await fetchDnsServers();
      await fetchAccountLimits();
      return true;
    } catch (e) {
      print('Error deleting DNS server: $e');
      return false;
    }
  }

  Future<void> fetchFilterLists() async {
    _loadingFilterLists = true;
    notifyListeners();
    try {
      _filterLists = await _apiClient!.listFilterLists();
    } catch (e) {
      print('Error fetching filter lists: $e');
    } finally {
      _loadingFilterLists = false;
      notifyListeners();
    }
  }

  Future<void> fetchQueryLog({int? limit, String? search}) async {
    _loadingQueryLog = true;
    notifyListeners();
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final oneDayAgo = now - 86400000;
      _queryLog = await _apiClient!.getQueryLog(
        timeFromMillis: oneDayAgo,
        timeToMillis: now,
        limit: limit ?? 20,
        search: search
      );
    } catch (e) {
      print('Error fetching query log: $e');
    } finally {
      _loadingQueryLog = false;
      notifyListeners();
    }
  }
}
