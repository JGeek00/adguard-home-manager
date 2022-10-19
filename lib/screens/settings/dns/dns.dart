import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dns/cache_config.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns_server_settings.dart';
import 'package:adguard_home_manager/screens/settings/dns/bootstrap_dns.dart';
import 'package:adguard_home_manager/screens/settings/dns/private_reverse_servers.dart';
import 'package:adguard_home_manager/screens/settings/dns/upstream_dns.dart';

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

  void fetchData() async {
    widget.serversProvider.setDnsInfoLoadStatus(0, false);

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
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          );

        case 1:
          return ListView(
            children: [
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.upstreamDns,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UpstreamDnsScreen(
                    serversProvider: serversProvider
                  )
                )),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.bootstrapDns,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BootstrapDnsScreen(
                    serversProvider: serversProvider
                  )
                )),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.privateReverseDnsServers,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PrivateReverseDnsServersScreen(
                    serversProvider: serversProvider
                  )
                )),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.dnsServerSettings,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DnsServerSettingsScreen(
                    serversProvider: serversProvider
                  )
                )),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.dnsCacheConfig,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CacheConfigDnsScreen(
                    serversProvider: serversProvider
                  )
                )),
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
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.dnsSettings),
      ),
      body: generateBody(),
    );
  }
}