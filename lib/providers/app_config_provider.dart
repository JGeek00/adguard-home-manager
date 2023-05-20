import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:store_checker/store_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/services/db/queries.dart';
import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/models/app_log.dart';

class AppConfigProvider with ChangeNotifier {
  Database? _dbInstance;

  PackageInfo? _appInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  int _selectedScreen = 0;

  int? _selectedSettingsScreen;

  bool _showingSnackbar = false;

  int _selectedTheme = 0;
  bool _useDynamicColor = true;
  int _staticColor = 0;
  bool _useThemeColorForStatus = false;

  int _selectedClientsTab = 0;
  int _selectedFiltersTab = 0;

  final List<AppLog> _logs = [];

  int _overrideSslCheck = 0;

  int _hideZeroValues = 0;

  int _showTimeLogs = 0;

  int _showIpLogs = 0;

  String? _doNotRememberVersion;

  GitHubRelease? _appUpdatesAvailable;

  Source _installationSource = Source.UNKNOWN;

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

  int get selectedScreen {
    return _selectedScreen;
  }

  bool get showingSnackbar {
    return _showingSnackbar;
  }

  bool get useDynamicColor {
    return _useDynamicColor;
  }

  int get staticColor {
    return _staticColor;
  }

  bool get useThemeColorForStatus {
    return _useThemeColorForStatus;
  }

  bool get showTimeLogs {
    return _showTimeLogs == 1 ? true : false;
  }

  bool get showIpLogs {
    return _showIpLogs == 1 ? true : false;
  }

  String? get doNotRememberVersion {
    return _doNotRememberVersion;
  }

  int? get selectedSettingsScreen {
    return _selectedSettingsScreen;
  }

  GitHubRelease? get appUpdatesAvailable {
    return _appUpdatesAvailable;
  }

  Source get installationSource {
    return _installationSource;
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

  void setSelectedScreen(int screen) {
    _selectedScreen = screen;
    notifyListeners();
  }

  void setShowingSnackbar(bool status) async {
    _showingSnackbar = status;
    notifyListeners();
  }

  void setSelectedSettingsScreen({required int? screen, bool? notify}) {
    _selectedSettingsScreen = screen;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setAppUpdatesAvailable(GitHubRelease value) {
    _appUpdatesAvailable = value;
    notifyListeners();
  }

  void setInstallationSource(Source value) {
    _installationSource = value;
    notifyListeners();
  }

  Future<bool> setOverrideSslCheck(bool status) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'overrideSslCheck',
      value: status == true ? 1 : 0
    );
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
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'hideZeroValues',
      value: status == true ? 1 : 0
    );
    if (updated == true) {
      _hideZeroValues = status == true ? 1 : 0;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setshowTimeLogs(bool status) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'showTimeLogs',
      value: status == true ? 1 : 0
    );
    if (updated == true) {
      _showTimeLogs = status == true ? 1 : 0;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setShowIpLogs(bool status) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'showIpLogs',
      value: status == true ? 1 : 0
    );
    if (updated == true) {
      _showIpLogs = status == true ? 1 : 0;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setSelectedTheme(int value) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'theme',
      value: value
    );
    if (updated == true) {
      _selectedTheme = value;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setUseDynamicColor(bool value) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'useDynamicColor',
      value: value == true ? 1 : 0
    );
    if (updated == true) {
      _useDynamicColor = value;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setUseThemeColorForStatus(bool value) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'useThemeColorForStatus',
      value: value == true ? 1 : 0
    );
    if (updated == true) {
      _useThemeColorForStatus = value;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setStaticColor(int value) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'staticColor',
      value: value
    );
    if (updated == true) {
      _staticColor = value;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> setDoNotRememberVersion(String value) async {
    final updated = await updateConfigQuery(
      db: _dbInstance!,
      column: 'doNotRememberVersion',
      value: value
    );
    return updated;
  }

  void saveFromDb(Database dbInstance, Map<String, dynamic> dbData) {
    _selectedTheme = dbData['theme'];
    _overrideSslCheck = dbData['overrideSslCheck'];
    _hideZeroValues = dbData['hideZeroValues'];
    _useDynamicColor = convertFromIntToBool(dbData['useDynamicColor'])!;
    _staticColor = dbData['staticColor'];
    _useThemeColorForStatus = dbData['useThemeColorForStatus'] != null ? convertFromIntToBool(dbData['useThemeColorForStatus'])! : false;
    _showTimeLogs = dbData['showTimeLogs'];
    _doNotRememberVersion = dbData['doNotRememberVersion'];

    _dbInstance = dbInstance;
    notifyListeners();
  }
}