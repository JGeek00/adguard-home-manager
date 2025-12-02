import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/system_ui_overlay_style.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/config/app_screens.dart';
import 'package:adguard_home_manager/config/sizes.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Layout extends StatefulWidget {
  const Layout({
    super.key, 
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with WidgetsBindingObserver {
  bool _drawerExpanded = true;

  void _goBranch(int index) {
    Provider.of<AppConfigProvider>(context, listen: false).setSelectedScreen(index);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
      
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // if (kDebugMode) return;   // Don't check for app updates on debug mode
      // final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
      // final result = await checkAppUpdates(
      //   currentBuildNumber: appConfigProvider.getAppInfo!.buildNumber,
      //   installationSource: appConfigProvider.installationSource,
      //   setUpdateAvailable: appConfigProvider.setAppUpdatesAvailable,
      //   isBeta: appConfigProvider.getAppInfo!.version.contains('beta'),
      // );
      // if (result != null && appConfigProvider.doNotRememberVersion != result.tagName && mounted) {
      //   await showDialog(
      //     context: context, 
      //     builder: (context) => UpdateModal(
      //       gitHubRelease: result,
      //       onDownload: (link, version) => openUrl(link),
      //     ),
      //   );
      // }
    }); 
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final screens = serversProvider.selectedServer != null
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

    if (width > desktopBreakpoint) {
      return OverlayStyle(
        child: Material(
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
                    ...screens.asMap().entries.map(
                      (s) => DrawerTile(
                        icon: s.value.icon,
                        title: translatedName(s.value.name),
                        isSelected: appConfigProvider.selectedScreen == s.key,
                        onSelect: () => _goBranch(s.key),
                        withoutTitle: !_drawerExpanded,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (
                    (child, primaryAnimation, secondaryAnimation) => FadeThroughTransition(
                      animation: primaryAnimation, 
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    )
                  ),
                  child: appConfigProvider.selectedScreen < screens.length
                    ? screens[appConfigProvider.selectedScreen].child
                    : screens[0].child,
                ),
              ),
            ],
          ),
        ),
      );
    }
    else {
      final screens = serversProvider.selectedServer != null
        ? screensServerConnected 
        : screensSelectServer;

      return OverlayStyle(
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
            child: appConfigProvider.selectedScreen < screens.length
              ? screens[appConfigProvider.selectedScreen].child
              : screens[0].child,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: (serversProvider.selectedServer == null) && appConfigProvider.selectedScreen > 1
              ? 0
              : appConfigProvider.selectedScreen,
            onDestinationSelected: (s) => _goBranch(s),
            destinations: screens.asMap().entries.map((screen) => NavigationDestination(
              icon: Stack(
                children: [
                  Icon(
                    screen.value.icon,
                    color: appConfigProvider.selectedScreen == screen.key
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
        ),
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
