// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/confirm_action_modal.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_leases.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/select_interface_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/dhcp_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class DhcpScreen extends StatefulWidget {
  const DhcpScreen({Key? key}) : super(key: key);

  @override
  State<DhcpScreen> createState() => _DhcpScreenState();
}

class _DhcpScreenState extends State<DhcpScreen> {
  NetworkInterface? selectedInterface;

  bool enabled = false;

  final TextEditingController ipv4StartRangeController = TextEditingController();
  String? ipv4StartRangeError;
  final TextEditingController ipv4EndRangeController = TextEditingController();
  String? ipv4EndRangeError;
  final TextEditingController ipv4SubnetMaskController = TextEditingController();
  String? ipv4SubnetMaskError;
  final TextEditingController ipv4GatewayController = TextEditingController();
  String? ipv4GatewayError;
  final TextEditingController ipv4LeaseTimeController = TextEditingController();
  String? ipv4LeaseTimeError;

  final TextEditingController ipv6StartRangeController = TextEditingController();
  String? ipv6StartRangeError;
  final TextEditingController ipv6EndRangeController = TextEditingController();
  String? ipv6EndRangeError;
  final TextEditingController ipv6LeaseTimeController = TextEditingController();
  String? ipv6LeaseTimeError;

  bool dataValid = false;

  void loadDhcpStatus() async {
    final result = await Provider.of<DhcpProvider>(context, listen: false).loadDhcpStatus();
    if (mounted && result == true) {
      final dhcpProvider = Provider.of<DhcpProvider>(context, listen: false);
      if (dhcpProvider.dhcp != null) {
        setState(() {
          if (dhcpProvider.dhcp!.dhcpStatus.interfaceName != null && dhcpProvider.dhcp!.dhcpStatus.interfaceName != '') {
            try {selectedInterface = dhcpProvider.dhcp!.networkInterfaces.firstWhere((iface) => iface.name == dhcpProvider.dhcp!.dhcpStatus.interfaceName);} catch (_) {}
            enabled = dhcpProvider.dhcp!.dhcpStatus.enabled;
            ipv4StartRangeController.text = dhcpProvider.dhcp!.dhcpStatus.v4.rangeStart;
            ipv4EndRangeController.text = dhcpProvider.dhcp!.dhcpStatus.v4.rangeEnd ?? '';
            ipv4SubnetMaskController.text = dhcpProvider.dhcp!.dhcpStatus.v4.subnetMask ?? '';
            ipv4GatewayController.text = dhcpProvider.dhcp!.dhcpStatus.v4.gatewayIp ?? '';
            ipv4LeaseTimeController.text = dhcpProvider.dhcp!.dhcpStatus.v4.leaseDuration.toString();
          }
        });
      }
    }
    checkDataValid();
  }

  void validateIpV4(String value, String errorVar, String errorMessage) {
    void setValue(String? error) {
      switch (errorVar) {
        case 'ipv4StartRangeError':
          setState(() => ipv4StartRangeError = error);
          break;

        case 'ipv4EndRangeError':
          setState(() => ipv4EndRangeError = error);
          break;

        case 'ipv4SubnetMaskError':
          setState(() => ipv4SubnetMaskError = error);
          break;

        case 'ipv4GatewayError':
          setState(() => ipv4GatewayError = error);
          break;
      }
    }
    final regex = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');
    if (regex.hasMatch(value)) {
      setValue(null);
    }
    else {
      setValue(errorMessage);
    }
    checkDataValid();
  }

  void validateIpV6(String value, String errorVar, String errorMessage) {
    void setValue(String? error) {
      switch (errorVar) {
        case 'ipv6StartRangeError':
          setState(() => ipv4StartRangeError = error);
          break;

        case 'ipv6EndRangeError':
          setState(() => ipv4EndRangeError = error);
          break;

        case 'ipv6GatewayError':
          setState(() => ipv4GatewayError = error);
          break;
      }
    }
    final regex = RegExp(r'^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$');
    if (regex.hasMatch(value)) {
      setValue(null);
    }
    else {
      setValue(errorMessage);
    }
    checkDataValid();
  }

