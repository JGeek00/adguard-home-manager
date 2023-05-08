import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/base.dart';

import 'package:adguard_home_manager/classes/http_override.dart';
import 'package:adguard_home_manager/services/db/database.dart';
import 'package:adguard_home_manager/constants/colors.dart';
import 'package:adguard_home_manager/config/globals.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/config/theme.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';


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
  
  AppConfigProvider appConfigProvider = AppConfigProvider();
  ServersProvider serversProvider = ServersProvider();
  LogsProvider logsProvider = LogsProvider();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    appConfigProvider.setAndroidInfo(androidInfo);
  }
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    appConfigProvider.setIosInfo(iosInfo);
  }

  final dbData = await loadDb(appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt! >= 31);

  if (dbData['appConfig']['overrideSslCheck'] == 1) {
    HttpOverrides.global = MyHttpOverrides();
  }

  serversProvider.setDbInstance(dbData['dbInstance']);
  appConfigProvider.saveFromDb(dbData['dbInstance'], dbData['appConfig']);
  serversProvider.saveFromDb(dbData['servers']);

  PackageInfo appInfo = await PackageInfo.fromPlatform();
  appConfigProvider.setAppInfo(appInfo);

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
      appRunner: () => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: ((context) => serversProvider)
            ),
            ChangeNotifierProvider(
              create: ((context) => appConfigProvider)
            ),
            ChangeNotifierProvider(
              create: ((context) => logsProvider)
            ),
          ],
          child: const Main(),
        )
      )
    );
  }
  else {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => serversProvider)
          ),
          ChangeNotifierProvider(
            create: ((context) => appConfigProvider)
          ),
          ChangeNotifierProvider(
            create: ((context) => logsProvider)
          ),
        ],
        child: const Main(),
      )
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        title: 'AdGuard Home Manager',
        theme: appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt! >= 31
            ? appConfigProvider.useDynamicColor == true
              ? lightTheme(lightDynamic)
              : lightThemeOldVersions(colors[appConfigProvider.staticColor])
            : lightThemeOldVersions(colors[appConfigProvider.staticColor]),
          darkTheme: appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt! >= 31
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
          Locale('es', '')
        ],
        scaffoldMessengerKey: scaffoldMessengerKey,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: !(Platform.isAndroid || Platform.isIOS) 
                ? 0.9
                : 1.0
            ),
            child: child!,
          );
        },
        home: Base(appConfigProvider: appConfigProvider),
      ),
    );
  }
}

