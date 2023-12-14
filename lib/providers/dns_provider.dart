import 'package:flutter/material.dart';

import 'package:adguard_home_manager/services/api_client.dart';
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

    final result = await _serversProvider!.apiClient2!.getDnsInfo();

    if (result.successful == true) {
      _dnsInfo = result.content as DnsInfo;
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

  Future<ApiResponse> savePrivateReverseServersConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      if (value['local_ptr_upstreams'] != null) {
        data.localPtrUpstreams = value['local_ptr_upstreams'];
      }
      data.usePrivatePtrResolvers = value['use_private_ptr_resolvers'];
      data.resolveClients = value['resolve_clients'];
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }

  Future<ApiResponse> saveUpstreamDnsConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      data.upstreamDns = List<String>.from(value['upstream_dns']);
      data.upstreamMode = value['upstream_mode'];
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }

  Future<ApiResponse> saveBootstrapDnsConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      data.bootstrapDns = List<String>.from(value['bootstrap_dns']);
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }

  Future<ApiResponse> saveFallbackDnsConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      data.bootstrapDns = List<String>.from(value['fallback_dns']);
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }

  Future<ApiResponse> saveCacheCacheConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      data.cacheSize = value['cache_size'];
      data.cacheTtlMin = value['cache_ttl_min'];
      data.cacheTtlMax = value['cache_ttl_max'];
      data.cacheOptimistic = value['cache_optimistic'];
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }
  
  Future<ApiResponse> saveDnsServerConfig(Map<String, dynamic> value) async {
    final result = await _serversProvider!.apiClient2!.setDnsConfig(
      data: value
    );

    if (result.successful == true) {
      DnsInfo data = dnsInfo!;
      data.ratelimit = value['ratelimit'];
      data.ednsCsEnabled = value['edns_cs_enabled'];
      data.dnssecEnabled = value['dnssec_enabled'];
      data.disableIpv6 = value['disable_ipv6'];
      data.blockingMode = value['blocking_mode'];
      data.blockingIpv4 = value['blocking_ipv4'];
      data.blockingIpv6 = value['blocking_ipv6'];
      data.blockedResponseTtl = value['blocked_response_ttl'];
      setDnsInfoData(data);
      return result;
    }
    else {
      return result;
    }
  }
}