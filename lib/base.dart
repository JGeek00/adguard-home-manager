// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/services.dart';

import 'package:adguard_home_manager/widgets/bottom_nav_bar.dart';
import 'package:adguard_home_manager/widgets/menu_bar.dart';
import 'package:adguard_home_manager/widgets/update_modal.dart';
import 'package:adguard_home_manager/widgets/navigation_rail.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/check_app_updates.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/models/app_screen.dart';
import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> with WidgetsBindingObserver {
  int selectedScreen = 0;

  @override
  void initState() {
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

      if (result != null && appConfigProvider.doNotRememberVersion != result.tagName) {
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
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    List<AppScreen> screens = serversProvider.selectedServer != null
      ? screensServerConnected 
      : screensSelectServer;

    if (kDebugMode && dotenv.env['ENABLE_SENTRY'] == "true") {
      Sentry.captureMessage("Debug mode");
    }

    return CustomMenuBar(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
        child: Scaffold(
          body: Row(
            children: [
              if (width > 900) const SideNavigationRail(),
                Expanded(
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (
                      (child, primaryAnimation, secondaryAnimation) => FadeThroughTransition(
                        animation: primaryAnimation, 
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      )
                    ),
                    child: SizedBox()
                  ),
                ),
            ],
          ),
          bottomNavigationBar: width <= 900 
            ? const BottomNavBar()
            : null,
        )
      ),
    );
  }
}