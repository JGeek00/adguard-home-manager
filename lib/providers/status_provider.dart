import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/functions/time_server_disabled.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class StatusProvider with ChangeNotifier {
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
    required Server server,
    required String block, 
    required bool newStatus,
    int? time
  }) async {
    switch (block) {
      case 'general':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await updateGeneralProtection(
          server: server, 
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

        final result = await updateGeneralProtectionLegacy(server, newStatus);

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

        final result = await updateFiltering(
          server: server, 
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
          ? await updateSafeSearchSettings(server: server, body: { 'enabled': newStatus })
          : await updateSafeSearchLegacy(server, newStatus);

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

        final result = await updateSafeBrowsing(server, newStatus);

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

        final result = await updateParentalControl(server, newStatus);

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
}