import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/filters/filters.dart';
import 'package:adguard_home_manager/screens/logs/logs.dart';
import 'package:adguard_home_manager/screens/connect/connect.dart';
import 'package:adguard_home_manager/screens/home/home.dart';
import 'package:adguard_home_manager/screens/clients/clients.dart';
import 'package:adguard_home_manager/screens/settings/settings.dart';

import 'package:adguard_home_manager/models/app_screen.dart';

List<AppScreen> screensSelectServer = [
  const AppScreen(
    name: "connect", 
    icon: Icons.link_rounded, 
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
  )
];

List<AppScreen> screensServerConnected = [
  const AppScreen(
    name: "home", 
    icon: Icons.home_rounded, 
  ),
  const AppScreen(
    name: "clients", 
    icon: Icons.devices, 
  ),
  const AppScreen(
    name: "logs", 
    icon: Icons.list_alt_rounded, 
  ),
  const AppScreen(
    name: "filters", 
    icon: Icons.shield_rounded, 
  ),
  const AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
  )
];