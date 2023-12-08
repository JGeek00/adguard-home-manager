import 'package:flutter/material.dart';

import 'package:adguard_home_manager/services/api_client.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  DhcpModel? _dhcp;

  DhcpModel? get dhcp {
    return _dhcp;
  }

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  void setDhcpData(DhcpModel data) {
    _dhcp = data;
    notifyListeners();
  }

  void setDhcpLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  Future<bool> loadDhcpStatus({
    bool? showLoading
  }) async {
    if (showLoading == true) {
      _loadStatus = LoadStatus.loading;
      notifyListeners();
    }
    final result = await _serversProvider!.apiClient2!.getDhcpData();
    if (result.successful == true) {
      _dhcp = result.content as DhcpModel;
      _loadStatus = LoadStatus.loaded;
      notifyListeners();
      return true;
    }
    else {
      if (showLoading == true) {
        _loadStatus = LoadStatus.error;
        notifyListeners();
      }
      return false;
    }
  }

  Future<bool> deleteLease(Lease lease) async {
    final result = await _serversProvider!.apiClient2!.deleteStaticLease(
      data: {
        "mac": lease.mac,
        "ip": lease.ip,
        "hostname": lease.hostname
      }
    );

    if (result.successful == true) {
      DhcpModel data = dhcp!;
      data.dhcpStatus!.staticLeases = data.dhcpStatus!.staticLeases.where((l) => l.mac != lease.mac).toList();
      setDhcpData(data);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<ApiResponse> createLease(Lease lease) async {
    final result = await _serversProvider!.apiClient2!.createStaticLease(
      data: {
        "mac": lease.mac,
        "ip": lease.ip,
        "hostname": lease.hostname,
      }
    );

    if (result.successful == true) {
      DhcpModel data = dhcp!;
      data.dhcpStatus!.staticLeases.add(lease);
      setDhcpData(data);
      return result;
    }
    else {
      return result;
    }
  }
} 