  bool checkDataValid() {
    if (
      ipv4StartRangeController.text != '' &&
      ipv4StartRangeError == null &&
      ipv4EndRangeController.text != '' &&
      ipv4EndRangeError == null &&
      ipv4SubnetMaskController.text != '' && 
      ipv4SubnetMaskError == null &&
      ipv4GatewayController.text != '' &&
      ipv4GatewayError == null 
    ) {
      return true;
    }
    else {
      return false;
    }
  }

  void clearAll() {
    setState(() {
      selectedInterface = null;
      enabled = false;

      ipv4StartRangeController.text = '';
      ipv4StartRangeError = null;
      ipv4StartRangeController.text = '';
      ipv4EndRangeError = null;
      ipv4EndRangeController.text = '';
      ipv4EndRangeError = null;
      ipv4SubnetMaskController.text = '';
      ipv4SubnetMaskError = null;
      ipv4GatewayController.text = '';
      ipv4GatewayError = null;
      ipv4LeaseTimeController.text = '';
      ipv4LeaseTimeError = null;

      ipv6StartRangeController.text = '';
      ipv6StartRangeError = null;
      ipv6EndRangeController.text = '';
      ipv6EndRangeError = null;
      ipv6LeaseTimeController.text = '';
      ipv6LeaseTimeError = null;
    });
  }

  @override
  void initState() {
    if (mounted) loadDhcpStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final dhcpProvider = Provider.of<DhcpProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void saveSettings() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingSettings);

