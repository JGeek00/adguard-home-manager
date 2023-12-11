import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class _Item {
  final String url;
  final bool value;

  const _Item({
    required this.url,
    required this.value
  });
}

class TestUpstreamDnsModal extends StatefulWidget {
  const TestUpstreamDnsModal({super.key});

  @override
  State<TestUpstreamDnsModal> createState() => _TestUpstreamDnsModalState();
}

class _TestUpstreamDnsModalState extends State<TestUpstreamDnsModal> {
  LoadStatus loadStatus = LoadStatus.loading;
  List<_Item>? values;

  void checkDns() async {
    final dnsProvider = Provider.of<DnsProvider>(context, listen: false);
    final result = await Provider.of<ServersProvider>(context, listen: false).apiClient2!.testUpstreamDns(
      body: {
        "bootstrap_dns": dnsProvider.dnsInfo!.bootstrapDns,
        "fallback_dns": [],
        "private_upstream": dnsProvider.dnsInfo!.defaultLocalPtrUpstreams,
        "upstream_dns": dnsProvider.dnsInfo!.upstreamDns
      }
    );
    if (!mounted) return;
    if (result.successful == true) {
      setState(() {
        values = List<_Item>.from(
          (result.content as Map<String, dynamic>).entries.map((e) => _Item(
            url: e.key, 
            value: e.value == "OK" ? true : false
          ))  
        );
        loadStatus = LoadStatus.loaded;
      });
    }
    else {
      setState(() => loadStatus = LoadStatus.error);
    }
  }

  @override
  void initState() {
    checkDns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.upload_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.testUpstreamDnsServers,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500
        ),
        child: Builder(
          builder: (context) {
            switch (loadStatus) {
              case LoadStatus.loading:
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator()
                    ],
                  ),
                );
        
              case LoadStatus.loaded:
                return SingleChildScrollView(
                  child: Wrap(
                    children: values!.map((v) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              v.url,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ...[
                            const SizedBox(width: 8),
                            if (v.value == true) const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: 16,
                            ),
                            if (v.value == false) const Icon(
                              Icons.cancel_rounded,
                              color: Colors.red,
                            )
                          ]
                        ],
                      ),
                    )).toList(),
                  ),
                );
              
              case LoadStatus.error:
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 30,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.errorTestUpstreamDns,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    )
                  ],
                );
        
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.close)
        ),
      ],
    );
  }
}