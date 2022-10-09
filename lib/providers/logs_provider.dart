import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/models/logs.dart';

class LogsProvider with ChangeNotifier {
  int _loadStatus = 0;
  LogsData? _logsData;

  DateTime? _logsOlderThan;
  String _selectedResultStatus = 'all';
  String? _searchText;

  int _logsQuantity = 100;
  int _offset = 0;

  AppliedFiters _appliedFilters = AppliedFiters(
    selectedResultStatus: 'all', 
    searchText: null
  );

  int get loadStatus {
    return _loadStatus;
  }

  LogsData? get logsData {
    return _logsData;
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

  AppliedFiters get appliedFilters {
    return _appliedFilters;
  }


  void setLoadStatus(int value) {
    _loadStatus = value;
    notifyListeners();
  }

  void setLogsData(LogsData data) {
    _logsData = data;
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

  void setSelectedResultStatus(String value) {
    _selectedResultStatus = value;
    notifyListeners();
  }

  void setSearchText(String? value) {
    _searchText = value;
    notifyListeners();
  }

  void setAppliedFilters(AppliedFiters value) {
    _appliedFilters = value;
    notifyListeners();
  }
}