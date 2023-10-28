import 'package:adguard_home_manager/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/config/sizes.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Layout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const Layout({
    Key? key, 
    required this.navigationShell,
  }) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool _drawerExpanded = true;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final serversProvider = Provider.of<ServersProvider>(context);

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

    if (width > desktopBreakpoint) {
      return Material(
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.ease,
              width: _drawerExpanded ? 250 : 90,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8, 
                          vertical: 16
                        ),
                        child: IconButton(
                          onPressed: () => setState(() => _drawerExpanded = !_drawerExpanded), 
                          icon: const Icon(Icons.menu_open_rounded),
                          tooltip: _drawerExpanded == true
                            ? AppLocalizations.of(context)!.closeMenu
                            : AppLocalizations.of(context)!.openMenu,
                        ),
                      ),
                    ],
                  ),
                  if (serversProvider.selectedServer != null) 
                    ...screensServerConnected.asMap().entries.map(
                      (s) => DrawerTile(
                        icon: s.value.icon,
                        title: translatedName(s.value.name),
                        isSelected:
                            widget.navigationShell.currentIndex == s.key,
                        onSelect: () => _goBranch(s.key),
                        withoutTitle: !_drawerExpanded,
                      ),
                    ),
                  if (serversProvider.selectedServer == null) 
                    ...screensSelectServer.asMap().entries.map(
                      (s) => DrawerTile(
                        icon: s.value.icon,
                        title: translatedName(s.value.name),
                        isSelected:
                            widget.navigationShell.currentIndex == s.key,
                        onSelect: () => _goBranch(s.key),
                        withoutTitle: !_drawerExpanded,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: widget.navigationShell
            ),
          ],
        ),
      );
    }
    else {
      final screens = serversProvider.selectedServer != null && serversProvider.apiClient != null
        ? screensServerConnected 
        : screensSelectServer;

      return Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: (serversProvider.selectedServer == null || serversProvider.apiClient == null) && widget.navigationShell.currentIndex > 1
            ? 0
            : widget.navigationShell.currentIndex,
          onDestinationSelected: (s) => _goBranch(s),
          destinations: screens.asMap().entries.map((screen) => NavigationDestination(
            icon: Stack(
              children: [
                Icon(
                  screen.value.icon,
                  color: widget.navigationShell.currentIndex == screen.key
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                if (
                  screen.value.name == 'settings' &&
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
            label: translatedName(screen.value.name)
          )).toList(),
        )
      );
    }
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final void Function() onSelect;
  final bool? withoutTitle;

  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onSelect,
    this.withoutTitle,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = withoutTitle == true
        ? Tooltip(
            message: title,
            child: Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          )
        : Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          );

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          onTap: onSelect,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(children: [
              iconWidget,
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
