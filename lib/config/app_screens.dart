import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/home.dart';
import 'package:adguard_home_manager/screens/settings.dart';

import 'package:adguard_home_manager/models/app_screen.dart';

const List<AppScreen> screens = [
  AppScreen(
    name: "home", 
    icon: Icons.home_rounded, 
    widget: Home()
  ),
  AppScreen(
    name: "settings", 
    icon: Icons.settings_rounded,
    widget: Settings()
  )
];