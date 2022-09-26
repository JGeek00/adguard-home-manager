import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:adguard_home_manager/widgets/bottom_nav_bar.dart';

import 'package:adguard_home_manager/models/app_screen.dart';
import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    // List<AppScreen> screens = serversProvider.selectedServer != null
    //   ? screensServerConnected 
    //   : screensSelectServer;

    List<AppScreen> screens = screensSelectServer;

    if (selectedScreen > screens.length-1) {
      setState(() => selectedScreen = 0);
    }

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
        appBar: screens[selectedScreen].appBar,
        body: screens[selectedScreen].body,
        bottomNavigationBar: BottomNavBar(
          screens: screens,
          selectedScreen: selectedScreen,
          onSelect: (value) => setState(() => selectedScreen = value),
        ),
        floatingActionButton: screens[selectedScreen].fab,
      ),
    );
  }
}