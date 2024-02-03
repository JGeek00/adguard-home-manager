// ignore_for_file: use_build_context_synchronously

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class DnsServerSettingsScreen extends StatefulWidget {
  const DnsServerSettingsScreen({super.key});

  @override
  State<DnsServerSettingsScreen> createState() => _DnsServerSettingsScreenState();
}

class _DnsServerSettingsScreenState extends State<DnsServerSettingsScreen> {
  final _limitRequestsController = TextEditingController();
  final _ipv4PrefixSubnetController = TextEditingController();
  String? _ipv4PrefixSubnetError;
  final _ipv6PrefixSubnetController = TextEditingController();
  String? _ipv6PrefixSubnetError;
  String? _limitRequestsError;
  final _expandableCustomEdns = ExpandableController();
  final _expandableEdnsIp = ExpandableController();
  bool _enableEdns = false;
  bool _useCustomIpEdns = false;
  final _customIpEdnsController = TextEditingController();
  String? _ednsIpError;
  bool _enableDnssec = false;
  bool _disableIpv6Resolving = false;

  String blockingMode = "default";

  final _ipv4controller = TextEditingController();
  String? _ipv4error;
  final _ipv6controller = TextEditingController();
  String? ipv6error;

  final _ttlController = TextEditingController();
  String? _ttlError;

