import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/app_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    List<AppScreen> screens = serversProvider.selectedServer != null && serversProvider.apiClient != null
      ? screensServerConnected 
      : screensSelectServer;

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

        case 'logs':
          return AppLocalizations.of(context)!.logs;

        case 'filters':
          return AppLocalizations.of(context)!.filters;

        default:
          return '';
      }
    }

    if ((serversProvider.selectedServer == null || serversProvider.apiClient == null) && appConfigProvider.selectedScreen > 1) {
      appConfigProvider.setSelectedScreen(0);
    }

    return NavigationBar(
      selectedIndex: (serversProvider.selectedServer == null || serversProvider.apiClient == null) && appConfigProvider.selectedScreen > 1
        ? 0
        : appConfigProvider.selectedScreen,
      destinations: screens.map((screen) => NavigationDestination(
        icon: Stack(
          children: [
            Icon(
              screen.icon,
              color: screens[appConfigProvider.selectedScreen] == screen
                ? Theme.of(context).colorScheme.onSecondaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            if (
              screen.name == 'settings' &&
              serversProvider.updateAvailable.data != null &&
              serversProvider.updateAvailable.data!.canAutoupdate == true
            ) Positioned(
                bottom: 0,
                right: -12,
                child: Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red
                  ),
                ),
              )
          ],
        ), 
        label: translatedName(screen.name)
      )).toList(),
      // onDestinationSelected: (value) {
      //   // Reset clients tab to 0 when changing screen
      //   if (value != 1) {
      //     appConfigProvider.setSelectedClientsTab(0);
      //   }
      //   // Reset logs filters when changing screen
      //   if (value != 2) {
      //     logsProvider.resetFilters();
      //   }
      //   // Reset settings selected screen
      //   if (value != screens.length-1) {
      //     appConfigProvider.setSelectedSettingsScreen(screen: null);
      //   }
      //   appConfigProvider.setSelectedScreen(value);
      // },
    );
  }
}