import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns_mode_modal.dart';

class DnsSettings extends StatefulWidget {
  const DnsSettings({Key? key}) : super(key: key);

  @override
  State<DnsSettings> createState() => _DnsSettingsState();
}

class _DnsSettingsState extends State<DnsSettings> {
  List<TextEditingController> upstreamControllers = [
    TextEditingController()
  ];

  String upstreamMode = "load_balancing";

  @override
  Widget build(BuildContext context) {
    void openDnsModalSheet() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => DnsModeModal(
          upstreamMode: upstreamMode,
          onConfirm: (value) => setState(() => upstreamMode = value),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    String getStringUpstreamMode() {
      switch (upstreamMode) {
        case 'load_balancing':
          return AppLocalizations.of(context)!.loadBalancing;

        case 'parallel_requests':
          return AppLocalizations.of(context)!.parallelRequests;

        case 'fastest_ip_address':
          return AppLocalizations.of(context)!.fastestIpAddress;

        default:
          return AppLocalizations.of(context)!.noDnsMode;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsSettings),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionLabel(label: AppLocalizations.of(context)!.upstreamDns),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () => setState(() => upstreamControllers.add(TextEditingController())), 
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
          if (upstreamControllers.isEmpty) Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noUpstreamDns,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          ...upstreamControllers.map((c) => Padding(
            padding: const EdgeInsets.only(
              left: 24, right: 10, bottom: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width-90,
                  child: TextFormField(
                    controller: c,
                    // onChanged: (_) => checkValidValues(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.dns_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      labelText: AppLocalizations.of(context)!.dnsServer,
                    )
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => upstreamControllers = upstreamControllers.where((con) => con != c).toList()), 
                  icon: const Icon(Icons.remove_circle_outline)
                )
              ],
            ),
          )).toList(),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: openDnsModalSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dnsMode,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      getStringUpstreamMode(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}