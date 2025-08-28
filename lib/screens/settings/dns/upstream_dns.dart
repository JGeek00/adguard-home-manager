import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/screens/settings/dns/comment_modal.dart';
import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class UpstreamDnsScreen extends StatefulWidget {
  const UpstreamDnsScreen({super.key});

  @override
  State<UpstreamDnsScreen> createState() => _UpstreamDnsScreenState();
}

class _UpstreamDnsScreenState extends State<UpstreamDnsScreen> {
  List<Map<String, dynamic>> dnsServers = [];

  String upstreamMode = "";

  bool validValues = false;

  final upstreamTimeoutController = TextEditingController();
  String? upstreamTimeoutError = null;

  checkValidValues() {
    if (
      dnsServers.isNotEmpty &&
      dnsServers.every((element) => element['controller'] != null ? element['controller.text'] != '' : true)
    ) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  @override
  void initState() {
    final dnsProvider = Provider.of<DnsProvider>(context, listen: false);

    for (var item in dnsProvider.dnsInfo!.upstreamDns) {
      if (item.contains("#")) {
        dnsServers.add({
          'comment': item
        });
      }
      else {
        final controller = TextEditingController();
        controller.text = item;
        dnsServers.add({
          'controller': controller
        });
      }
    }
    upstreamMode = dnsProvider.dnsInfo!.upstreamMode ?? "";
    upstreamTimeoutController.text = dnsProvider.dnsInfo!.upstreamTimeout != null ? dnsProvider.dnsInfo!.upstreamTimeout.toString() : "";
    validValues = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dnsProvider = Provider.of<DnsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    
    final width = MediaQuery.of(context).size.width;

    void validateTimeout(String value) {
      if (value != '' && int.tryParse(value) != null && int.parse(value) > 0) {
        setState(() {
          upstreamTimeoutError = null;
          validValues = true;
        });
      }
      else {
        setState(() {
          upstreamTimeoutError = value == ''
            ? AppLocalizations.of(context)!.fieldCannotBeEmpty
            : AppLocalizations.of(context)!.invalidValue;
          validValues = false;
        });
      }
    }

    void openAddCommentModal() {
      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => CommentModal(
            onConfirm: (value) {
              setState(() {
                dnsServers.add({
                  'comment': value
                });
              });
            },
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => CommentModal(
            onConfirm: (value) {
              setState(() {
                dnsServers.add({
                  'comment': value
                });
              });
            },
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          isDismissible: true
        );
      }
    }

    void openEditCommentModal(Map<String, dynamic> item, int position) {
      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => CommentModal(
            comment: item['comment'],
            onConfirm: (value) {
              setState(() => dnsServers[position] = { 'comment': value });
            },
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => CommentModal(
            comment: item['comment'],
            onConfirm: (value) {
              setState(() => dnsServers[position] = { 'comment': value });
            },
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          isDismissible: true
        );
      }
    }

    void saveData() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await dnsProvider.saveUpstreamDnsConfig({
        "upstream_dns": dnsServers.map((e) => e['controller'] != null ? e['controller'].text : e['comment']).toList(),
        "upstream_mode": upstreamMode,
        "upstream_timeout": int.tryParse(upstreamTimeoutController.text)
      });

      processModal.close();

      if (!context.mounted) return;
      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigSaved, 
          color: Colors.green
        );
      }
      else if (result.successful == false && result.statusCode == 400) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.someValueNotValid, 
          color: Colors.red
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigNotSaved, 
          color: Colors.red
        );
      } 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.upstreamDns),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        actions: [
          IconButton(
            onPressed: validValues == true
              ? () => saveData()
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            if (dnsServers.isEmpty) Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noUpstreamDns,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            ...dnsServers.map((item) => Padding(
              padding: const EdgeInsets.only(
                left: 16, right: 6, bottom: 24
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (item['controller'] != null) Expanded(
                    child: TextFormField(
                      controller: item['controller'],
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
                  const SizedBox(width: 8),
                  if (item['comment'] != null) Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['comment'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        IconButton(
                          onPressed: () => openEditCommentModal(item, dnsServers.indexOf(item)), 
                          icon: const Icon(Icons.edit),
                          tooltip:  AppLocalizations.of(context)!.edit,
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => dnsServers = dnsServers.where((i) => i != item).toList());
                      checkValidValues();
                    }, 
                    icon: const Icon(Icons.remove_circle_outline),
                    tooltip:  AppLocalizations.of(context)!.remove,
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: openAddCommentModal, 
                  icon: const Icon(Icons.add), 
                  label: Text(AppLocalizations.of(context)!.comment)
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => dnsServers.add({
                      'controller': TextEditingController()
                    }));
                    checkValidValues();
                  }, 
                  icon: const Icon(Icons.add), 
                  label: Text(AppLocalizations.of(context)!.address)
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            SectionLabel(label: AppLocalizations.of(context)!.others),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: upstreamTimeoutController,
                onChanged: validateTimeout,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.timer_rounded),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  labelText: AppLocalizations.of(context)!.upstreamTimeout,
                  helperText: AppLocalizations.of(context)!.upstreamTimeoutHelper,
                  helperMaxLines: 2,
                  errorText: upstreamTimeoutError
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}