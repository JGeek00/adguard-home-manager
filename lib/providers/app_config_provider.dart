
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:install_referrer/install_referrer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/config/home_top_items_default_order.dart';
import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/models/app_log.dart';

class AppConfigProvider with ChangeNotifier {
  final SharedPreferences sharedPreferencesInstance;

  AppConfigProvider({
    required this.sharedPreferencesInstance
  });

  PackageInfo? _appInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  int _selectedScreen = 0;

  int? _selectedSettingsScreen;

  bool _showingSnackbar = false;

  bool _supportsDynamicTheme = true;
  int _selectedTheme = 0;
  bool _useDynamicColor = true;
  int _staticColor = 0;
  final bool _useThemeColorForStatus = false;

  int _selectedClientsTab = 0;
  int _selectedFiltersTab = 0;

  List<HomeTopItems> _homeTopItemsOrder = homeTopItemsDefaultOrder;

  bool _hideServerAddress = false;

  final List<AppLog> _logs = [];

  bool _overrideSslCheck = false;

  bool _hideZeroValues = false;

  bool _showTimeLogs = false;

  bool _showIpLogs = false;

  bool _combinedChartHome = false;

  String? _doNotRememberVersion;

  GitHubRelease? _appUpdatesAvailable;

  InstallationAppReferrer? _installationSource;

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

  bool get supportsDynamicTheme {
    return _supportsDynamicTheme;
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
    return _overrideSslCheck;
  }

  bool get hideZeroValues {
    return _hideZeroValues;
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
    return _showTimeLogs;
  }

  bool get showIpLogs {
    return _showIpLogs;
  }

  bool get combinedChartHome {
    return _combinedChartHome;
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

  InstallationAppReferrer? get installationSource {
    return _installationSource;
  }

  List<HomeTopItems> get homeTopItemsOrder {
    return _homeTopItemsOrder;
  }

  bool get hideServerAddress {
    return _hideServerAddress;
  }

  void setSupportsDynamicTheme(bool value) {
    _supportsDynamicTheme = value;
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

  void setAppUpdatesAvailable(GitHubRelease? value) {
    _appUpdatesAvailable = value;
    notifyListeners();
  }

  void setInstallationSource(InstallationAppReferrer value) {
    _installationSource = value;
    notifyListeners();
  }

  Future<bool> setOverrideSslCheck(bool status) async {
    try {
      sharedPreferencesInstance.setBool('overrideSslCheck', status);
      _overrideSslCheck = status;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setHideZeroValues(bool status) async {
    try {
      sharedPreferencesInstance.setBool('hideZeroValues', status);
      _hideZeroValues = status;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setshowTimeLogs(bool status) async {
    try {
      sharedPreferencesInstance.setBool('showTimeLogs', status);
      _showTimeLogs = status;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setShowIpLogs(bool status) async {
    try {
      sharedPreferencesInstance.setBool('showIpLogs', status);
      _showIpLogs = status;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setSelectedTheme(int value) async {
    try {
      sharedPreferencesInstance.setInt('selectedTheme', value);
      _selectedTheme = value;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setUseDynamicColor(bool value) async {
    try {
      sharedPreferencesInstance.setBool('useDynamicColor', value);
      _useDynamicColor = value;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setCombinedChartHome(bool value) async {
    try {
      sharedPreferencesInstance.setBool('combinedChart', value);
      _combinedChartHome = value;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setStaticColor(int value) async {
    try {
      sharedPreferencesInstance.setInt('staticColor', value);
      _staticColor = value;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setHomeTopItemsOrder(List<HomeTopItems> order) async {
    try {
      sharedPreferencesInstance.setStringList('homeTopItemsOrder', List<String>.from(order.map((e) => e.name)));
      _homeTopItemsOrder = order;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setHideServerAddress(bool value) async {
    try {
      sharedPreferencesInstance.setBool('hideServerAddress', value);
      _hideServerAddress = value;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> setDoNotRememberVersion(String value) async {
    final updated = await sharedPreferencesInstance.setString('hideServerAddress', value);
    return updated;
  }
  
  void saveFromSharedPreferences() {
    _selectedTheme = sharedPreferencesInstance.getInt('selectedTheme') ?? 0;
    _overrideSslCheck = sharedPreferencesInstance.getBool('overrideSslCheck') ?? false;
    _hideZeroValues = sharedPreferencesInstance.getBool('hideZeroValues') ?? false;
    _useDynamicColor = sharedPreferencesInstance.getBool('useDynamicColor') ?? true;
    _staticColor = sharedPreferencesInstance.getInt('staticColor') ?? 0;
    _showTimeLogs = sharedPreferencesInstance.getBool('showTimeLogs') ?? false;
    _doNotRememberVersion = sharedPreferencesInstance.getString('doNotRememberVersion');
    _showIpLogs = sharedPreferencesInstance.getBool('showIpLogs') ?? false;
    _combinedChartHome = sharedPreferencesInstance.getBool('combinedChart') ?? false;
    _hideServerAddress = sharedPreferencesInstance.getBool('hideServerAddress') ?? false;
    if (sharedPreferencesInstance.getStringList('homeTopItemsOrder') != null) {
      try {
        _homeTopItemsOrder = List<HomeTopItems>.from(
          List<String>.from(sharedPreferencesInstance.getStringList('homeTopItemsOrder')!).map((e) {
            switch (e) {
              case 'queriedDomains':
                return HomeTopItems.queriedDomains;

              case 'blockedDomains':
                return HomeTopItems.blockedDomains;

              case 'recurrentClients':
                return HomeTopItems.recurrentClients;

              case 'topUpstreams':
                return HomeTopItems.topUpstreams;

              case 'avgUpstreamResponseTime':
                return HomeTopItems.avgUpstreamResponseTime;

              default:
                return null;
            }
          }).where((e) => e != null).toList()
        );
      } catch (e) {
        Sentry.captureException(e);
        _homeTopItemsOrder = homeTopItemsDefaultOrder;
      }
    }
  }
}