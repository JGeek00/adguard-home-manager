import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/connect/fab.dart';
import 'package:adguard_home_manager/screens/home/appbar.dart';
import 'package:adguard_home_manager/screens/connect/appbar.dart';
import 'package:adguard_home_manager/screens/connect/connect.dart';
import 'package:adguard_home_manager/screens/home/home.dart';
import 'package:adguard_home_manager/screens/clients/clients.dart';
import 'package:adguard_home_manager/screens/settings/appbar.dart';
import 'package:adguard_home_manager/screens/settings/settings.dart';
import 'package:adguard_home_manager/screens/home/fab.dart';

import 'package:adguard_home_manager/models/app_screen.dart';

List<AppScreen> screensSelectServer = [
  const AppScreen(
    name: "connect", 
    icon: Icons.link_rounded, 
    appBar: ConnectAppBar(),
    body: Connect(),
    fab: FabConnect()
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
    appBar: SettingsAppBar(),
    body: Settings()
  )
];

List<AppScreen> screensServerConnected = [
  const AppScreen(
    name: "home", 
    icon: Icons.home_rounded, 
    appBar: HomeAppBar(),
    body: Home(),
    fab: HomeFab()
  ),
  const AppScreen(
    name: "clients", 
    icon: Icons.devices, 
    body: Clients(),
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
    appBar: SettingsAppBar(),
    body: Settings()
  )
];