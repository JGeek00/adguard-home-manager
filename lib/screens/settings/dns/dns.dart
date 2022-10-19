import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
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

  List<TextEditingController> bootstrapControllers = [
    TextEditingController()
  ];

  List<TextEditingController> privateControllers = [];

  List<String> defaultReverseResolvers = ["80.58.61.250", "80.58.61.251"];
  bool editReverseResolvers = false;
  List<TextEditingController> reverseResolversControllers = [
    TextEditingController()
  ];
  bool usePrivateReverseDnsResolvers = false;
  bool enableReverseResolve = false;


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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionLabel(label: AppLocalizations.of(context)!.bootstrapDns),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () => setState(() => bootstrapControllers.add(TextEditingController())), 
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
          Card(
            margin: const EdgeInsets.only(
              left: 24, right: 24, bottom: 20
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.info_rounded),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-132,
                    child: Text(AppLocalizations.of(context)!.bootstrapDnsServersInfo)
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (bootstrapControllers.isEmpty) Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noBootstrapDns,
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
          ...bootstrapControllers.map((c) => Padding(
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
                  onPressed: () => setState(() => bootstrapControllers = bootstrapControllers.where((con) => con != c).toList()), 
                  icon: const Icon(Icons.remove_circle_outline)
                )
              ],
            ),
          )).toList(),
          SectionLabel(label: AppLocalizations.of(context)!.privateReverseDnsServers),
          Card(
            margin: const EdgeInsets.only(
              left: 24, right: 24, bottom: 10
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.info_rounded),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-132,
                    child: Text(AppLocalizations.of(context)!.privateReverseDnsServersDescription)
                  )
                ],
              ),
            ),
          ),
          if (editReverseResolvers == false) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "${AppLocalizations.of(context)!.reverseDnsDefault}:\n\n${defaultReverseResolvers.map((item) => item).join(', ').toString().replaceAll(RegExp(r'\(|\)'), '')}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => editReverseResolvers = true), 
                    icon: const Icon(Icons.edit), 
                    label: Text(AppLocalizations.of(context)!.edit)
                  ),
                ],
              ),
            )
          ],
          if (editReverseResolvers == true) ...[
            const SizedBox(height: 20),
            ...reverseResolversControllers.map((c) => Padding(
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
                        labelText: AppLocalizations.of(context)!.serverAddress,
                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => reverseResolversControllers = reverseResolversControllers.where((con) => con != c).toList()), 
                    icon: const Icon(Icons.remove_circle_outline)
                  )
                ],
              ),
            )),
            if (reverseResolversControllers.isEmpty) Padding(
              padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 20
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.noServerAddressesAdded,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => reverseResolversControllers.add(TextEditingController())), 
                    icon: const Icon(Icons.add), 
                    label: Text(AppLocalizations.of(context)!.addItem)
                  ),
                ],
              ),
            ),
          ],
          CustomSwitchListTile(
            value: usePrivateReverseDnsResolvers,
            onChanged: (value) => setState(() => usePrivateReverseDnsResolvers = value), 
            title: AppLocalizations.of(context)!.usePrivateReverseDnsResolvers,
            subtitle: AppLocalizations.of(context)!.usePrivateReverseDnsResolversDescription
          ),
          CustomSwitchListTile(
            value: enableReverseResolve,
            onChanged: (value) => setState(() => enableReverseResolve = value), 
            title: AppLocalizations.of(context)!.enableReverseResolving,
            subtitle: AppLocalizations.of(context)!.enableReverseResolvingDescription
          ),
        ],
      ),
    );
  }
}