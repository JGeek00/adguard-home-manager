// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/dns/clear_dns_cache_dialog.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/dns_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/clear_dns_cache.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class CacheConfigDnsScreen extends StatefulWidget {
  const CacheConfigDnsScreen({super.key});

  @override
  State<CacheConfigDnsScreen> createState() => _CacheConfigDnsScreenState();
}

class _CacheConfigDnsScreenState extends State<CacheConfigDnsScreen> {
  final TextEditingController cacheSizeController = TextEditingController();
  String? cacheSizeError;

  final TextEditingController overrideMinTtlController = TextEditingController();
  String? overrideMinTtlError;

  final TextEditingController overrideMaxTtlController = TextEditingController();
  String? overrideMaxTtlError;

  bool optimisticCache = false;

  bool validData = false;

  void checkValidData() {
    if (
      cacheSizeController.text != '' &&
      cacheSizeError == null &&
      overrideMinTtlController.text != '' && 
      overrideMinTtlError == null && 
      overrideMaxTtlController.text != '' && 
      overrideMaxTtlError == null
    ) {
      setState(() => validData = true);
    }
    else {
      setState(() => validData = false);
    }
  }

  @override
  void initState() {
    final dnsProvider = Provider.of<DnsProvider>(context, listen: false);

    cacheSizeController.text = dnsProvider.dnsInfo!.cacheSize.toString();
    overrideMinTtlController.text = dnsProvider.dnsInfo!.cacheTtlMin.toString();
    overrideMaxTtlController.text = dnsProvider.dnsInfo!.cacheTtlMax.toString();
    optimisticCache = dnsProvider.dnsInfo!.cacheOptimistic ?? false;
    validData = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final dnsProvider = Provider.of<DnsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void saveData() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await dnsProvider.saveCacheCacheConfig({
        "cache_size": int.parse(cacheSizeController.text),
        "cache_ttl_min": int.parse(overrideMinTtlController.text),
        "cache_ttl_max": int.parse(overrideMaxTtlController.text),
        "cache_optimistic": optimisticCache
      });

      processModal.close();

      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigSaved, 
          color: Colors.green
        );
      }
      else if (result.successful== false && result.statusCode == 400) {
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
    Widget numericField({
      required TextEditingController controller,
      required String label,
      String? helper,
      String? error,
      required void Function(String) onChanged,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.storage_rounded),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            errorText: error,
            helperText: helper,
            helperMaxLines: 10,
            labelText: label,
          ),
          keyboardType: TextInputType.number,
        ),
      );
    }

    void clearCache() async {
      final result = await clearDnsCache(context, serversProvider.selectedServer!);
      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.dnsCacheCleared, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.dnsCacheNotCleared, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsCacheConfig),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        actions: [
          IconButton(
            onPressed: validData == true
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
            numericField(
              controller: cacheSizeController, 
              label: AppLocalizations.of(context)!.cacheSize, 
              helper: AppLocalizations.of(context)!.inBytes, 
              error: cacheSizeError, 
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() => cacheSizeError = null);
                }
                else {
                  setState(() => cacheSizeError = AppLocalizations.of(context)!.valueNotNumber);
                }
                checkValidData();
              }
            ),
            const SizedBox(height: 30),
            numericField(
              controller: overrideMinTtlController, 
              label: AppLocalizations.of(context)!.overrideMinimumTtl, 
              helper: AppLocalizations.of(context)!.overrideMinimumTtlDescription, 
              error: overrideMinTtlError, 
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() => overrideMinTtlError = null);
                }
                else {
                  setState(() => overrideMinTtlError = AppLocalizations.of(context)!.valueNotNumber);
                }
                checkValidData();
              }
            ),
            const SizedBox(height: 30),
            numericField(
              controller: overrideMaxTtlController, 
              label: AppLocalizations.of(context)!.overrideMaximumTtl, 
              helper: AppLocalizations.of(context)!.overrideMaximumTtlDescription, 
              error: overrideMaxTtlError, 
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() => overrideMaxTtlError = null);
                }
                else {
                  setState(() => overrideMaxTtlError = AppLocalizations.of(context)!.valueNotNumber);
                }
                checkValidData();
              }
            ),
            const SizedBox(height: 10),
            CustomSwitchListTile(
              value: optimisticCache, 
              onChanged: (value) => setState(() => optimisticCache = value), 
              title: AppLocalizations.of(context)!.optimisticCaching,
              subtitle: AppLocalizations.of(context)!.optimisticCachingDescription,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (context) => ClearDnsCacheDialog(
                      onConfirm: clearCache
                    )
                  ), 
                  icon: const Icon(Icons.delete_rounded),
                  label: Text(AppLocalizations.of(context)!.clearDnsCache),
                ),
              ],
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}