      final result = await serversProvider.apiClient!.saveDhcpConfig(
        data: {
          "enabled": enabled,
          "interface_name": selectedInterface!.name,
          if (selectedInterface!.ipv4Addresses.isNotEmpty) "v4": {
            "gateway_ip": ipv4GatewayController.text,
            "subnet_mask": ipv4SubnetMaskController.text,
            "range_start": ipv4StartRangeController.text,
            "range_end": ipv4EndRangeController.text,
            "lease_duration": ipv4LeaseTimeController.text != '' ? int.parse(ipv4LeaseTimeController.text) : null
          },
          if (selectedInterface!.ipv6Addresses.isNotEmpty) "v6": {
            "range_start": ipv6StartRangeController.text,
            "range_end": ipv6EndRangeController.text,
            "lease_duration": ipv6LeaseTimeController.text != '' ? int.parse(ipv6LeaseTimeController.text) : null
          }
        }
      );

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.settingsSaved, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.settingsNotSaved, 
          color: Colors.red
        );
      }
    }

    void restoreConfig() async {
      Future.delayed(const Duration(seconds: 0), () async {
        ProcessModal processModal = ProcessModal(context: context);
        processModal.open(AppLocalizations.of(context)!.restoringConfig);

        final result = await serversProvider.apiClient!.resetDhcpConfig();

        processModal.close();

        if (result['result'] == 'success') {
          clearAll();

          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.configRestored, 
            color: Colors.green
          );
        }
        else {
          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.configNotRestored, 
            color: Colors.red
          );
        }
      });
    }

    void restoreLeases() async {
      Future.delayed(const Duration(seconds: 0), () async {
        ProcessModal processModal = ProcessModal(context: context);
        processModal.open(AppLocalizations.of(context)!.restoringLeases);

        final result = await serversProvider.apiClient!.restoreAllLeases();

        processModal.close();

        if (result['result'] == 'success') {
          DhcpModel data = dhcpProvider.dhcp!;
          data.dhcpStatus.staticLeases = [];
          data.dhcpStatus.leases = [];
          dhcpProvider.setDhcpData(data);

          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.leasesRestored, 
            color: Colors.green
          );
        }
        else {
          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.leasesNotRestored, 
            color: Colors.red
          );
        }
      });
    }

    void askRestoreLeases() {
      Future.delayed(const Duration(seconds: 0), () => {
        showDialog(
          context: context, 
          builder: (context) => ConfirmActionModal(
            icon: Icons.settings_backup_restore_rounded,
            title: AppLocalizations.of(context)!.restoreLeases,
            message: AppLocalizations.of(context)!.restoreLeasesMessage, 
            onConfirm: () => restoreLeases()
          )
        )
      });
    }

    void askRestoreConfig() {
      Future.delayed(const Duration(seconds: 0), () => {
        showDialog(
          context: context, 
          builder: (context) => ConfirmActionModal(
            icon: Icons.restore,
            title: AppLocalizations.of(context)!.restoreConfiguration,
            message: AppLocalizations.of(context)!.restoreConfigurationMessage,
            onConfirm: () => restoreConfig()
          )
        )
      });
    }

    void selectInterface() {
      ScaffoldMessenger.of(context).clearSnackBars();
      Future.delayed(const Duration(seconds: 0), () {
        if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
          showDialog(
            context: context, 
            builder: (context) => SelectInterfaceModal(
              interfaces: dhcpProvider.dhcp!.networkInterfaces, 
              onSelect: (interface) => setState(() {
                clearAll();
                selectedInterface = interface;
              }),
              dialog: true,
            )
          );
        }
        else {
          showModalBottomSheet(
            context: context, 
            builder: (context) => SelectInterfaceModal(
              interfaces: dhcpProvider.dhcp!.networkInterfaces, 
              onSelect: (i) => setState(() {
                clearAll();
                selectedInterface = i;
              }),
              dialog: false,
            ),
            isScrollControlled: true
          );
        }
      });
    }

    Widget generateBody() {
      switch (dhcpProvider.loadStatus) {
        case LoadStatus.loading:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingDhcp,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );
        
        case LoadStatus.loaded:
          if (selectedInterface != null) {
            return SingleChildScrollView(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 16, 
                      right: 16
                    ),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(28),
                      child: InkWell(
                        onTap: selectedInterface != null
                          ? () => setState(() => enabled = !enabled)
                          : null,
                        borderRadius: BorderRadius.circular(28),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.enableDhcpServer,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).colorScheme.onSurface
                                    ),
                                  ),
                                  if (selectedInterface != null) ...[
                                    Text(
                                      selectedInterface!.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).listTileTheme.textColor
                                      ),
                                    )
                                  ]
                                ],
                              ),
                              Switch(
                                value: enabled, 
                                onChanged: selectedInterface != null
                                  ? (value) => setState(() => enabled = value)
                                  : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (selectedInterface!.ipv4Addresses.isNotEmpty) ...[
                    SectionLabel(
                      label: AppLocalizations.of(context)!.ipv4settings,
                      padding: const EdgeInsets.only(
                        top: 24, left: 16, right: 16, bottom: 8
                      )
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 8)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv4StartRangeController,
                          onChanged: (value) => validateIpV4(value, 'ipv4StartRangeError', AppLocalizations.of(context)!.ipNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.skip_previous_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv4StartRangeError,
                            labelText: AppLocalizations.of(context)!.startOfRange,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 16)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv4EndRangeController,
                          onChanged: (value) => validateIpV4(value, 'ipv4EndRangeError', AppLocalizations.of(context)!.ipNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.skip_next_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv4EndRangeError,
                            labelText: AppLocalizations.of(context)!.endOfRange,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 8)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv4SubnetMaskController,
                          onChanged: (value) => validateIpV4(value, 'ipv4SubnetMaskError', AppLocalizations.of(context)!.subnetMaskNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.hub_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv4SubnetMaskError,
                            labelText: AppLocalizations.of(context)!.subnetMask,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 16)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv4GatewayController,
                          onChanged: (value) => validateIpV4(value, 'ipv4GatewayError', AppLocalizations.of(context)!.gatewayNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.router_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv4GatewayError,
                            labelText: AppLocalizations.of(context)!.gateway,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv4LeaseTimeController,
                          onChanged: (value) {
                            if (int.tryParse(value).runtimeType == int) {
                              setState(() => ipv4LeaseTimeError = null);
                            }
                            else {
                              setState(() => ipv4LeaseTimeError = AppLocalizations.of(context)!.leaseTimeNotValid);
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.timer),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv4LeaseTimeError,
                            labelText: AppLocalizations.of(context)!.leaseTime,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                  if (selectedInterface!.ipv6Addresses.isNotEmpty) ...[
                    SectionLabel(
                      label: AppLocalizations.of(context)!.ipv6settings,
                      padding: const EdgeInsets.all(16)
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 8, bottom: 12, left: 16, right: 8)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv6StartRangeController,
                          onChanged: (value) => validateIpV4(value, 'ipv6StartRangeError', AppLocalizations.of(context)!.ipNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.skip_next_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv6StartRangeError,
                            labelText: AppLocalizations.of(context)!.startOfRange,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: width > 900 ? 0.5 : 1,
                      child: Padding(
                        padding: width > 900
                          ? const EdgeInsets.only(top: 8, bottom: 12, left: 8, right: 16)
                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv6EndRangeController,
                          onChanged: (value) => validateIpV4(value, 'ipv6EndRangeError', AppLocalizations.of(context)!.ipNotValid),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.skip_previous_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv6EndRangeError,
                            labelText: AppLocalizations.of(context)!.endOfRange,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextFormField(
                          controller: ipv6LeaseTimeController,
                          onChanged: (value) {
                            if (int.tryParse(value).runtimeType == int) {
                              setState(() => ipv6LeaseTimeError = null);
                            }
                            else {
                              setState(() => ipv6LeaseTimeError = AppLocalizations.of(context)!.leaseTimeNotValid);
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.timer),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            errorText: ipv6LeaseTimeError,
                            labelText: AppLocalizations.of(context)!.leaseTime,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SectionLabel(
                    label: AppLocalizations.of(context)!.dhcpLeases,
                    padding: const EdgeInsets.all(16),
                  ),
                  if (width <= 900) Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DhcpLeases(
                            items: dhcpProvider.dhcp!.dhcpStatus.leases,
                            staticLeases: false,
                          )
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dhcpLeases,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (width <= 900) Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DhcpLeases(
                            items: dhcpProvider.dhcp!.dhcpStatus.staticLeases,
                            staticLeases: true,
                          )
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dhcpStatic,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (width > 900) Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!(Platform.isAndroid || Platform.isIOS)) {
                            SplitView.of(context).push(
                              DhcpLeases(
                                items: dhcpProvider.dhcp!.dhcpStatus.leases,
                                staticLeases: false,
                              )
                            );
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DhcpLeases(
                                items: dhcpProvider.dhcp!.dhcpStatus.leases,
                                staticLeases: false,
                              )
                            ));
                          }
                        },
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.dhcpLeases),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded)
                          ],
                        )
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!(Platform.isAndroid || Platform.isIOS)) {
                            SplitView.of(context).push(
                              DhcpLeases(
                                items: dhcpProvider.dhcp!.dhcpStatus.staticLeases,
                                staticLeases: true,
                              )
                            );
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DhcpLeases(
                                items: dhcpProvider.dhcp!.dhcpStatus.staticLeases,
                                staticLeases: true,
                              )
                            ));
                          }
                        }, 
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.dhcpStatic),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded)
                          ],
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            );
          } 
          else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppLocalizations.of(context)!.neededSelectInterface,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: selectInterface, 
                        child: Text(AppLocalizations.of(context)!.selectInterface)
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          
        case LoadStatus.error:
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
                  AppLocalizations.of(context)!.dhcpSettingsNotLoaded,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        title: Text(AppLocalizations.of(context)!.dhcpSettings),
        centerTitle: false,
        actions: selectedInterface != null ? [
          IconButton(
            onPressed: checkDataValid() == true
              ? () => saveSettings()
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: selectInterface,
                child: Row(
                  children: [
                    const Icon(Icons.swap_horiz_rounded),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.changeInterface)
                  ],
                )
              ), 
              PopupMenuItem(
                onTap: askRestoreLeases,
                child: Row(
                  children: [
                    const Icon(Icons.settings_backup_restore_rounded),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.restoreLeases)
                  ],
                )
              ),
              PopupMenuItem(
                onTap: askRestoreConfig,
                child: Row(
                  children: [
                    const Icon(Icons.restore),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.restoreConfiguration)
                  ],
                )
              ),
            ] 
          ),
          const SizedBox(width: 10)
        ] : null,
      ),
      body: generateBody(),
    );
  }
}