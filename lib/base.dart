// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:store_checker/store_checker.dart';
import 'package:flutter/services.dart';

import 'package:adguard_home_manager/widgets/bottom_nav_bar.dart';
import 'package:adguard_home_manager/widgets/update_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/app_screen.dart';
import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Base extends StatefulWidget {
  final AppConfigProvider appConfigProvider;

  const Base({
    Key? key,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> with WidgetsBindingObserver {
  int selectedScreen = 0;

  bool updateExists(String appVersion, String gitHubVersion) {
    final List<int> appVersionSplit = List<int>.from(appVersion.split('.').map((e) => int.parse(e)));
    final List<int> gitHubVersionSplit = List<int>.from(gitHubVersion.split('.').map((e) => int.parse(e)));

    if (gitHubVersionSplit[0] > appVersionSplit[0]) {
      return true;
    }
    else if (gitHubVersionSplit[0] ==  appVersionSplit[0] && gitHubVersionSplit[1] > appVersionSplit[1]) {
      return true;
    }
    else if (gitHubVersionSplit[0] ==  appVersionSplit[0] && gitHubVersionSplit[1] == appVersionSplit[1] && gitHubVersionSplit[2] > appVersionSplit[2]) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<GitHubRelease?> checkInstallationSource() async {
    Source installationSource = await StoreChecker.getSource;
    if (installationSource != Source.IS_INSTALLED_FROM_PLAY_STORE) {
      final result = await checkAppUpdatesGitHub();
      if (result['result'] == 'success') {
        if (true) {
          return result['body'];
        }
      }
    }
    return null;
  }

  void download(String link, String version) async {
    FlutterWebBrowser.openWebPage(
      url: link,
      customTabsOptions: const CustomTabsOptions(
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: false,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      )
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await checkInstallationSource();

      if (result != null && widget.appConfigProvider.doNotRememberVersion != result.tagName) {
        await showDialog(
          context: context, 
          builder: (context) => UpdateModal(
            gitHubRelease: result,
            onDownload: download,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    List<AppScreen> screens = serversProvider.selectedServer != null
      ? screensServerConnected 
      : screensSelectServer;

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
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (
            (child, primaryAnimation, secondaryAnimation) => FadeThroughTransition(
              animation: primaryAnimation, 
              secondaryAnimation: secondaryAnimation,
              child: child,
            )
          ),
          child: screens[appConfigProvider.selectedScreen].body,
        ),
        bottomNavigationBar: const BottomNavBar(),
      )
    );
  }
}