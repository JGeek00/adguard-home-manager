// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';

import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
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

  String upstreamMode = "";

  bool validValues = false;

  checkValidValues() {
    if (
      upstreamControllers.isNotEmpty &&
      upstreamControllers.every((element) => element.text != '')
    ) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  @override
  void initState() {
    for (var item in widget.serversProvider.dnsInfo.data!.upstreamDns) {
      final controller = TextEditingController();
      controller.text = item;
      upstreamControllers.add(controller);
    }
    upstreamMode = widget.serversProvider.dnsInfo.data!.upstreamMode;
    validValues = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void saveData() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await setDnsConfig(server: serversProvider.selectedServer!, data: {
        "upstream_dns": upstreamControllers.map((e) => e.text).toList(),
        "upstream_mode": upstreamMode
      });

      processModal.close();

      if (result['result'] == 'success') {
        DnsInfoData data = serversProvider.dnsInfo.data!;
        data.upstreamDns = upstreamControllers.map((e) => e.text).toList();
        data.upstreamMode = upstreamMode;
        serversProvider.setDnsInfoData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigSaved, 
          color: Colors.green
        );
      }
      else if (result['log'] != null && result['log'].statusCode == '400') {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.someValueNotValid, 
          color: Colors.red
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigNotSaved, 
          color: Colors.red
        );
      } 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.upstreamDns),
        actions: [
          IconButton(
            onPressed: validValues == true
              ? () => saveData()
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 10)
        ],
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
                    onChanged: (_) => checkValidValues(),
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
                  onPressed: () {
                    setState(() => upstreamControllers = upstreamControllers.where((con) => con != c).toList());
                    checkValidValues();
                  }, 
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
                onPressed: () {
                  setState(() => upstreamControllers.add(TextEditingController()));
                  checkValidValues();
                }, 
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