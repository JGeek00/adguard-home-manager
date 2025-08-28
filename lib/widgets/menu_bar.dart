import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/models/app_screen.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class CustomMenuBar extends StatelessWidget {
  final Widget child;

  const CustomMenuBar({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    List<AppScreen> screens = serversProvider.selectedServer != null
      ? screensServerConnected
      : screensSelectServer;

    String translatedName(String key) {
      switch (key) {
        case 'connect':
          return AppLocalizations.of(context)!.connect;

        case 'home':
          return AppLocalizations.of(context)!.home;

        case 'settings':
          return AppLocalizations.of(context)!.settings;

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

    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: 'AdGuard Home Manager',
          menus: <PlatformMenuItem>[
            if (
              PlatformProvidedMenuItem.hasMenu(PlatformProvidedMenuItemType.about)
            ) const PlatformMenuItemGroup(
              members: [
                PlatformProvidedMenuItem(
                  type: PlatformProvidedMenuItemType.about,
                ),
              ]
            ),
            if (
              PlatformProvidedMenuItem.hasMenu(PlatformProvidedMenuItemType.quit)
            ) const PlatformMenuItemGroup(
              members: [
                PlatformProvidedMenuItem(
                  type: PlatformProvidedMenuItemType.quit,
                ),
              ]
            )
          ],
        ),
        PlatformMenu(
          label: AppLocalizations.of(context)!.screens,
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: screens.asMap().entries.map((e) => PlatformMenuItem(
                label: "${appConfigProvider.selectedScreen == e.key ? '✔' : ''} ${translatedName(e.value.name)}",
                onSelected: () => appConfigProvider.setSelectedScreen(e.key),
              )).toList()
            ),
          ],
        ),
      ],
      child: child,
    );
  }
}