import 'package:flutter/material.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/logs.dart';

class LogsProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  LogsData? _logsData;
  List<AutoClient>? _clients;

  DateTime? _logsOlderThan;
  String _selectedResultStatus = 'all';
  String? _searchText;
  List<String> _selectedClients = [];

  int _logsQuantity = 100;
  int _offset = 0;

  bool _isLoadingMore = false;

  AppliedFiters _appliedFilters = AppliedFiters(
    selectedResultStatus: 'all', 
    searchText: null,
    clients: []
  );

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  LogsData? get logsData {
    return _logsData;
  }

  List<AutoClient>? get clients {
    return _clients;
  }

  DateTime? get logsOlderThan {
    return _logsOlderThan;
  }

  String get selectedResultStatus {
    return _selectedResultStatus;
  }

  String? get searchText {
    return _searchText;
  }
  
  int get logsQuantity {
    return _logsQuantity;
  }

  int get offset {
    return _offset;
  }

  List<String> get selectedClients {
    return _selectedClients;
  }

  AppliedFiters get appliedFilters {
    return _appliedFilters;
  }

  bool get isLoadingMore {
    return _isLoadingMore;
  }

  void setLoadStatus(LoadStatus value) {
    _loadStatus = value;
    notifyListeners();
  }

  void setLogsData(LogsData data) {
    _logsData = data;
    notifyListeners();
  }

  void setClients(List<AutoClient> clients) {
    _clients = clients;
    notifyListeners();
  }
 
  void setLogsOlderThan(DateTime? value) {
    _logsOlderThan = value;
    notifyListeners();
  }

  void resetFilters() {
    _logsOlderThan = null;
    _offset = 0;
    _selectedResultStatus = 'all';
    _searchText = null;
    notifyListeners();
  }

  void setLogsQuantity(int value) {
    _logsQuantity = value;
    notifyListeners();
  }

  void setOffset(int value) {
    _offset = value;
  }

  void setSelectedResultStatus({
    required String value,
    bool? refetch
  }) {
    _selectedResultStatus = value;
    notifyListeners();
    if (refetch = true) {
      filterLogs();
    }
  }

  void setSearchText(String? value) {
    _searchText = value;
    notifyListeners();
  }

  void setSelectedClients(List<String>? clients) {
    _selectedClients = clients ?? [];
    notifyListeners();
  }

  void setAppliedFilters(AppliedFiters value) {
    _appliedFilters = value;
    notifyListeners();
  }

  void setIsLoadingMore(bool status) {
    _isLoadingMore = status;
  }

  Future<bool> fetchLogs({
    int? inOffset,
    bool? loadingMore,
    String? responseStatus,
    String? searchText,
  }) async {
    int offst = inOffset ?? offset;

    String resStatus = responseStatus ?? _selectedResultStatus;

    if (loadingMore != null && loadingMore == true) {
      _isLoadingMore = true;
      notifyListeners();
    }

    final result = await _serversProvider!.apiClient2!.getLogs(
      count: logsQuantity, 
      offset: offst,
      olderThan: logsOlderThan,
      responseStatus: resStatus,
      search: _searchText
    );

    if (loadingMore != null && loadingMore == true) {
      _isLoadingMore = false;
      notifyListeners();
    }

    if (result.successful == true) {
      _offset = inOffset != null ? inOffset+logsQuantity : offset+logsQuantity;
      if (loadingMore != null && loadingMore == true && logsData != null) {
        LogsData newLogsData = result.content;
        newLogsData.data = [...logsData!.data, ...(result.content as LogsData).data];
        if (appliedFilters.clients.isNotEmpty) {
          newLogsData.data = newLogsData.data.where(
            (item) => appliedFilters.clients.contains(item.client)
          ).toList();
        }
        _logsData = newLogsData;
      }
      else {
        LogsData newLogsData = result.content;
        if (appliedFilters.clients.isNotEmpty) {
          newLogsData.data = newLogsData.data.where(
            (item) => appliedFilters.clients.contains(item.client)
          ).toList();
        }
        _logsData = newLogsData;
      }
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

  Future<bool> requestResetFilters() async {
    _loadStatus = LoadStatus.loading;
    notifyListeners();

    resetFilters();

    final result = await _serversProvider!.apiClient2!.getLogs(
      count: logsQuantity
    );

    _appliedFilters = AppliedFiters(
      selectedResultStatus: 'all', 
      searchText: null,
      clients: []
    );

    if (result.successful == true) {
      _logsData = result.content as LogsData;
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

  Future<bool> filterLogs() async {
    _loadStatus = LoadStatus.loading;
    notifyListeners();

    setOffset(0);

    final result = await _serversProvider!.apiClient2!.getLogs(
      count: logsQuantity,
      olderThan: logsOlderThan,
      responseStatus: selectedResultStatus,
      search: searchText,
    );

    _appliedFilters = AppliedFiters(
      selectedResultStatus: selectedResultStatus,
      searchText: searchText,
      clients: selectedClients
    );

    if (result.successful == true) {
      LogsData newLogsData = result.content as LogsData;
      if (appliedFilters.clients.isNotEmpty) {
        newLogsData.data = newLogsData.data.where(
          (item) => appliedFilters.clients.contains(item.client)
        ).toList();
      }
      _logsData = newLogsData;
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
}