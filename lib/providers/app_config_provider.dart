import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:adguard_home_manager/models/app_log.dart';

class AppConfigProvider with ChangeNotifier {
  Database? _dbInstance;

  PackageInfo? _appInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  int _selectedTheme = 0;

  int _selectedClientsTab = 0;
  int _selectedFiltersTab = 0;

  final List<AppLog> _logs = [];

  int _overrideSslCheck = 0;

  int _hideZeroValues = 0;

  PackageInfo? get getAppInfo {
    return _appInfo;
  }

  AndroidDeviceInfo? get androidDeviceInfo {
    return _androidDeviceInfo;
  }

  IosDeviceInfo? get iosDeviceInfo {
    return _iosDeviceInfo;
  }

  ThemeMode get selectedTheme {
    switch (_selectedTheme) {
      case 0:
        return SchedulerBinding.instance.window.platformBrightness == Brightness.light 
          ? ThemeMode.light 
          : ThemeMode.dark;

      case 1:
        return ThemeMode.light;

      case 2:
        return ThemeMode.dark;

      default:
        return ThemeMode.light;
    }
  }

  int get selectedThemeNumber {
    return _selectedTheme;
  }

  int get selectedClientsTab {
    return _selectedClientsTab;
  }

  int get selectedFiltersTab {
    return _selectedFiltersTab;
  }

  List<AppLog> get logs {
    return _logs;
  }

  bool get overrideSslCheck {
    return _overrideSslCheck == 1 ? true : false;
  }

  bool get hideZeroValues {
    return _hideZeroValues == 1 ? true : false;
  }

  void setDbInstance(Database db) {
    _dbInstance = db;
  }

  void setAppInfo(PackageInfo appInfo) {
    _appInfo = appInfo;
  }

  void setAndroidInfo(AndroidDeviceInfo deviceInfo) {
    _androidDeviceInfo = deviceInfo;
  }

  void setIosInfo(IosDeviceInfo deviceInfo) {
    _iosDeviceInfo = deviceInfo;
  }

  void setSelectedClientsTab(int tab) {
    _selectedClientsTab = tab;
    notifyListeners();
  }

  void setSelectedFiltersTab(int tab) {
    _selectedFiltersTab = tab;
    notifyListeners();
  }

  void addLog(AppLog log) {
    _logs.add(log);
    notifyListeners();
  }

  Future<bool> setOverrideSslCheck(bool status) async {
    final updated = await _updateOverrideSslCheck(status == true ? 1 : 0);
    if (updated == true) {
      _overrideSslCheck = status == true ? 1 : 0;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setHideZeroValues(bool status) async {
    final updated = await _updateSetHideZeroValues(status == true ? 1 : 0);
    if (updated == true) {
      _hideZeroValues = status == true ? 1 : 0;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setSelectedTheme(int value) async {
    final updated = await _updateThemeDb(value);
    if (updated == true) {
      _selectedTheme = value;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> _updateThemeDb(int value) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE appConfig SET theme = $value',
        );
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  Future<bool> _updateOverrideSslCheck(int value) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE appConfig SET overrideSslCheck = $value',
        );
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  Future<bool> _updateSetHideZeroValues(int value) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE appConfig SET hideZeroValues = $value',
        );
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  void saveFromDb(Database dbInstance, Map<String, dynamic> dbData) {
    _selectedTheme = dbData['theme'];
    _overrideSslCheck = dbData['overrideSslCheck'];
    _hideZeroValues = dbData['hideZeroValues'];

    _dbInstance = dbInstance;
    notifyListeners();
  }
}