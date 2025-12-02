import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/layout.dart';
import 'package:adguard_home_manager/widgets/menu_bar.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/providers/rewrite_rules_provider.dart';
import 'package:adguard_home_manager/providers/dhcp_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/constants/colors.dart';
import 'package:adguard_home_manager/config/globals.dart';
import 'package:adguard_home_manager/config/theme.dart';
import 'package:adguard_home_manager/services/db/database.dart';
import 'package:adguard_home_manager/classes/http_override.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(500, 700));
  }

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await dotenv.load(fileName: '.env');

  final sharedPreferences = await SharedPreferences.getInstance();
  
  final AppConfigProvider appConfigProvider = AppConfigProvider(
    sharedPreferencesInstance: sharedPreferences
  );
  final ServersProvider serversProvider = ServersProvider();
  final StatusProvider statusProvider = StatusProvider();
  final ClientsProvider clientsProvider = ClientsProvider();
  final FilteringProvider filtersProvider = FilteringProvider();
  final DhcpProvider dhcpProvider = DhcpProvider();
  final RewriteRulesProvider rewriteRulesProvider = RewriteRulesProvider();
  final DnsProvider dnsProvider = DnsProvider();
  final LogsProvider logsProvider = LogsProvider();
  final PrivateDnsProvider privateDnsProvider = PrivateDnsProvider();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    appConfigProvider.setAndroidInfo(androidInfo);
  }
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    appConfigProvider.setIosInfo(iosInfo);
  }

  if (sharedPreferences.getBool('overrideSslCheck') == true) {
    HttpOverrides.global = MyHttpOverrides();
  }

  final dbData = await loadDb();
  serversProvider.setDbInstance(dbData['dbInstance']);
  serversProvider.saveFromDb(dbData['servers']);

  appConfigProvider.saveFromSharedPreferences();

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
        ChangeNotifierProvider(
          create: ((context) => privateDnsProvider)
        ),
        ChangeNotifierProxyProvider<ServersProvider, PrivateDnsProvider>(
          create: (context) => privateDnsProvider,
          update: (context, servers, privateDns) {
            if (servers.selectedServer != null) {
              privateDns!.initializeClient(servers.selectedServer!);
            }
            return privateDns!;
          },
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
        options.beforeSend = (event, hint) {
          if (event.throwable is HttpException) {
            return null;
          }

          if (event.message?.formatted.contains("HttpException") == true) {
            return null;
          }

          if (
            event.message?.formatted.contains("Unexpected character") ?? false ||
            (event.throwable != null && event.throwable!.toString().contains("Unexpected character"))
          ) {
            return null;
          }

          if (
            event.message?.formatted.contains("Unexpected end of input") ?? false ||
            (event.throwable != null && event.throwable!.toString().contains("Unexpected end of input"))
          ) {
            return null;
          }

          return event;
        };
      },
      appRunner: () => startApp()
    );
  }
  else {
    startApp();
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      title: 'AdGuard Home Manager',
      theme: lightThemeOldVersions(colors[appConfigProvider.staticColor]),
      darkTheme: darkThemeOldVersions(colors[appConfigProvider.staticColor]),
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
        Locale('tr', ''),
        Locale('ru', '')
      ],
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: globalNavigatorKey,
      builder: (context, child) => CustomMenuBar(
        child: child!,
      ),
      home: const Layout(),
    );
  }
}