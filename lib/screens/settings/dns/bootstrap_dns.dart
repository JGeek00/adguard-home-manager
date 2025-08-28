// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class BootstrapDnsScreen extends StatefulWidget {
  const BootstrapDnsScreen({super.key});

  @override
  State<BootstrapDnsScreen> createState() => _BootstrapDnsScreenState();
}

class _BootstrapDnsScreenState extends State<BootstrapDnsScreen> {
  List<Map<String, dynamic>> bootstrapControllers = [];

  bool validValues = false;

  void validateIp(Map<String, dynamic> field, String value) {
    if (Regexps.ipv4Address.hasMatch(value) == true || Regexps.ipv6Address.hasMatch(value) == true) {
      setState(() => field['error'] = null);
    }
    else {
      setState(() => field['error'] = AppLocalizations.of(context)!.invalidIp);
    }
    checkValidValues();
  }

  void checkValidValues() {
    if (
      bootstrapControllers.isNotEmpty &&
      bootstrapControllers.every((element) => element['controller'].text != '') &&
      bootstrapControllers.every((element) => element['error'] == null)
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

    for (var item in dnsProvider.dnsInfo!.bootstrapDns) {
      final controller = TextEditingController();
      controller.text = item;
      bootstrapControllers.add({
        'controller': controller,
        'error': null
      });
    }
    validValues = true;
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

      final result = await dnsProvider.saveBootstrapDnsConfig({
        "bootstrap_dns": bootstrapControllers.map((e) => e['controller'].text).toList(),
      });

      processModal.close();

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
        title: Text(AppLocalizations.of(context)!.bootstrapDns),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            Card(
              margin: const EdgeInsets.only(
                left: 16, right: 16, bottom: 20
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_rounded,
                      color: Theme.of(context).listTileTheme.iconColor,
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.bootstrapDnsServersInfo,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      )
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
            ...bootstrapControllers.map((c) => Padding(
              padding: const EdgeInsets.only(
                left: 16, right: 6, bottom: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: c['controller'],
                      onChanged: (value) => validateIp(c, value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.dns_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: c['error'],
                        labelText: AppLocalizations.of(context)!.dnsServer,
                      )
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() => bootstrapControllers = bootstrapControllers.where((con) => con != c).toList());
                      checkValidValues();
                    }, 
                    icon: const Icon(Icons.remove_circle_outline)
                  )
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => bootstrapControllers.add({
                      'controller': TextEditingController(),
                      'error': null
                    }));
                    checkValidValues();
                  }, 
                  icon: const Icon(Icons.add), 
                  label: Text(AppLocalizations.of(context)!.addItem)
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}