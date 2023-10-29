import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/clients/clients.dart';
import 'package:adguard_home_manager/screens/connect/connect.dart';
import 'package:adguard_home_manager/screens/filters/filters.dart';
import 'package:adguard_home_manager/screens/home/home.dart';
import 'package:adguard_home_manager/screens/logs/logs.dart';
import 'package:adguard_home_manager/screens/settings/settings.dart';

import 'package:adguard_home_manager/models/app_screen.dart';

List<AppScreen> screensSelectServer = [
  const AppScreen(
    name: "connect", 
    icon: Icons.link_rounded, 
    child: Connect()
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
    child: Settings()
  )
];

List<AppScreen> screensServerConnected = [
  const AppScreen(
    name: "home", 
    icon: Icons.home_rounded, 
    child: Home()
  ),
  const AppScreen(
    name: "clients", 
    icon: Icons.devices, 
    child: Clients()
  ),
  const AppScreen(
    name: "logs", 
    icon: Icons.list_alt_rounded, 
    child: Logs()
  ),
  const AppScreen(
    name: "filters", 
    icon: Icons.shield_rounded, 
    child: Filters()
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
    child: Settings()
  )
];