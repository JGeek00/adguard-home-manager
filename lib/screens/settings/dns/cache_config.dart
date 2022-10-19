import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

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

  @override
  void initState() {
    cacheSizeController.text = widget.serversProvider.dnsInfo.data!.cacheSize.toString();
    overrideMinTtlController.text = widget.serversProvider.dnsInfo.data!.cacheTtlMin.toString();
    overrideMaxTtlController.text = widget.serversProvider.dnsInfo.data!.cacheTtlMax.toString();
    optimisticCache = widget.serversProvider.dnsInfo.data!.cacheOptimistic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget numericField({
      required TextEditingController controller,
      required String label,
      String? helper,
      String? error,
      required void Function(String) onChanged,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.timer_rounded),
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