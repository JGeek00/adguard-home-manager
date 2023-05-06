// ignore_for_file: use_build_context_synchronously

import 'dart:io';

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

import 'package:adguard_home_manager/functions/clear_dns_cache.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class DnsSettings extends StatelessWidget {
  const DnsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return DnsSettingsWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}
class DnsSettingsWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const DnsSettingsWidget({
    required this.serversProvider,
    required this.appConfigProvider,
    Key? key
  }) : super(key: key);

  @override
  State<DnsSettingsWidget> createState() => _DnsSettingsWidgetState();
}

class _DnsSettingsWidgetState extends State<DnsSettingsWidget> {

  void fetchData({bool? showRefreshIndicator}) async {
    widget.serversProvider.setDnsInfoLoadStatus(0, showRefreshIndicator ?? false);

    final result = await getDnsInfo(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setDnsInfoData(result['data']);
        widget.serversProvider.setDnsInfoLoadStatus(1, true);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setDnsInfoLoadStatus(2, true);
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void navigate(Widget widget) {
      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
        SplitView.of(context).push(widget);
      }
      else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => widget
        ));
      }
    }

    Widget generateBody() {
      switch (widget.serversProvider.dnsInfo.loadStatus) {
        case 0:
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

        case 1:
          return ListView(
            children: [
              CustomListTile(
                title: AppLocalizations.of(context)!.upstreamDns,
                subtitle: AppLocalizations.of(context)!.upstreamDnsDescription,
                onTap: () => navigate(
                  UpstreamDnsScreen(
                    serversProvider: serversProvider
                  )
                ),
                icon: Icons.upload_rounded,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.bootstrapDns,
                subtitle: AppLocalizations.of(context)!.bootstrapDnsDescription,
                onTap: () => navigate(
                  BootstrapDnsScreen(
                    serversProvider: serversProvider
                  )
                ),
                icon: Icons.dns_rounded,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.privateReverseDnsServers,
                subtitle: AppLocalizations.of(context)!.privateReverseDnsDescription,
                onTap: () => navigate(
                  PrivateReverseDnsServersScreen(
                    serversProvider: serversProvider
                  )
                ),
                icon: Icons.person_rounded,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.dnsServerSettings,
                subtitle: AppLocalizations.of(context)!.dnsServerSettingsDescription,
                onTap: () => navigate(
                  DnsServerSettingsScreen(
                    serversProvider: serversProvider
                  )
                ),
                icon: Icons.settings,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.dnsCacheConfig,
                subtitle: AppLocalizations.of(context)!.dnsCacheConfigDescription,
                onTap: () => navigate(
                  CacheConfigDnsScreen(
                    serversProvider: serversProvider
                  )
                ),
                icon: Icons.storage_rounded,
              ),
            ],
          );

        case 2:
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
    }

    void clearCache() async {
      final result = await clearDnsCache(context, serversProvider.selectedServer!);
      if (result == true) {
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => fetchData(showRefreshIndicator: true), 
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
      body: generateBody(),
    );
  }
}