import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/functions/time_server_disabled.dart';

class StatusProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  ServerStatus? _serverStatus; // serverStatus != null means server is connected
  List<String> _protectionsManagementProcess = []; // protections that are currenty being enabled or disabled
  FilteringStatus? _filteringStatus;

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  ServerStatus? get serverStatus {
    return _serverStatus;
  }

  List<String> get protectionsManagementProcess {
    return _protectionsManagementProcess;
  }

  FilteringStatus? get filteringStatus {
    return _filteringStatus;
  }

  void setServerStatusData({
    required ServerStatus data,
  }) {
    _serverStatus = data;
    notifyListeners();
  }

  void setServerStatusLoad(LoadStatus status) {
    _loadStatus = status;
    notifyListeners();
  }

  void setFilteringStatus(FilteringStatus status) {
    _filteringStatus = status;
    notifyListeners();
  }

  Future<dynamic> updateBlocking({
    required String block, 
    required bool newStatus,
    int? time
  }) async {
    switch (block) {
      case 'general':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await _serversProvider!.apiClient!.updateGeneralProtection(
          enable: newStatus,
          time: time
        );

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'general').toList();

        if (result['result'] == 'success') {
          _serverStatus!.generalEnabled = newStatus;
          if (time != null) {
            _serverStatus!.timeGeneralDisabled = time;
            _serverStatus!.disabledUntil = generateTimeDeadline(time);
          }
          else {
            _serverStatus!.timeGeneralDisabled = 0;
            _serverStatus!.disabledUntil = null;
          }
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'general_legacy':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await _serversProvider!.apiClient!.updateGeneralProtectionLegacy(newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'general').toList();

        if (result['result'] == 'success') {
          _serverStatus!.generalEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }


      case 'filtering':
        _protectionsManagementProcess.add('filtering');
        notifyListeners();

        final result = await _serversProvider!.apiClient!.updateFiltering(
          enable: newStatus,
        );

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'filtering').toList();

        if (result['result'] == 'success') {
          _serverStatus!.filteringEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          
          notifyListeners();
          return result['log'];
        }

      case 'safeSearch':
        _protectionsManagementProcess.add('safeSearch');
        notifyListeners();

        final result = serverVersionIsAhead(
          currentVersion: serverStatus!.serverVersion, 
          referenceVersion: 'v0.107.28',
          referenceVersionBeta: 'v0.108.0-b.33'
        ) == true
          ? await _serversProvider!.apiClient!.updateSafeSearchSettings(body: { 'enabled': newStatus })
          : await _serversProvider!.apiClient!.updateSafeSearchLegacy(newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'safeSearch').toList();

        if (result['result'] == 'success') {
          _serverStatus!.safeSearchEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'safeBrowsing':
        _protectionsManagementProcess.add('safeBrowsing');
        notifyListeners();

        final result = await _serversProvider!.apiClient!.updateSafeBrowsing(newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'safeBrowsing').toList();

        if (result['result'] == 'success') {
          _serverStatus!.safeBrowsingEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'parentalControl':
        _protectionsManagementProcess.add('parentalControl');
        notifyListeners();

        final result = await _serversProvider!.apiClient!.updateParentalControl(newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'parentalControl').toList();

        if (result['result'] == 'success') {
          _serverStatus!.parentalControlEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      default:
        return false;
    }
  }

  void setFilteringEnabledStatus(bool status) {
    _serverStatus!.filteringEnabled = status;
  }

  Future<bool> getFilteringRules() async {
    final result = await _serversProvider!.apiClient!.getFilteringRules();
    if (result['result'] == 'success') {
      _filteringStatus = result['data'];
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> getServerStatus({
    bool? withLoadingIndicator
  }) async {
    if (withLoadingIndicator == true) {
      _loadStatus = LoadStatus.loading;
    }

    final result = await _serversProvider!.apiClient!.getServerStatus();
    if (result['result'] == 'success') {
      setServerStatusData(
        data: result['data']
      );
      _loadStatus = LoadStatus.loaded; 
      notifyListeners();
      return true;
    }
    else {
      if (withLoadingIndicator == true) _loadStatus = LoadStatus.error; 
      notifyListeners();
      return false;
    }
  }

  Future<bool> blockUnblockDomain({
    required String domain,
    required String newStatus
  }) async {
    final rules = await _serversProvider!.apiClient!.getFilteringRules();

    if (rules['result'] == 'success') {
      FilteringStatus oldStatus = serverStatus!.filteringStatus;

      List<String> newRules = rules['data'].userRules.where((d) => !d.contains(domain)).toList();
      if (newStatus == 'block') {
        newRules.add("||$domain^");
      }
      else if (newStatus == 'unblock') {
        newRules.add("@@||$domain^");
      }
      FilteringStatus newObj = serverStatus!.filteringStatus;
      newObj.userRules = newRules;
      _filteringStatus = newObj;

      final result = await _serversProvider!.apiClient!.postFilteringRules(data: {'rules': newRules});
        
      if (result['result'] == 'success') {
        return true;
      }
      else {
        _filteringStatus = oldStatus;
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<bool> updateSafeSearchConfig(Map<String, bool> status) async {
    final result = await _serversProvider!.apiClient!.updateSafeSearchSettings(
      body: status
    );

    if (result['result'] == 'success') {
      ServerStatus data = serverStatus!;
      data.safeSearchEnabled = status['enabled'] ?? false;
      data.safeSeachBing = status['bing'] ?? false;
      data.safeSearchDuckduckgo = status['duckduckgo'] ?? false;
      data.safeSearchGoogle = status['google'] ?? false;
      data.safeSearchPixabay = status['pixabay'] ?? false;
      data.safeSearchYandex = status['yandex'] ?? false;
      data.safeSearchYoutube = status['youtube'] ?? false;

      setServerStatusData(data: data);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }
}