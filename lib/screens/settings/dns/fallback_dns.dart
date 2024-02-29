import 'dart:io';

import 'package:adguard_home_manager/screens/settings/dns/comment_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class FallbackDnsScreen extends StatefulWidget {
  const FallbackDnsScreen({super.key});

  @override
  State<FallbackDnsScreen> createState() => _FallbackDnsScreenState();
}

class _FallbackDnsScreenState extends State<FallbackDnsScreen> {
  List<Map<String, dynamic>> fallbackControllers = [];

  bool validValues = false;

  void validateIp(Map<String, dynamic> field, String value) {
    RegExp ipAddress = RegExp(r'(?:^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}$)|(?:^(?:(?:[a-fA-F\d]{1,4}:){7}(?:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){6}(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){5}(?::(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,2}|:)|(?:[a-fA-F\d]{1,4}:){4}(?:(?::[a-fA-F\d]{1,4}){0,1}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,3}|:)|(?:[a-fA-F\d]{1,4}:){3}(?:(?::[a-fA-F\d]{1,4}){0,2}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,4}|:)|(?:[a-fA-F\d]{1,4}:){2}(?:(?::[a-fA-F\d]{1,4}){0,3}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,5}|:)|(?:[a-fA-F\d]{1,4}:){1}(?:(?::[a-fA-F\d]{1,4}){0,4}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,6}|:)|(?::(?:(?::[a-fA-F\d]{1,4}){0,5}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,7}|:)))(?:%[0-9a-zA-Z]{1,})?$)');
    RegExp url = RegExp(r'(https?|tls):\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
    if (ipAddress.hasMatch(value) == true || url.hasMatch(value) == true) {
      setState(() => field['error'] = null);
    }
    else {
      setState(() => field['error'] = AppLocalizations.of(context)!.invalidIpOrUrl);
    }
    checkValidValues();
  }

  void checkValidValues() {
    if (fallbackControllers.every((element) => element['error'] == null)) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  @override
  void initState() {
    final dnsProvider = Provider.of<DnsProvider>(context, listen: false);

    for (var item in dnsProvider.dnsInfo!.fallbackDns!) {
      if (item.contains("#")) {
        fallbackControllers.add({
          'comment': item
        });
      }
      else {
        final controller = TextEditingController();
        controller.text = item;
        fallbackControllers.add({
          'controller': controller,
          'error': null,
          'isComment': item.contains("#")
        });
      }
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

      final result = await dnsProvider.saveFallbackDnsConfig({
        "fallback_dns": fallbackControllers.map(
          (e) => e['controller'] != null 
            ? e['controller'].text
            : e['comment']
        ).toList(),
      });

      processModal.close();

      if (!context.mounted) return;
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

    void openAddCommentModal() {
      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => CommentModal(
            onConfirm: (value) {
              setState(() {
                fallbackControllers.add({
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
                fallbackControllers.add({
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
              setState(() => fallbackControllers[position] = { 'comment': value });
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
              setState(() => fallbackControllers[position] = { 'comment': value });
            },
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          isDismissible: true
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.fallbackDnsServers),
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
                        AppLocalizations.of(context)!.fallbackDnsServersInfo,
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
            if (fallbackControllers.isEmpty) Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noFallbackDnsAdded,
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
            ...fallbackControllers.map((c) => Padding(
              padding: const EdgeInsets.only(
                left: 16, right: 6, bottom: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (c['controller'] != null) Expanded(
                    child: TextFormField(
                      controller: c['controller'],
                      onChanged: (value) => validateIp(c, value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          c['isComment'] == true 
                            ? Icons.comment_rounded 
                            : Icons.dns_rounded
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: c['error'],
                        labelText: c['isComment'] == true 
                          ? AppLocalizations.of(context)!.comment
                          : AppLocalizations.of(context)!.dnsServer,
                      )
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (c['comment'] != null) Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          c['comment'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        IconButton(
                          onPressed: () => openEditCommentModal(c, fallbackControllers.indexOf(c)), 
                          icon: const Icon(Icons.edit),
                          tooltip:  AppLocalizations.of(context)!.edit,
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => fallbackControllers = fallbackControllers.where((con) => con != c).toList());
                      checkValidValues();
                    }, 
                    icon: const Icon(Icons.remove_circle_outline),
                    tooltip:  AppLocalizations.of(context)!.remove,
                  )
                ],
              ),
            )),
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
                    setState(() => fallbackControllers.add({
                      'controller': TextEditingController(),
                      'error': null
                    }));
                    checkValidValues();
                  }, 
                  icon: const Icon(Icons.add), 
                  label: Text(AppLocalizations.of(context)!.address)
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