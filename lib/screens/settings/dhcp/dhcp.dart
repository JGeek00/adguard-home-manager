// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/confirm_action_modal.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_leases.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/select_interface_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Dhcp extends StatelessWidget {
  const Dhcp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return DhcpWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider
    );
  }
}

class DhcpWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const DhcpWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<DhcpWidget> createState() => _DhcpWidgetState();
}

class _DhcpWidgetState extends State<DhcpWidget> {
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
    widget.serversProvider.setDhcpLoadStatus(0, false);

    final result = await getDhcpData(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setDhcpLoadStatus(1, true);
        widget.serversProvider.setDhcpData(result['data']);
        setState(() {
          if (result['data'].dhcpStatus.interfaceName != '') {
            selectedInterface = result['data'].networkInterfaces.firstWhere((interface) => interface.name == result['data'].dhcpStatus.interfaceName);

            enabled = result['data'].dhcpStatus.enabled;
            ipv4StartRangeController.text = result['data'].dhcpStatus.v4.rangeStart;
            ipv4StartRangeController.text = result['data'].dhcpStatus.v4.rangeStart;
            ipv4EndRangeController.text = result['data'].dhcpStatus.v4.rangeEnd;
            ipv4SubnetMaskController.text = result['data'].dhcpStatus.v4.subnetMask;
            ipv4GatewayController.text = result['data'].dhcpStatus.v4.gatewayIp;
            ipv4LeaseTimeController.text = result['data'].dhcpStatus.v4.leaseDuration.toString();
          }
        });
      }
      else {
        widget.serversProvider.setDhcpLoadStatus(2, true);
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
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void saveSettings() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingSettings);

      final result = await saveDhcpConfig(server: serversProvider.selectedServer!, data: {
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
      });

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.settingsSaved, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
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

        final result = await resetDhcpConfig(server: serversProvider.selectedServer!);

        processModal.close();

        if (result['result'] == 'success') {
          clearAll();

          showSnacbkar(
            context: context, 
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.configRestored, 
            color: Colors.green
          );
        }
        else {
          appConfigProvider.addLog(result['log']);

          showSnacbkar(
            context: context, 
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

        final result = await restoreAllLeases(server: serversProvider.selectedServer!);

        processModal.close();

        if (result['result'] == 'success') {
          DhcpData data = serversProvider.dhcp.data!;
          data.dhcpStatus.staticLeases = [];
          data.dhcpStatus.leases = [];
          serversProvider.setDhcpData(data);

          showSnacbkar(
            context: context, 
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.leasesRestored, 
            color: Colors.green
          );
        }
        else {
          appConfigProvider.addLog(result['log']);

          showSnacbkar(
            context: context, 
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
        showFlexibleBottomSheet(
          minHeight: 0.6,
          initHeight: 0.6,
          maxHeight: 0.95,
          isCollapsible: true,
          duration: const Duration(milliseconds: 250),
          anchors: [0.95],
          context: context, 
          builder: (ctx, controller, offset) => SelectInterfaceModal(
            interfaces: serversProvider.dhcp.data!.networkInterfaces, 
            scrollController: controller,
            onSelect: (interface) => setState(() {
              clearAll();
              selectedInterface = interface;
            })
          ),
          bottomSheetColor: Colors.transparent
        );
      });
    }

    Widget generateBody() {
      switch (serversProvider.dhcp.loadStatus) {
        case 0:
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
        
        case 1:
          if (selectedInterface != null) {
            return ListView(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                ],
                if (selectedInterface!.ipv6Addresses.isNotEmpty) ...[
                  SectionLabel(
                    label: AppLocalizations.of(context)!.ipv6settings,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                ],
                const SizedBox(height: 20),
                SectionLabel(
                  label: AppLocalizations.of(context)!.dhcpLeases,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DhcpLeases(
                          items: serversProvider.dhcp.data!.dhcpStatus.leases,
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DhcpLeases(
                          items: serversProvider.dhcp.data!.dhcpStatus.staticLeases,
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
                const SizedBox(height: 10)
              ],
            );
          } 
          else {
            return Column(
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
            );
          }
          
        case 2:
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