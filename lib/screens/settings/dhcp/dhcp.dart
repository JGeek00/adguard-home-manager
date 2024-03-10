// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/settings.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_not_available.dart';
import 'package:adguard_home_manager/widgets/confirm_action_modal.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_main_button.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_leases.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/select_interface_modal.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/dhcp_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class DhcpScreen extends StatefulWidget {
  const DhcpScreen({super.key});

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
    if (!mounted || result == false) return;

    final dhcpProvider = Provider.of<DhcpProvider>(context, listen: false);
    if (dhcpProvider.dhcp == null) return;
  
    setState(() {
      if (dhcpProvider.dhcp!.dhcpStatus!.interfaceName != null && dhcpProvider.dhcp!.dhcpStatus!.interfaceName != '') {
        try {selectedInterface = dhcpProvider.dhcp!.networkInterfaces.firstWhere((iface) => iface.name == dhcpProvider.dhcp!.dhcpStatus!.interfaceName);} catch (_) {}
        enabled = dhcpProvider.dhcp!.dhcpStatus!.enabled;
        if (dhcpProvider.dhcp!.dhcpStatus!.v4 != null) {
          ipv4StartRangeController.text = dhcpProvider.dhcp!.dhcpStatus!.v4!.rangeStart;
          ipv4EndRangeController.text = dhcpProvider.dhcp!.dhcpStatus!.v4!.rangeEnd ?? '';
          ipv4SubnetMaskController.text = dhcpProvider.dhcp!.dhcpStatus!.v4!.subnetMask ?? '';
          ipv4GatewayController.text = dhcpProvider.dhcp!.dhcpStatus!.v4!.gatewayIp ?? '';
          ipv4LeaseTimeController.text = dhcpProvider.dhcp!.dhcpStatus!.v4!.leaseDuration.toString();
        }
      }
    });

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
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);
    if (mounted && statusProvider.serverStatus?.dhcpAvailable == true) loadDhcpStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final dhcpProvider = Provider.of<DhcpProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void saveSettings() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingSettings);
      final result = await serversProvider.apiClient2!.saveDhcpConfig(
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
      if (!mounted) return;
      processModal.close();
      if (result.successful == true) {
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
        ProcessModal processModal = ProcessModal();
        processModal.open(AppLocalizations.of(context)!.restoringConfig);
        final result = await serversProvider.apiClient2!.resetDhcpConfig();
        if (!mounted) return;
        processModal.close();
        if (result.successful == true) {
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
        ProcessModal processModal = ProcessModal();
        processModal.open(AppLocalizations.of(context)!.restoringLeases);

        final result = await serversProvider.apiClient2!.restoreAllLeases();

        processModal.close();

        if (result.successful == true) {
          DhcpModel data = dhcpProvider.dhcp!;
          data.dhcpStatus!.staticLeases = [];
          data.dhcpStatus!.leases = [];
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
            useRootNavigator: true,
            builder: (context) => SelectInterfaceModal(
              interfaces: dhcpProvider.dhcp!.networkInterfaces, 
              onSelect: (i) => setState(() {
                clearAll();
                selectedInterface = i;
              }),
              dialog: false,
            ),
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent
          );
        }
      });
    }

    if (statusProvider.serverStatus?.dhcpAvailable != true) {
      return const DhcpNotAvailable();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dhcpSettings),
        centerTitle: false,
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
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
      body: SafeArea(
        child: Builder(
          builder: (context) {
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
                        textAlign: TextAlign.center,
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
                        DhcpMainButton(
                          selectedInterface: selectedInterface, 
                          enabled: enabled, 
                          setEnabled: (v) => setState(() => enabled = v)
                        ),
                        if (selectedInterface!.ipv4Addresses.isNotEmpty) ...[
                          SectionLabel(
                            label: AppLocalizations.of(context)!.ipv4settings,
                            padding: const EdgeInsets.only(
                              top: 24, left: 16, right: 16, bottom: 8
                            )
                          ),
                          _DhcpField(
                            icon: Icons.skip_previous_rounded,
                            label: AppLocalizations.of(context)!.startOfRange,
                            controller: ipv4StartRangeController, 
                            onChanged: (value) => validateIpV4(value, 'ipv4StartRangeError', AppLocalizations.of(context)!.ipNotValid),
                            error: ipv4StartRangeError
                          ),
                          _DhcpField(
                            icon: Icons.skip_next_rounded,
                            label: AppLocalizations.of(context)!.endOfRange,
                            controller: ipv4EndRangeController, 
                            onChanged: (value) => validateIpV4(value, 'ipv4EndRangeError', AppLocalizations.of(context)!.ipNotValid),
                            error: ipv4EndRangeError
                          ),
                          _DhcpField(
                            icon: Icons.hub_rounded,
                            label: AppLocalizations.of(context)!.subnetMask,
                            controller: ipv4SubnetMaskController, 
                            onChanged: (value) => validateIpV4(value, 'ipv4SubnetMaskError', AppLocalizations.of(context)!.subnetMaskNotValid),
                            error: ipv4SubnetMaskError
                          ),
                          _DhcpField(
                            icon: Icons.router_rounded,
                            label: AppLocalizations.of(context)!.gateway,
                            controller: ipv4GatewayController, 
                            onChanged: (value) => validateIpV4(value, 'ipv4GatewayError', AppLocalizations.of(context)!.gatewayNotValid),
                            error: ipv4GatewayError
                          ),
                          _DhcpField(
                            icon: Icons.timer,
                            label: AppLocalizations.of(context)!.leaseTime,
                            controller: ipv4LeaseTimeController, 
                            onChanged: (value) {
                              if (int.tryParse(value).runtimeType == int) {
                                setState(() => ipv4LeaseTimeError = null);
                              }
                              else {
                                setState(() => ipv4LeaseTimeError = AppLocalizations.of(context)!.leaseTimeNotValid);
                              }
                            },
                            error: ipv4LeaseTimeError
                          ),
                        ],
                        if (selectedInterface!.ipv6Addresses.isNotEmpty) ...[
                          SectionLabel(
                            label: AppLocalizations.of(context)!.ipv6settings,
                            padding: const EdgeInsets.all(16)
                          ),
                          _DhcpField(
                            icon: Icons.skip_next_rounded,
                            label: AppLocalizations.of(context)!.startOfRange,
                            controller: ipv6StartRangeController, 
                            onChanged: (value) => validateIpV6(value, 'ipv6StartRangeError', AppLocalizations.of(context)!.ipNotValid),
                            error: ipv6StartRangeError
                          ),
                          _DhcpField(
                            icon: Icons.skip_previous_rounded,
                            label: AppLocalizations.of(context)!.endOfRange,
                            controller: ipv6EndRangeController, 
                            onChanged: (value) => validateIpV6(value, 'ipv6EndRangeError', AppLocalizations.of(context)!.ipNotValid),
                            error: ipv6EndRangeError
                          ),
                          _DhcpField(
                            icon: Icons.timer,
                            label: AppLocalizations.of(context)!.leaseTime,
                            controller: ipv6LeaseTimeController, 
                            onChanged: (value) {
                              if (int.tryParse(value).runtimeType == int) {
                                setState(() => ipv6LeaseTimeError = null);
                              }
                              else {
                                setState(() => ipv6LeaseTimeError = AppLocalizations.of(context)!.leaseTimeNotValid);
                              }
                            },
                            error: ipv6LeaseTimeError
                          )
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DhcpLeases(
                                    items: dhcpProvider.dhcp!.dhcpStatus!.leases,
                                    staticLeases: false,
                                  )
                                )
                              );
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DhcpLeases(
                                    items: dhcpProvider.dhcp!.dhcpStatus!.staticLeases,
                                    staticLeases: true,
                                  )
                                )
                              );
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
                                  Navigator.of(settingsNavigatorKey.currentContext!).push(
                                    MaterialPageRoute(builder: (ctx) => DhcpLeases(
                                      items: dhcpProvider.dhcp!.dhcpStatus!.leases,
                                      staticLeases: false,
                                    ))
                                  );
                                }
                                else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DhcpLeases(
                                        items: dhcpProvider.dhcp!.dhcpStatus!.leases,
                                        staticLeases: false,
                                      )
                                    )
                                  );
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
                                  Navigator.of(settingsNavigatorKey.currentContext!).push(
                                    MaterialPageRoute(builder: (ctx) => DhcpLeases(
                                      items: dhcpProvider.dhcp!.dhcpStatus!.staticLeases,
                                      staticLeases: true,
                                    ))
                                  );
                                }
                                else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DhcpLeases(
                                        items: dhcpProvider.dhcp!.dhcpStatus!.staticLeases,
                                        staticLeases: true,
                                      )
                                    )
                                  );
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
          },
        ),
      )
    );
  }
}

class _DhcpField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? error;

  const _DhcpField({
    required this.icon,
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FractionallySizedBox(
      widthFactor: width > 900 ? 0.5 : 1,
      child: Padding(
        padding: width > 900
          ? const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 8)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            errorText: error,
            labelText: label,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}