import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/app_screen.dart';

class BottomNavBar extends StatelessWidget {
  final List<AppScreen> screens;
  final int selectedScreen;
  final void Function(int) onSelect;

  const BottomNavBar({
    Key? key, 
    required this.screens,
    required this.selectedScreen,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String translatedName(String key) {
      switch (key) {
        case 'home':
          return AppLocalizations.of(context)!.home;

        case 'settings':
          return AppLocalizations.of(context)!.settings;

        case 'connect':
          return AppLocalizations.of(context)!.connect;

        case 'clients':
          return AppLocalizations.of(context)!.clients;

        default:
          return '';
      }
    }

    return NavigationBar(
      selectedIndex: selectedScreen,
      destinations: screens.map((screen) => NavigationDestination(
        icon: Icon(screen.icon), 
        label: translatedName(screen.name)
      )).toList(),
      onDestinationSelected: onSelect,
    );
  }
}