import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class UpstreamDnsScreen extends StatefulWidget {
  final ServersProvider serversProvider;

  const UpstreamDnsScreen({
    Key? key,
    required this.serversProvider,
  }) : super(key: key);

  @override
  State<UpstreamDnsScreen> createState() => _UpstreamDnsScreenState();
}

class _UpstreamDnsScreenState extends State<UpstreamDnsScreen> {
  List<TextEditingController> upstreamControllers = [];

  String upstreamMode = "load_balancing";

  @override
  void initState() {
    for (var item in widget.serversProvider.dnsInfo.data!.upstreamDns) {
      final controller = TextEditingController();
      controller.text = item;
      upstreamControllers.add(controller);
    }
    upstreamMode = widget.serversProvider.dnsInfo.data!.upstreamMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.upstreamDns),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => upstreamControllers.add(TextEditingController())), 
                icon: const Icon(Icons.add), 
                label: Text(AppLocalizations.of(context)!.addItem)
              ),
            ],
          ),
          SectionLabel(label: AppLocalizations.of(context)!.dnsMode),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.loadBalancing,
            subtitle: AppLocalizations.of(context)!.loadBalancingDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "parallel", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.parallelRequests,
            subtitle: AppLocalizations.of(context)!.parallelRequestsDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "fastest_addr", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.fastestIpAddress,
            subtitle: AppLocalizations.of(context)!.fastestIpAddressDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
        ],
      ),
    );
  }
}