import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

class DnsServerSettingsScreen extends StatefulWidget {
  const DnsServerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DnsServerSettingsScreen> createState() => _DnsServerSettingsScreenState();
}

class _DnsServerSettingsScreenState extends State<DnsServerSettingsScreen> {
  final TextEditingController limitRequestsController = TextEditingController();
  String? limitRequestsError;
  bool enableEdns = false;
  bool enableDnssec = false;
  bool disableIpv6Resolving = false;

  String blockingMode = "default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsServerSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: limitRequestsController,
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() => limitRequestsError = null);
                }
                else {
                  setState(() => limitRequestsError = AppLocalizations.of(context)!.valueNotNumber);
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.looks_one_rounded),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                labelText: AppLocalizations.of(context)!.limitRequestsSecond,
                errorText: limitRequestsError
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 10),
          CustomSwitchListTile(
            value: enableEdns, 
            onChanged: (value) => setState(() => enableEdns = value), 
            title: AppLocalizations.of(context)!.enableEdns,
            subtitle: AppLocalizations.of(context)!.enableEdnsDescription,
          ),
          CustomSwitchListTile(
            value: enableDnssec, 
            onChanged: (value) => setState(() => enableDnssec = value), 
            title: AppLocalizations.of(context)!.enableDnssec,
            subtitle: AppLocalizations.of(context)!.enableDnssecDescription,
          ),
          CustomSwitchListTile(
            value: disableIpv6Resolving, 
            onChanged: (value) => setState(() => disableIpv6Resolving = value), 
            title: AppLocalizations.of(context)!.disableResolvingIpv6,
            subtitle: AppLocalizations.of(context)!.disableResolvingIpv6Description,
          ),
          SectionLabel(label: AppLocalizations.of(context)!.blockingMode),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "default", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.defaultMode,
            subtitle: AppLocalizations.of(context)!.defaultDescription,
            onChanged: (value) => setState(() => blockingMode = value),
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "refused", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: "REFUSED",
            subtitle: AppLocalizations.of(context)!.refusedDescription,
            onChanged: (value) => setState(() => blockingMode = value),
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "nxdomain", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: "NXDOMAIN",
            subtitle: AppLocalizations.of(context)!.nxdomainDescription,
            onChanged: (value) => setState(() => blockingMode = value),
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "null_ip", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.nullIp,
            subtitle: AppLocalizations.of(context)!.nullIpDescription,
            onChanged: (value) => setState(() => blockingMode = value),
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "custom_ip", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.customIp,
            subtitle: AppLocalizations.of(context)!.customIpDescription,
            onChanged: (value) => setState(() => blockingMode = value),
          ),
        ],
      ),
    );
  }
}