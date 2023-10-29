import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:store_checker/store_checker.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/menu_bar.dart';
import 'package:adguard_home_manager/functions/check_app_updates.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/widgets/update_modal.dart';
import 'package:adguard_home_manager/routes/router.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/providers/rewrite_rules_provider.dart';
import 'package:adguard_home_manager/providers/dhcp_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/colors.dart';
import 'package:adguard_home_manager/config/globals.dart';
import 'package:adguard_home_manager/config/theme.dart';
import 'package:adguard_home_manager/classes/http_override.dart';
import 'package:adguard_home_manager/services/db/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(500, 500));
  }

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await dotenv.load(fileName: '.env');
  
  final AppConfigProvider appConfigProvider = AppConfigProvider();
  final ServersProvider serversProvider = ServersProvider();
  final StatusProvider statusProvider = StatusProvider();
  final ClientsProvider clientsProvider = ClientsProvider();
  final FilteringProvider filtersProvider = FilteringProvider();
  final DhcpProvider dhcpProvider = DhcpProvider();
  final RewriteRulesProvider rewriteRulesProvider = RewriteRulesProvider();
  final DnsProvider dnsProvider = DnsProvider();
  final LogsProvider logsProvider = LogsProvider();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    appConfigProvider.setAndroidInfo(androidInfo);
  }
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    appConfigProvider.setIosInfo(iosInfo);
  }

  final dbData = await loadDb(appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt >= 31);

  if (dbData['appConfig']['overrideSslCheck'] == 1) {
    HttpOverrides.global = MyHttpOverrides();
  }

  if (Platform.isAndroid || Platform.isIOS) {
    Source installationSource = await StoreChecker.getSource;
    appConfigProvider.setInstallationSource(installationSource);
  }

  serversProvider.setDbInstance(dbData['dbInstance']);
  appConfigProvider.saveFromDb(dbData['dbInstance'], dbData['appConfig']);
  serversProvider.saveFromDb(dbData['servers']);

  PackageInfo appInfo = await PackageInfo.fromPlatform();
  appConfigProvider.setAppInfo(appInfo);

  void startApp() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => serversProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => appConfigProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => statusProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => clientsProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => logsProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => filtersProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => dhcpProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => rewriteRulesProvider)
        ),
        ChangeNotifierProvider(
          create: ((context) => dnsProvider)
        ),
        ChangeNotifierProxyProvider2<ServersProvider, StatusProvider, ClientsProvider>(
          create: (context) => clientsProvider, 
          update: (context, servers, status, clients) => clients!..update(servers, status),
        ),
        ChangeNotifierProxyProvider2<ServersProvider, StatusProvider, FilteringProvider>(
          create: (context) => filtersProvider, 
          update: (context, servers, status, filtering) => filtering!..update(servers, status),
        ),
        ChangeNotifierProxyProvider<ServersProvider, StatusProvider>(
          create: (context) => statusProvider, 
          update: (context, servers, status) => status!..update(servers),
        ),
        ChangeNotifierProxyProvider<ServersProvider, LogsProvider>(
          create: (context) => logsProvider, 
          update: (context, servers, logs) => logs!..update(servers),
        ),
        ChangeNotifierProxyProvider<ServersProvider, DhcpProvider>(
          create: (context) => dhcpProvider, 
          update: (context, servers, dhcp) => dhcp!..update(servers),
        ),
        ChangeNotifierProxyProvider<ServersProvider, RewriteRulesProvider>(
          create: (context) => rewriteRulesProvider, 
          update: (context, servers, rewrite) => rewrite!..update(servers),
        ),
        ChangeNotifierProxyProvider<ServersProvider, DnsProvider>(
          create: (context) => dnsProvider, 
          update: (context, servers, dns) => dns!..update(servers),
        ),
      ],
      child: const Main(),
    )
  );

  if (
    (
      kReleaseMode &&
      (dotenv.env['SENTRY_DSN'] != null && dotenv.env['SENTRY_DSN'] != "")
    ) || (
      dotenv.env['ENABLE_SENTRY'] == "true" &&
      (dotenv.env['SENTRY_DSN'] != null && dotenv.env['SENTRY_DSN'] != "")
    )
  ) {
    SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.sendDefaultPii = false;
      },
      appRunner: () => startApp()
    );
  }
  else {
    startApp();
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  List<DisplayMode> modes = <DisplayMode>[];
  DisplayMode? active;
  DisplayMode? preferred;

  Future<void> displayMode() async {
    try {
      modes = await FlutterDisplayMode.supported;
      preferred = await FlutterDisplayMode.preferred;
      active = await FlutterDisplayMode.active;
      await FlutterDisplayMode.setHighRefreshRate();
      setState(() {});
    } catch (_) {
      // ---- //
    }
  }

  @override
  void initState() {
    displayMode();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
      
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
      final result = await checkAppUpdates(
        currentBuildNumber: appConfigProvider.getAppInfo!.buildNumber,
        installationSource: appConfigProvider.installationSource,
        setUpdateAvailable: appConfigProvider.setAppUpdatesAvailable,
        isBeta: appConfigProvider.getAppInfo!.version.contains('beta'),
      );
      if (result != null && appConfigProvider.doNotRememberVersion != result.tagName && mounted) {
        await showDialog(
          context: context, 
          builder: (context) => UpdateModal(
            gitHubRelease: result,
            onDownload: (link, version) => openUrl(link),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.light
          : Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      ),
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => MaterialApp.router(
          title: 'AdGuard Home Manager',
          theme: appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt >= 31
            ? appConfigProvider.useDynamicColor == true
              ? lightTheme(lightDynamic)
              : lightThemeOldVersions(colors[appConfigProvider.staticColor])
            : lightThemeOldVersions(colors[appConfigProvider.staticColor]),
          darkTheme: appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt >= 31
            ? appConfigProvider.useDynamicColor == true
              ? darkTheme(darkDynamic)
              : darkThemeOldVersions(colors[appConfigProvider.staticColor])
            : darkThemeOldVersions(colors[appConfigProvider.staticColor]),
          themeMode: appConfigProvider.selectedTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
            Locale('zh', ''),
            Locale('zh', 'CN'),
            Locale('pl', ''),
            Locale('tr', '')
          ],
          scaffoldMessengerKey: scaffoldMessengerKey,
          builder: (context, child) {
            return CustomMenuBar(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: !(Platform.isAndroid || Platform.isIOS) 
                    ? 0.9
                    : 1.0
                ),
                child: child!,
              ),
            );
          },
          routerConfig: goRouter,
        ),
      ),
    );
  }
}

