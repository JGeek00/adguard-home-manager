import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class LiveLogsProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

  bool _isDisposed = false;
  
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<Log> _logs = [];

  List<Log> get logs {
    return _logs;
  }

  DateTime? _lastTime;

  void startFetchLogs() {
    _lastTime = DateTime.now();
    _fetchLogs();
  }
  
  void _fetchLogs() async {
    if (_lastTime == null) return;
    final result = await _serversProvider!.apiClient2!.getLogs(
      count: 100
    );
    if (result.successful == false || result.content == null) return;
    final valid = (result.content as LogsData).data.where((e) => e.time.isAfter(_lastTime!));
    _logs = [...valid, ..._logs];
    _lastTime = DateTime.now();
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    if (_isDisposed == true) return;
    _fetchLogs();
  }
}