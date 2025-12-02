import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/customization/customization.dart';
import 'package:adguard_home_manager/screens/servers/servers.dart';
import 'package:adguard_home_manager/screens/settings/advanced_setings.dart';
import 'package:adguard_home_manager/screens/settings/general_settings/general_settings.dart';

import 'package:adguard_home_manager/widgets/custom_settings_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

final settingsNavigatorKey = GlobalKey<NavigatorState>();

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            children: [
              const Expanded(
                flex: 1,
                child: _SettingsWidget(
                  twoColumns: true,
                )
              ),
              Expanded(
                flex: 2,
                child: Navigator(
                  key: settingsNavigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(builder: (ctx) => const SizedBox()),
                ),
              )
            ],
          );
        }
        else {
          return const _SettingsWidget(
            twoColumns: false,
          );
        }
      },
    );
  }
}

class _SettingsWidget extends StatefulWidget {
  final bool twoColumns;

  const _SettingsWidget({
    required this.twoColumns,
  });

  @override
  State<_SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<_SettingsWidget> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    Provider.of<AppConfigProvider>(context, listen: false).setSelectedSettingsScreen(screen: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    if (!widget.twoColumns && appConfigProvider.selectedSettingsScreen != null) {
      appConfigProvider.setSelectedSettingsScreen(screen: null);
    }

    return ScaffoldMessenger(
      key: widget.twoColumns ? _scaffoldMessengerKey : null,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar.large(
                pinned: true,
                floating: true,
                centerTitle: false,
                forceElevated: innerBoxIsScrolled,
                title: Text(AppLocalizations.of(context)!.settings),
              )
            )
          ], 
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) => CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverList.list(
                    children: [
                      SectionLabel(label: AppLocalizations.of(context)!.appSettings),
                      _SettingsTile(
                        icon: Icons.palette_rounded,
                        title: AppLocalizations.of(context)!.customization, 
                        subtitle: AppLocalizations.of(context)!.customizationDescription,
                        thisItem: 10,
                        screenToNavigate: const Customization(),
                        twoColumns: widget.twoColumns,
                      ),
                      _SettingsTile(
                        icon: Icons.storage_rounded,
                        title: AppLocalizations.of(context)!.servers,
                        subtitle: serversProvider.selectedServer != null
                            ? "${AppLocalizations.of(context)!.selectedServer} ${serversProvider.selectedServer!.name}"
                            : AppLocalizations.of(context)!.noServerSelected,
                        thisItem: 11,
                        screenToNavigate: const Servers(),
                        twoColumns: widget.twoColumns,
                      ),
                      _SettingsTile(
                        icon: Icons.settings,
                        title: AppLocalizations.of(context)!.generalSettings,
                        subtitle: AppLocalizations.of(context)!.generalSettingsDescription,
                        thisItem: 12,
                        screenToNavigate: GeneralSettings(splitView: widget.twoColumns),
                        twoColumns: widget.twoColumns,
                      ),
                      _SettingsTile(
                        icon: Icons.build_outlined,
                        title: AppLocalizations.of(context)!.advancedSettings,
                        subtitle: AppLocalizations.of(context)!.advancedSetupDescription,
                        thisItem: 13,
                        screenToNavigate: const AdvancedSettings(),
                        twoColumns: widget.twoColumns,
                      ),
                      SectionLabel(label: AppLocalizations.of(context)!.aboutApp),
                      CustomListTile(
                        title: AppLocalizations.of(context)!.appVersion, 
                        subtitle: appConfigProvider.getAppInfo!.version,
                      ),
                      CustomListTile(
                        title: AppLocalizations.of(context)!.applicationDetails, 
                        subtitle: AppLocalizations.of(context)!.applicationDetailsDescription,
                        trailing: const Icon(Icons.open_in_new_rounded),
                        onTap: () => openUrl(Urls.appDetailsWebpage),
                      ),
                      CustomListTile(
                        title: AppLocalizations.of(context)!.myOtherApps, 
                        subtitle: AppLocalizations.of(context)!.myOtherAppsDescription,
                        trailing: const Icon(Icons.open_in_new_rounded),
                        onTap: () => openUrl(Urls.jgeek00AppsWebpage),
                      ),
                      const SizedBox(height: 16)
                    ],
                  )
                ],
              )
            ),
          ),
        )
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;
  final Widget screenToNavigate;
  final int thisItem;
  final bool twoColumns;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    required this.screenToNavigate,
    required this.thisItem,
    required this.twoColumns
  });

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    if (twoColumns) {
      return CustomSettingsTile(
        title: title, 
        subtitle: subtitle,
        icon: icon,
        trailing: trailing,
        thisItem: thisItem, 
        selectedItem: appConfigProvider.selectedSettingsScreen,
        onTap: () {
          appConfigProvider.setSelectedSettingsScreen(screen: thisItem, notify: true);
          Navigator.of(settingsNavigatorKey.currentContext!).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => screenToNavigate,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      );
    }
    else {
      return CustomListTile(
        title: title,
        subtitle: subtitle,
        icon: icon,
        trailing: trailing,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screenToNavigate)
          );
        },
      );
    }
  }
}
