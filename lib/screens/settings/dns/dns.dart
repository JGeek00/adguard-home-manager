import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dns/cache_config.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns_server_settings.dart';
import 'package:adguard_home_manager/screens/settings/dns/bootstrap_dns.dart';
import 'package:adguard_home_manager/screens/settings/dns/private_reverse_servers.dart';
import 'package:adguard_home_manager/screens/settings/dns/upstream_dns.dart';

class DnsSettings extends StatelessWidget {
  const DnsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.dnsSettings),
      ),
      body: ListView(
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
              builder: (context) => const UpstreamDnsScreen()
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
              builder: (context) => const BootstrapDnsScreen()
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
              builder: (context) => const PrivateReverseDnsServersScreen()
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
              builder: (context) => const DnsServerSettingsScreen()
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
              builder: (context) => const CacheConfigDnsScreen()
            )),
          ),
        ],
      ),
    );
  }
}