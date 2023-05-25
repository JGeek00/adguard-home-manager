import 'package:flutter/material.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/dns_info.dart';

class DnsProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  DnsInfo? _dnsInfo;

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  DnsInfo? get dnsInfo {
    return _dnsInfo;
  }

  void setDnsInfoData(DnsInfo data) {
    _dnsInfo = data;
    notifyListeners();
  }

  void setDnsInfoLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  Future<bool> fetchDnsData({
    bool? showLoading
  }) async {
    if (showLoading == true) {
      _loadStatus = LoadStatus.loading;
    }

    final result = await _serversProvider!.apiClient!.getDnsInfo();

    if (result['result'] == 'success') {
      _dnsInfo = result['data'];
      _loadStatus = LoadStatus.loaded;
      notifyListeners();
      return true;
    }
    else {
      if (showLoading == false) {
        _loadStatus = LoadStatus.loaded;
        notifyListeners();
      }
      return false;
    }
  }

  Future<Map<String, dynamic>> savePrivateReverseServersConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient!.setDnsConfig(
      data: value
    );

    if (result['result'] == 'success') {
      DnsInfo data = dnsInfo!;
      if (value['local_ptr_upstreams'] != null) {
        data.localPtrUpstreams = value['local_ptr_upsreams'];
      }
      data.usePrivatePtrResolvers = value['use_private_ptr_resolvers'];
      data.resolveClients = value['resolve_clients'];
      setDnsInfoData(data);
      return { 'success': true };
    }
    else if (result['log'] != null && result['log'].statusCode == '400') {
      return {
        'success': false,
        'error': 400 
      };       
    }
    else {
      return {
        'success': false,
        'error': null 
      }; 
    } 
  }

  Future<Map<String, dynamic>> saveUpstreamDnsConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient!.setDnsConfig(
      data: value
    );

    if (result['result'] == 'success') {
      DnsInfo data = dnsInfo!;
      data.upstreamDns = List<String>.from(value['upstream_dns']);
      data.upstreamMode = value['upstream_mode'];
      setDnsInfoData(data);
      return { 'success': true };
    }
    else if (result['log'] != null && result['log'].statusCode == '400') {
      return {
        'success': false,
        'error': 400 
      };       
    }
    else {
      return {
        'success': false,
        'error': null 
      }; 
    } 
  }

  Future<Map<String, dynamic>> saveBootstrapDnsConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient!.setDnsConfig(
      data: value
    );

    if (result['result'] == 'success') {
      DnsInfo data = dnsInfo!;
      data.bootstrapDns = List<String>.from(value['bootstrap_dns']);
      setDnsInfoData(data);
      return { 'success': true };
    }
    else if (result['log'] != null && result['log'].statusCode == '400') {
      return {
        'success': false,
        'error': 400 
      };       
    }
    else {
      return {
        'success': false,
        'error': null 
      }; 
    } 
  }

  Future<Map<String, dynamic>> saveCacheCacheConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient!.setDnsConfig(
      data: value
    );

    if (result['result'] == 'success') {
      DnsInfo data = dnsInfo!;
      data.cacheSize = value['cache_size'];
      data.cacheTtlMin = value['cache_ttl_min'];
      data.cacheTtlMax = value['cache_ttl_max'];
      data.cacheOptimistic = value['cache_optimistic'];
      setDnsInfoData(data);
      return { 'success': true };
    }
    else if (result['log'] != null && result['log'].statusCode == '400') {
      return {
        'success': false,
        'error': 400 
      };       
    }
    else {
      return {
        'success': false,
        'error': null 
      }; 
    } 
  }
  
  Future<Map<String, dynamic>> saveDnsServerConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient!.setDnsConfig(
      data: value
    );

    if (result['result'] == 'success') {
      DnsInfo data = dnsInfo!;
      data.ratelimit = value['ratelimit'];
      data.ednsCsEnabled = value['edns_cs_enabled'];
      data.dnssecEnabled = value['dnssec_enabled'];
      data.disableIpv6 = value['disable_ipv6'];
      data.blockingMode = value['blocking_mode'];
      data.blockingIpv4 = value['blocking_ipv4'];
      data.blockingIpv6 = value['blocking_ipv6'];
      setDnsInfoData(data);
      return { 'success': true };
    }
    else if (result['log'] != null && result['log'].statusCode == '400') {
      return {
        'success': false,
        'error': 400 
      };       
    }
    else {
      return {
        'success': false,
        'error': null 
      }; 
    } 
  }
}