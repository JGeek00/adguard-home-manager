// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dns/clear_dns_cache_dialog.dart';
import 'package:adguard_home_manager/screens/settings/dns/cache_config.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns_server_settings.dart';
import 'package:adguard_home_manager/screens/settings/dns/bootstrap_dns.dart';
import 'package:adguard_home_manager/screens/settings/dns/private_reverse_servers.dart';
import 'package:adguard_home_manager/screens/settings/dns/upstream_dns.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/functions/clear_dns_cache.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class DnsSettings extends StatefulWidget {
  final bool splitView;

  const DnsSettings({
    Key? key,
    required this.splitView,
  }) : super(key: key);

  @override
  State<DnsSettings> createState() => _DnsSettingsState();
}

class _DnsSettingsState extends State<DnsSettings> {
  @override
  void initState() {
    Provider.of<DnsProvider>(context, listen: false).fetchDnsData(showLoading: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final dnsProvider = Provider.of<DnsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void navigate(Widget w) {
      if (widget.splitView) {
        SplitView.of(context).push(w);
      }
      else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => w
          )
        );
      }
    }

    void clearCache() async {
      final result = await clearDnsCache(context, serversProvider.selectedServer!);
      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.dnsCacheCleared, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.dnsCacheNotCleared, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.dnsSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => dnsProvider.fetchDnsData(),
                child: Row(
                  children: [
                    const Icon(Icons.refresh_rounded),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.refresh)
                  ],
                )
              ),
              PopupMenuItem(
                onTap: () => Future.delayed(
                  const Duration(seconds: 0), () => showDialog(
                    context: context, 
                    builder: (context) => ClearDnsCacheDialog(
                      onConfirm: clearCache
                    )
                  )
                ),
                child: Row(
                  children: [
                    const Icon(Icons.delete_rounded),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.clearDnsCache)
                  ],
                )
              ),
            ]
          ), 
          const SizedBox(width: 10)
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (dnsProvider.loadStatus) {
            case LoadStatus.loading:
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.loadingDnsConfig,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                )
              );

            case LoadStatus.loaded:
              return ListView(
                children: [
                  CustomListTile(
                    title: AppLocalizations.of(context)!.upstreamDns,
                    subtitle: AppLocalizations.of(context)!.upstreamDnsDescription,
                    onTap: () => navigate(const UpstreamDnsScreen()),
                    icon: Icons.upload_rounded,
                  ),
                  CustomListTile(
                    title: AppLocalizations.of(context)!.bootstrapDns,
                    subtitle: AppLocalizations.of(context)!.bootstrapDnsDescription,
                    onTap: () => navigate(const BootstrapDnsScreen()),
                    icon: Icons.dns_rounded,
                  ),
                  CustomListTile(
                    title: AppLocalizations.of(context)!.privateReverseDnsServers,
                    subtitle: AppLocalizations.of(context)!.privateReverseDnsDescription,
                    onTap: () => navigate(const PrivateReverseDnsServersScreen()),
                    icon: Icons.person_rounded,
                  ),
                  CustomListTile(
                    title: AppLocalizations.of(context)!.dnsServerSettings,
                    subtitle: AppLocalizations.of(context)!.dnsServerSettingsDescription,
                    onTap: () => navigate(const DnsServerSettingsScreen()),
                    icon: Icons.settings,
                  ),
                  CustomListTile(
                    title: AppLocalizations.of(context)!.dnsCacheConfig,
                    subtitle: AppLocalizations.of(context)!.dnsCacheConfigDescription,
                    onTap: () => navigate(const CacheConfigDnsScreen()),
                    icon: Icons.storage_rounded,
                  ),
                ],
              );

            case LoadStatus.error:
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.dnsConfigNotLoaded,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      )
    );
  }
}