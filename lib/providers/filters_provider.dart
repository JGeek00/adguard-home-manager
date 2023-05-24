import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class FilteringProvider with ChangeNotifier {
  StatusProvider? _statusProvider;

  updateStatus(StatusProvider? statusProvider) {
    if (statusProvider != null) {
      _statusProvider = statusProvider;
    }
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  Filtering? _filtering;
  LoadStatus _blockedServicesLoadStatus = LoadStatus.loading;
  BlockedServices? _blockedServicesList;

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  Filtering? get filtering {
    return _filtering;
  }

  LoadStatus get blockedServicesLoadStatus {
    return _blockedServicesLoadStatus;
  }

  BlockedServices? get blockedServices {
    return _blockedServicesList;
  }

  void setFilteringData(Filtering data) {
    _filtering = data;
    notifyListeners();
  }

  void setFilteringLoadStatus(LoadStatus loadStatus, bool notify) {
    _loadStatus = loadStatus;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setFilteringProtectionStatus(bool status) {
    _statusProvider!.setFilteringEnabledStatus(status);
    _filtering!.enabled = status;
    notifyListeners();
  }

  void setFiltersUpdateFrequency(int frequency) {
    if (_filtering != null) {
      _filtering!.interval = frequency;
      notifyListeners();
    }
  }

  void setBlockedServices(List<String> blockedServices) {
    if (_filtering != null) {
      _filtering!.blockedServices = blockedServices;
      notifyListeners();
    }
  }

  void setBlockedServiceListData(List<BlockedService> data) {
    _blockedServicesList = BlockedServices(services: data);
    notifyListeners();
  }

  void setBlockedServicesListLoadStatus(LoadStatus status, bool notify) {
    _blockedServicesLoadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
}