  void validateIpv4(String value) {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => _ipv4error = null);
    }
    else {
      setState(() => _ipv4error = AppLocalizations.of(context)!.invalidIp);
    }
  }

  void validateEdns(String value) {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => _ednsIpError = null);
    }
    else {
      setState(() => _ednsIpError = AppLocalizations.of(context)!.ipNotValid);
    }
  }

  void validateIpv6(String value) {
    RegExp ipAddress = RegExp(r'(?:^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}$)|(?:^(?:(?:[a-fA-F\d]{1,4}:){7}(?:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){6}(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){5}(?::(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,2}|:)|(?:[a-fA-F\d]{1,4}:){4}(?:(?::[a-fA-F\d]{1,4}){0,1}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,3}|:)|(?:[a-fA-F\d]{1,4}:){3}(?:(?::[a-fA-F\d]{1,4}){0,2}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,4}|:)|(?:[a-fA-F\d]{1,4}:){2}(?:(?::[a-fA-F\d]{1,4}){0,3}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,5}|:)|(?:[a-fA-F\d]{1,4}:){1}(?:(?::[a-fA-F\d]{1,4}){0,4}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,6}|:)|(?::(?:(?::[a-fA-F\d]{1,4}){0,5}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,7}|:)))(?:%[0-9a-zA-Z]{1,})?$)');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => ipv6error = null);
    }
    else {
      setState(() => ipv6error = AppLocalizations.of(context)!.invalidIp);
    }
  }

  bool validateData() {
    if (
      (_limitRequestsController.text == "" || (_limitRequestsController.text != "" && _limitRequestsError == null)) &&
      (
        blockingMode != 'custom_ip' ||
        (
          blockingMode == 'custom_ip' && 
          _ipv4controller.text != '' &&
          _ipv4error == null &&
          _ipv6controller.text != '' &&
          ipv6error == null
        )
      ) == true && 
      _ednsIpError == null && 
      _ttlController.text != "" && _ttlError == null &&
      (_ipv4PrefixSubnetController.text == "" || (_ipv4PrefixSubnetController.text != "" && _ipv4PrefixSubnetError == null)) &&
      (_ipv6PrefixSubnetController.text == "" || (_ipv6PrefixSubnetController.text != "" && _ipv6PrefixSubnetError == null))
    ) {
      return true;
    }
    else {
      return false;
    }
  }

  String? validateTtl(String value) {
    if (value == "") return AppLocalizations.of(context)!.valueNotNumber;
    if (int.tryParse(value) != null) {
      return null;
    }
    else {
      return AppLocalizations.of(context)!.valueNotNumber;
    }
  }

  String? validateNumber(String value) {
    if (value == "") return null;
    if (int.tryParse(value) != null) {
      return null;
    }
    else {
      return AppLocalizations.of(context)!.valueNotNumber;
    }
  }

  @override
  void initState() {
    final dnsProvider = Provider.of<DnsProvider>(context, listen: false);

    _limitRequestsController.text = dnsProvider.dnsInfo!.ratelimit.toString();
    _enableEdns = dnsProvider.dnsInfo!.ednsCsEnabled;
    _useCustomIpEdns = dnsProvider.dnsInfo!.ednsCsUseCustom ?? false;
    _customIpEdnsController.text = dnsProvider.dnsInfo!.ednsCsCustomIp ?? "";
    if (dnsProvider.dnsInfo!.ednsCsEnabled == true) _expandableCustomEdns.toggle();
    if (dnsProvider.dnsInfo!.ednsCsUseCustom == true) _expandableEdnsIp.toggle();
    _enableDnssec = dnsProvider.dnsInfo!.dnssecEnabled;
    _disableIpv6Resolving = dnsProvider.dnsInfo!.disableIpv6;
    blockingMode = dnsProvider.dnsInfo!.blockingMode;
    _ipv4controller.text = dnsProvider.dnsInfo!.blockingIpv4;
    _ipv6controller.text = dnsProvider.dnsInfo!.blockingIpv6;
    _ttlController.text = dnsProvider.dnsInfo!.blockedResponseTtl != null
      ? dnsProvider.dnsInfo!.blockedResponseTtl.toString()
      : "";
    _ipv4PrefixSubnetController.text = dnsProvider.dnsInfo!.ratelimitSubnetLenIpv4 != null
      ? dnsProvider.dnsInfo!.ratelimitSubnetLenIpv4.toString()
      : "";
    _ipv6PrefixSubnetController.text = dnsProvider.dnsInfo!.ratelimitSubnetLenIpv6 != null
      ? dnsProvider.dnsInfo!.ratelimitSubnetLenIpv6.toString()
      : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dnsProvider = Provider.of<DnsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final width = MediaQuery.of(context).size.width;

    void saveData() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await dnsProvider.saveDnsServerConfig({
        "ratelimit": int.parse(_limitRequestsController.text),
        "edns_cs_enabled": _enableEdns,
        "edns_cs_use_custom": _useCustomIpEdns,
        "edns_cs_custom_ip": _customIpEdnsController.text,
        "dnssec_enabled": _enableDnssec,
        "disable_ipv6": _disableIpv6Resolving,
        "blocking_mode": blockingMode,
        "blocking_ipv4": _ipv4controller.text,
        "blocking_ipv6": _ipv6controller.text,
        "blocked_response_ttl": int.tryParse(_ttlController.text),
        "ratelimit_subnet_len_ipv4": int.tryParse(_ipv4PrefixSubnetController.text),
        "ratelimit_subnet_len_ipv6": int.tryParse(_ipv6PrefixSubnetController.text),
      });

      processModal.close();

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigSaved, 
          color: Colors.green
        );
      }
      else if (result.successful == false && result.statusCode == 400) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.someValueNotValid, 
          color: Colors.red
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigNotSaved, 
          color: Colors.red
        );
      } 
    }

    void updateBlockingMode(String mode) {
      if (mode != 'custom_ip') {
        _ipv4controller.text = '';
        _ipv4error = null;
        _ipv6controller.text = '';
        ipv6error = null;
      }
      setState(() => blockingMode = mode);
      validateData();
    }

    final dataValid = validateData();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsServerSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        actions: [
          IconButton(
            onPressed: dataValid == true
              ? () => saveData()
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _limitRequestsController,
                onChanged: (v) => setState(() => _limitRequestsError = validateNumber(v)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.looks_one_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  labelText: AppLocalizations.of(context)!.limitRequestsSecond,
                  errorText: _limitRequestsError
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: TextFormField(
                controller: _ipv4PrefixSubnetController,
                onChanged: (v) => setState(() => _ipv4PrefixSubnetError = validateNumber(v)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.skip_previous_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  labelText: AppLocalizations.of(context)!.subnetPrefixLengthIpv4,
                  errorText: _ipv4PrefixSubnetError
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _ipv6PrefixSubnetController,
                onChanged: (v) => setState(() => _ipv6PrefixSubnetError = validateNumber(v)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.skip_previous_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  labelText: AppLocalizations.of(context)!.subnetPrefixLengthIpv6,
                  errorText: _ipv6PrefixSubnetError
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            CustomSwitchListTile(
              value: _enableEdns, 
              onChanged: (value) => setState(() {
                _enableEdns = value;
                _expandableCustomEdns.toggle();
                if (value == false) {
                  _useCustomIpEdns = false;
                  if (_expandableEdnsIp.expanded == true) _expandableEdnsIp.toggle();
                  _customIpEdnsController.text = "";
                  _ednsIpError = null;
                }
                validateData();
              }), 
              title: AppLocalizations.of(context)!.enableEdns,
              subtitle: AppLocalizations.of(context)!.enableEdnsDescription,
            ),
            ExpandableNotifier(
              controller: _expandableCustomEdns,
              child: Expandable(
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    CustomSwitchListTile(
                      padding: const EdgeInsets.only(
                        left: 50,
                        top: 12,
                        bottom: 12,
                        right: 16
                      ),
                      value: _useCustomIpEdns, 
                      onChanged: (value) => setState(() {
                        _useCustomIpEdns = value;
                        _expandableEdnsIp.toggle();
                        if (_useCustomIpEdns == false) {
                          _customIpEdnsController.text = "";
                          _ednsIpError = null;
                        }
                        validateData();
                      }), 
                      title: AppLocalizations.of(context)!.useCustomIpEdns,
                      subtitle: AppLocalizations.of(context)!.useCustomIpEdnsDescription,
                    ),
                    ExpandableNotifier(
                      controller: _expandableEdnsIp,
                      child: Expandable(
                        collapsed: const SizedBox(),
                        expanded: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                            right: 16,
                            left: 70
                          ),
                          child: TextFormField(
                            controller: _customIpEdnsController,
                            onChanged: validateEdns,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.link_rounded),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                                )
                              ),
                              errorText: _ednsIpError,
                              labelText: AppLocalizations.of(context)!.ipAddress,
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ),
            CustomSwitchListTile(
              value: _enableDnssec, 
              onChanged: (value) => setState(() => _enableDnssec = value), 
              title: AppLocalizations.of(context)!.enableDnssec,
              subtitle: AppLocalizations.of(context)!.enableDnssecDescription,
            ),
            CustomSwitchListTile(
              value: _disableIpv6Resolving, 
              onChanged: (value) => setState(() => _disableIpv6Resolving = value), 
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
                  controller: _ipv4controller,
                  onChanged: validateIpv4,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.link_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: _ipv4error,
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
                  controller: _ipv6controller,
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
              const SizedBox(height: 30),
            ],
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _ttlController,
                onChanged: (v) => setState(() => _ttlError = validateTtl(v)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.timer_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  errorText: _ttlError,
                  labelText: AppLocalizations.of(context)!.blockedResponseTtl,
                  helperText: AppLocalizations.of(context)!.blockedResponseTtlDescription,
                  helperMaxLines: 2,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}