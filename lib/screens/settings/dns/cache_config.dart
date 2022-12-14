// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class CacheConfigDnsScreen extends StatefulWidget {
  final ServersProvider serversProvider;

  const CacheConfigDnsScreen({
    Key? key,
    required this.serversProvider
  }) : super(key: key);

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
    cacheSizeController.text = widget.serversProvider.dnsInfo.data!.cacheSize.toString();
    overrideMinTtlController.text = widget.serversProvider.dnsInfo.data!.cacheTtlMin.toString();
    overrideMaxTtlController.text = widget.serversProvider.dnsInfo.data!.cacheTtlMax.toString();
    optimisticCache = widget.serversProvider.dnsInfo.data!.cacheOptimistic;
    validData = true;
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
        "cache_size": int.parse(cacheSizeController.text),
        "cache_ttl_min": int.parse(overrideMinTtlController.text),
        "cache_ttl_max": int.parse(overrideMaxTtlController.text),
        "cache_optimistic": optimisticCache
      });

      processModal.close();

      if (result['result'] == 'success') {
        DnsInfoData data = serversProvider.dnsInfo.data!;
        data.cacheSize = int.parse(cacheSizeController.text);
        data.cacheTtlMin = int.parse(overrideMinTtlController.text);
        data.cacheTtlMax = int.parse(overrideMaxTtlController.text);
        data.cacheOptimistic = optimisticCache;
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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsCacheConfig),
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
      body: ListView(
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
          )
        ],
      ),
    );
  }
}