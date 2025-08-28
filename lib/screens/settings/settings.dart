
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/server_info/server_info.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption.dart';
import 'package:adguard_home_manager/screens/settings/logs_settings/logs_settings.dart';
import 'package:adguard_home_manager/screens/settings/access_settings/access_settings.dart';
import 'package:adguard_home_manager/screens/settings/customization/customization.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp.dart';
import 'package:adguard_home_manager/screens/settings/statistics_settings/statistics_settings.dart';
import 'package:adguard_home_manager/screens/settings/safe_search_settings.dart';
import 'package:adguard_home_manager/screens/settings/update_server/update_screen.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/dns_rewrites.dart';
import 'package:adguard_home_manager/screens/servers/servers.dart';
import 'package:adguard_home_manager/screens/settings/advanced_setings.dart';
import 'package:adguard_home_manager/screens/settings/general_settings/general_settings.dart';

import 'package:adguard_home_manager/widgets/custom_settings_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
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
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

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
                surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
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
                      if (
                        serversProvider.selectedServer != null && 
                        statusProvider.serverStatus != null && 
                        serversProvider.apiClient2 != null
                      ) ...[
                        SectionLabel(label: AppLocalizations.of(context)!.serverSettings),
                        _SettingsTile(
                          icon: Icons.search_rounded,
                          title: AppLocalizations.of(context)!.safeSearch,
                          subtitle: AppLocalizations.of(context)!.safeSearchSettings,
                          thisItem: 0,
                          screenToNavigate: const SafeSearchSettingsScreen(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.list_alt_rounded,
                          title: AppLocalizations.of(context)!.logsSettings,
                          subtitle: AppLocalizations.of(context)!.logsSettingsDescription,
                          thisItem: 1,
                          screenToNavigate: const LogsSettings(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.analytics_rounded,
                          title: AppLocalizations.of(context)!.statisticsSettings,
                          subtitle: AppLocalizations.of(context)!.statisticsSettingsDescription,
                          thisItem: 2,
                          screenToNavigate: const StatisticsSettings(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.lock_rounded,
                          title: AppLocalizations.of(context)!.accessSettings,
                          subtitle: AppLocalizations.of(context)!.accessSettingsDescription,
                          thisItem: 3,
                          screenToNavigate: const AccessSettings(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.install_desktop_rounded,
                          title: AppLocalizations.of(context)!.dhcpSettings,
                          subtitle: AppLocalizations.of(context)!.dhcpSettingsDescription,
                          thisItem: 4,
                          screenToNavigate: const DhcpScreen(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.dns_rounded,
                          title: AppLocalizations.of(context)!.dnsSettings,
                          subtitle: AppLocalizations.of(context)!.dnsSettingsDescription,
                          thisItem: 5,
                          screenToNavigate: DnsSettings(
                            splitView: widget.twoColumns,
                          ),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.security_rounded,
                          title: AppLocalizations.of(context)!.encryptionSettings,
                          subtitle: AppLocalizations.of(context)!.encryptionSettingsDescription,
                          thisItem: 6,
                          screenToNavigate: const EncryptionSettings(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.route_rounded,
                          title: AppLocalizations.of(context)!.dnsRewrites,
                          subtitle: AppLocalizations.of(context)!.dnsRewritesDescription,
                          thisItem: 7,
                          screenToNavigate: const DnsRewritesScreen(),
                          twoColumns: widget.twoColumns,
                        ),
                        if (serversProvider.updateAvailable.data != null) _SettingsTile(
                          icon: Icons.system_update_rounded,
                          title: AppLocalizations.of(context)!.updates,
                          subtitle: AppLocalizations.of(context)!.updatesDescription,
                          trailing: serversProvider.updateAvailable.data != null &&
                            serversProvider.updateAvailable.data!.canAutoupdate == true
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red
                                  ),
                                )
                              : null,
                          thisItem: 8,
                          screenToNavigate: const UpdateScreen(),
                          twoColumns: widget.twoColumns,
                        ),
                        _SettingsTile(
                          icon: Icons.info_rounded,
                          title: AppLocalizations.of(context)!.serverInformation,
                          subtitle: AppLocalizations.of(context)!.serverInformationDescription,
                          thisItem: 9,
                          screenToNavigate: const ServerInformation(),
                          twoColumns: widget.twoColumns,
                        ),
                      ],
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
                          ? statusProvider.serverStatus != null
                            ? "${AppLocalizations.of(context)!.connectedTo} ${serversProvider.selectedServer!.name}"
                            : "${AppLocalizations.of(context)!.selectedServer} ${serversProvider.selectedServer!.name}"
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
                        trailing: Icon(Icons.open_in_new_rounded),
                        onTap: () => openUrl(Urls.appDetailsWebpage),
                      ),
                      CustomListTile(
                        title: AppLocalizations.of(context)!.myOtherApps, 
                        subtitle: AppLocalizations.of(context)!.myOtherAppsDescription,
                        trailing: Icon(Icons.open_in_new_rounded),
                        onTap: () => openUrl(Urls.jgeek00AppsWebpage),
                      ),
                      SizedBox(height: 16)
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