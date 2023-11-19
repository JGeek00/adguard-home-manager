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

    final result = await _serversProvider!.apiClient2!.getBlockedServices();
    if (result.successful == true) {
      _blockedServicesLoadStatus = LoadStatus.loaded;
      _blockedServicesList = BlockedServices(services: result.content as List<BlockedService>);
      
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

    final result = await _serversProvider!.apiClient2!.getFiltering();
    if (result.successful == true) {
      _filtering = result.content as Filtering;
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
    final result = await _serversProvider!.apiClient2!.updateLists();
    if (result.successful == true) {
      final result2 = await _serversProvider!.apiClient2!.getFiltering();
      if (result2.successful == true) {
        _filtering = result2.content as Filtering;
        notifyListeners();
        print(result.content);
        return {
          "success": true,
          "data": result.content
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
    final result = await _serversProvider!.apiClient2!.updateFiltering(
      enable: newValue
    );
    if (result.successful == true) {
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
    final result = await _serversProvider!.apiClient2!.requestChangeUpdateFrequency(
      data: {
        "enabled": filtering!.enabled,
        "interval": value
      }
    );
    if (result.successful == true) {
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

    final result = await _serversProvider!.apiClient2!.setCustomRules(rules: newRules);

    if (result.successful == true) {
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
    final result1 = await _serversProvider!.apiClient2!.deleteFilterList(
      data: {
        "url": listUrl,
        "whitelist": type == 'whitelist' ? true : false
      }
    );
        
    if (result1.successful == true) {
      final result2 = await _serversProvider!.apiClient2!.getFiltering();
          
      if (result2.successful == true) {
        _filtering = result2.content as Filtering;
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
    final result1 = await _serversProvider!.apiClient2!.updateFilterList(
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
        
    if (result1.successful == true) {
      final result2 = await _serversProvider!.apiClient2!.getFiltering();
          
      if (result2.successful == true) {
        _filtering = result2.content as Filtering;
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

    final result = await _serversProvider!.apiClient2!.setCustomRules(rules: newRules);
    
    if (result.successful == true) {
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
    final result1 = await _serversProvider!.apiClient2!.addFilteringList(
      data: {
        'name': name,
        'url': url,
        'whitelist': type == 'whitelist' ? true : false
      }
    );

    if (result1.successful == true) {
      if (result1.content.toString().contains("OK")) {
        final result2 = await _serversProvider!.apiClient2!.getFiltering();
        final items = result1.content.toString().split(' ')[1];

        if (result2.successful == true) {
          _filtering = result2.content as Filtering;
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
    else if (result1.successful == false && result1.statusCode == 400 && result1.content.toString().contains("data is HTML, not plain text")) {
      notifyListeners();
      return {
        'success': false,
        'error': 'invalid_url'
      };
    }
    else if (result1.successful == false && result1.statusCode == 400 && result1.content.toString().contains('url already exists')) {
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

    final result = await _serversProvider!.apiClient2!.getBlockedServices();
    if (result.successful == true) {
      _blockedServicesList = BlockedServices(services: result.content as List<BlockedService>);
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
    final result = await _serversProvider!.apiClient2!.setBlockedServices(
      data: values
    );

    if (result.successful == true) {
      setBlockedServices(values); 
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<List<ProcessedList>> deleteMultipleLists({
    required List<Filter> blacklists,
    required List<Filter> whitelists
  }) async {
    Future<ProcessedList> deleteList({
      required Filter list,
      required bool isWhitelist,
    }) async {
      final result = await _serversProvider!.apiClient2!.deleteFilterList(
        data: {
          "url": list.url,
          "whitelist": isWhitelist
        }
      );
      if (result.successful == true) {
        return ProcessedList(list: list, successful: true);
      }
      else {
        return ProcessedList(list: list, successful: false);
      }
    }

    final resultWhitelists = await Future.wait(whitelists.map((e) => deleteList(list: e, isWhitelist: true)));
    final resultBlacklists = await Future.wait(blacklists.map((e) => deleteList(list: e, isWhitelist: false)));

    await fetchFilters();

    return [
      ...resultWhitelists,
      ...resultBlacklists,
    ];
  }

  Future<List<ProcessedList>> enableDisableMultipleLists({
    required List<Filter> blacklists,
    required List<Filter> whitelists
  }) async {
    Future<ProcessedList> enableDisableList({
      required Filter list,
      required bool isWhitelist,
    }) async {
        final result = await _serversProvider!.apiClient2!.updateFilterList(
        data: {
          "data": {
            "enabled": !list.enabled,
            "name": list.name,
            "url": list.url
          },
          "url": list.url,
          "whitelist": isWhitelist
        }
      );
      if (result.successful == true) {
        return ProcessedList(list: list, successful: true);
      }
      else {
        return ProcessedList(list: list, successful: false);
      }
    }

    final resultWhitelists = await Future.wait(whitelists.map((e) => enableDisableList(list: e, isWhitelist: true)));
    final resultBlacklists = await Future.wait(blacklists.map((e) => enableDisableList(list: e, isWhitelist: false)));

    await fetchFilters();

    return [
      ...resultWhitelists,
      ...resultBlacklists,
    ];
  }
}