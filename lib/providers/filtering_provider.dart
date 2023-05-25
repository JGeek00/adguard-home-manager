import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

enum FilteringListActions { edit, enable, disable }

class FilteringProvider with ChangeNotifier {
  StatusProvider? _statusProvider;
  ServersProvider? _serversProvider;

  update(ServersProvider? servers, StatusProvider? status) {
    _serversProvider = servers;
    _statusProvider = status;
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

  void setFilteringProtectionStatus(bool status, bool notify) {
    _statusProvider!.setFilteringEnabledStatus(status);
    _filtering!.enabled = status;
    if (notify == true) notifyListeners();
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

  Future<bool> getBlockedServices({
    bool? showLoader
  }) async {
    _blockedServicesLoadStatus = LoadStatus.loading;
    if (showLoader == true) notifyListeners(); 

    final result = await _serversProvider!.apiClient!.getBlockedServices();
    if (result['result'] == 'success') {
      _blockedServicesLoadStatus = LoadStatus.loaded;
      _blockedServicesList = BlockedServices(services: result['data']);
      
      notifyListeners();
      return true;
    }
    else {
      if (showLoader == true) {
        _blockedServicesLoadStatus = LoadStatus.error;
        notifyListeners();
      }
      return false;
    }
  }

  Future<bool> fetchFilters({
    bool? showLoading
  }) async {
    if (showLoading == true) {
      _loadStatus = LoadStatus.loading;
    }

    final result = await _serversProvider!.apiClient!.getFiltering();
    if (result['result'] == 'success') {
      _filtering = result['data'];
      _loadStatus = LoadStatus.loaded;
      notifyListeners();
      return true;
    }
    else {
      _loadStatus = LoadStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<Map<String, dynamic>> updateLists() async {
    final result = await _serversProvider!.apiClient!.updateLists();
    if (result['result'] == 'success') {
      final result2 = await _serversProvider!.apiClient!.getFiltering();
      if (result2['result'] == 'success') {
        _filtering = result2['data'];
        notifyListeners();
        return {
          "success": true,
          "data": result['data']
        };
      }
      else {
        notifyListeners();
        return { "success": false };
      }
    }
    else {
      notifyListeners();
      return { "success": false };
    }
  }

  Future<bool> enableDisableFiltering() async {
    final newValue = !_statusProvider!.serverStatus!.filteringEnabled;
    final result = await _serversProvider!.apiClient!.updateFiltering(
      enable: newValue
    );
    if (result['result'] == 'success') {
      setFilteringProtectionStatus(newValue, false);
      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> changeUpdateFrequency(int value) async {
    final result = await _serversProvider!.apiClient!.requestChangeUpdateFrequency(
      data: {
        "enabled": filtering!.enabled,
        "interval": value
      }
    );
    if (result['result'] == 'success') {
      setFiltersUpdateFrequency(value);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeCustomRule(String rule) async {
    final List<String> newRules = filtering!.userRules.where((r) => r != rule).toList();

    final result = await _serversProvider!.apiClient!.setCustomRules(rules: newRules);

    if (result['result'] == 'success') {
      Filtering filteringData = filtering!;
      filteringData.userRules = newRules;
      _filtering = filteringData;
      
      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteList({
  required String listUrl,
  required String type
  }) async {        
    final result1 = await _serversProvider!.apiClient!.deleteFilterList(
      data: {
        "url": listUrl,
        "whitelist": type == 'whitelist' ? true : false
      }
    );
        
    if (result1['result'] == 'success') {
      final result2 = await _serversProvider!.apiClient!.getFiltering();
          
      if (result2['result'] == 'success') {
        _filtering = result2['data'];
        notifyListeners();
        return true;
      }
      else {
        notifyListeners();
        return false;
      } 
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateList({
    required Filter list,
    required String type,
    required FilteringListActions action
  }) async {        
    final result1 = await _serversProvider!.apiClient!.updateFilterList(
      data: {
        "data": {
          "enabled": action == FilteringListActions.disable || action == FilteringListActions.enable
            ? !list.enabled
            : list.enabled,
          "name": list.name,
          "url": list.url
        },
        "url": list.url,
        "whitelist": type == 'whitelist' ? true : false
      }
    );
        
    if (result1['result'] == 'success') {
      final result2 = await _serversProvider!.apiClient!.getFiltering();
          
      if (result2['result'] == 'success') {
        _filtering = result2['data'];
        notifyListeners();
        return true;
      }
      else {
        notifyListeners();
        return false;
      } 
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> addCustomRule(String rule) async {
    final List<String> newRules = filtering!.userRules;
    newRules.add(rule);

    final result = await _serversProvider!.apiClient!.setCustomRules(rules: newRules);

    if (result['result'] == 'success') {
      Filtering filteringData = filtering!;
      filteringData.userRules = newRules;
      _filtering = filteringData;
      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }
  Future<Map<String, dynamic>> addList({required String name, required String url, required String type}) async {
    final result1 = await _serversProvider!.apiClient!.addFilteringList(
      data: {
        'name': name,
        'url': url,
        'whitelist': type == 'whitelist' ? true : false
      }
    );

    if (result1['result'] == 'success') {
      if (result1['data'].toString().contains("OK")) {
        final result2 = await _serversProvider!.apiClient!.getFiltering();
        final items = result1['data'].toString().split(' ')[1];

        if (result2['result'] == 'success') {
          _filtering = result2['data'];
          notifyListeners();
          return { 
            'success': true,
            'data': items
          };
        }
        else {
          notifyListeners();
          return {
            'success': false,
            'error': null
          };
        }
      }
      else {
        notifyListeners();
        return {
          'success': false,
          'error': null
        };
      }
    }
    else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains("Couldn't fetch filter from url")) {
      notifyListeners();
      return {
        'success': false,
        'error': 'invalid_url'
      };
    }
    else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains('Filter URL already added')) {
      notifyListeners();
      return {
        'success': false,
        'error': 'url_exists'
      };
    }
    else {
      notifyListeners();
      return {
        'success': false,
        'error': null
      };
    }
  }

  Future<bool> loadBlockedServices({
    bool? showLoading
  }) async {
    if (showLoading == true) {
      _blockedServicesLoadStatus = LoadStatus.loading;
    } 

    final result = await _serversProvider!.apiClient!.getBlockedServices();
    if (result['result'] == 'success') {
      _blockedServicesList = BlockedServices(services: result['data']);
      _blockedServicesLoadStatus = LoadStatus.loaded;

      notifyListeners();
      return true;
    }
    else {
      if (showLoading == true) _blockedServicesLoadStatus = LoadStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBlockedServices(List<String> values) async {
    final result = await _serversProvider!.apiClient!.setBlockedServices(
      data: values
    );

    if (result['result'] == 'success') {
      setBlockedServices(values); 
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }
}