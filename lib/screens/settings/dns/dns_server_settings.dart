// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class DnsServerSettingsScreen extends StatefulWidget {
  final ServersProvider serversProvider;

  const DnsServerSettingsScreen({
    Key? key,
    required this.serversProvider
  }) : super(key: key);

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

  final TextEditingController ipv4controller = TextEditingController();
  String? ipv4error;
  final TextEditingController ipv6controller = TextEditingController();
  String? ipv6error;

  bool isDataValid = false;

  void validateIpv4(String value) {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => ipv4error = null);
    }
    else {
      setState(() => ipv4error = AppLocalizations.of(context)!.invalidIp);
    }
    validateData();
  }

  void validateIpv6(String value) {
    RegExp ipAddress = RegExp(r'(?:^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}$)|(?:^(?:(?:[a-fA-F\d]{1,4}:){7}(?:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){6}(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){5}(?::(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,2}|:)|(?:[a-fA-F\d]{1,4}:){4}(?:(?::[a-fA-F\d]{1,4}){0,1}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,3}|:)|(?:[a-fA-F\d]{1,4}:){3}(?:(?::[a-fA-F\d]{1,4}){0,2}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,4}|:)|(?:[a-fA-F\d]{1,4}:){2}(?:(?::[a-fA-F\d]{1,4}){0,3}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,5}|:)|(?:[a-fA-F\d]{1,4}:){1}(?:(?::[a-fA-F\d]{1,4}){0,4}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,6}|:)|(?::(?:(?::[a-fA-F\d]{1,4}){0,5}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,7}|:)))(?:%[0-9a-zA-Z]{1,})?$)');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => ipv6error = null);
    }
    else {
      setState(() => ipv6error = AppLocalizations.of(context)!.invalidIp);
    }
    validateData();
  }

  void validateData() {
    if (
      limitRequestsController.text != '' &&
      limitRequestsError == null &&
      (
        blockingMode != 'custom_ip' ||
        (
          blockingMode == 'custom_ip' && 
          ipv4controller.text != '' &&
          ipv4error == null &&
          ipv6controller.text != '' &&
          ipv6error == null
        )
      ) == true
    ) {
      setState(() => isDataValid = true);
    }
    else {
      setState(() => isDataValid = false);
    }
  }

  @override
  void initState() {
    limitRequestsController.text = widget.serversProvider.dnsInfo.data!.ratelimit.toString();
    enableEdns = widget.serversProvider.dnsInfo.data!.ednsCsEnabled;
    enableDnssec = widget.serversProvider.dnsInfo.data!.dnssecEnabled;
    disableIpv6Resolving = widget.serversProvider.dnsInfo.data!.disableIpv6;
    blockingMode = widget.serversProvider.dnsInfo.data!.blockingMode;
    ipv4controller.text = widget.serversProvider.dnsInfo.data!.blockingIpv4;
    ipv6controller.text = widget.serversProvider.dnsInfo.data!.blockingIpv6;
    isDataValid = true;
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
        "ratelimit": int.parse(limitRequestsController.text),
        "edns_cs_enabled": enableEdns,
        "dnssec_enabled": enableDnssec,
        "disable_ipv6": disableIpv6Resolving,
        "blocking_mode": blockingMode
      });

      processModal.close();

      if (result['result'] == 'success') {
        DnsInfoData data = serversProvider.dnsInfo.data!;
        data.ratelimit = int.parse(limitRequestsController.text);
        data.ednsCsEnabled = enableEdns;
        data.dnssecEnabled = enableDnssec;
        data.disableIpv6 = disableIpv6Resolving;
        data.blockingMode = blockingMode;
        data.blockingIpv4 = ipv4controller.text;
        data.blockingIpv6 = ipv6controller.text;
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

    void updateBlockingMode(String mode) {
      if (mode != 'custom_ip') {
        ipv4controller.text = '';
        ipv4error = null;
        ipv6controller.text = '';
        ipv6error = null;
      }
      setState(() => blockingMode = mode);
      validateData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsServerSettings),
        actions: [
          IconButton(
            onPressed: isDataValid == true
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: limitRequestsController,
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() => limitRequestsError = null);
                }
                else {
                  setState(() => limitRequestsError = AppLocalizations.of(context)!.valueNotNumber);
                }
                validateData();
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
            onChanged: updateBlockingMode,
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "refused", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: "REFUSED",
            subtitle: AppLocalizations.of(context)!.refusedDescription,
            onChanged: updateBlockingMode,
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "nxdomain", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: "NXDOMAIN",
            subtitle: AppLocalizations.of(context)!.nxdomainDescription,
            onChanged: updateBlockingMode,
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "null_ip", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.nullIp,
            subtitle: AppLocalizations.of(context)!.nullIpDescription,
            onChanged: updateBlockingMode,
          ),
          CustomRadioListTile(
            groupValue: blockingMode, 
            value: "custom_ip", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.customIp,
            subtitle: AppLocalizations.of(context)!.customIpDescription,
            onChanged: updateBlockingMode,
          ),
          const SizedBox(height: 10),
          if (blockingMode == 'custom_ip') ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: ipv4controller,
                onChanged: validateIpv4,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.link_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  errorText: ipv4error,
                  helperText: AppLocalizations.of(context)!.blockingIpv4Description,
                  helperMaxLines: 10,
                  labelText: AppLocalizations.of(context)!.blockingIpv4,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: ipv6controller,
                onChanged: validateIpv6,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.link_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  errorText: ipv6error,
                  helperText: AppLocalizations.of(context)!.blockingIpv6Description,
                  helperMaxLines: 10,
                  labelText: AppLocalizations.of(context)!.blockingIpv6,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30)
          ]
        ],
      ),
    );
  }
}