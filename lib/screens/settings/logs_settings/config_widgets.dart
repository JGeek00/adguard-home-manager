import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';

class LogsConfigOptions extends StatelessWidget {
  final bool generalSwitch;
  final void Function(bool) updateGeneralSwitch;
  final bool anonymizeClientIp;
  final void Function(bool) updateAnonymizeClientIp;
  final List<int> retentionItems; 
  final double? retentionTime;
  final void Function(double?) updateRetentionTime;
  final void Function() onClear;
  final void Function() onConfirm;

  const LogsConfigOptions({
    super.key,
    required this.generalSwitch,
    required this.updateGeneralSwitch,
    required this.anonymizeClientIp,
    required this.updateAnonymizeClientIp,
    required this.retentionItems,
    required this.retentionTime,
    required this.updateRetentionTime,
    required this.onClear,
    required this.onConfirm
  });

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItemTranslation = [
      AppLocalizations.of(context)!.hours6,
      AppLocalizations.of(context)!.hours24,
      AppLocalizations.of(context)!.days7,
      AppLocalizations.of(context)!.days30,
      AppLocalizations.of(context)!.days90,
    ];

    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              onTap: () => updateGeneralSwitch(!generalSwitch),
              borderRadius: BorderRadius.circular(28),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.enableLog,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      value: generalSwitch, 
                      onChanged: updateGeneralSwitch,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomCheckboxListTile(
          value: anonymizeClientIp, 
          onChanged: (_) => updateAnonymizeClientIp(!anonymizeClientIp),
          title: AppLocalizations.of(context)!.anonymizeClientIp,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: DropdownButtonFormField(
            items: retentionItems.asMap().entries.map((item) => DropdownMenuItem(
              value: item.value,
              child: Text(dropdownItemTranslation[item.key]),
            )).toList(),
            value: retentionTime,
            onChanged: (value) => updateRetentionTime(value as double),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                )
              ),
              label: Text(AppLocalizations.of(context)!.retentionTime)
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onClear, 
          icon: const Icon(Icons.delete_rounded),
          label: Text(AppLocalizations.of(context)!.clearLogs),
        )
      ],
    );
  }
}

class ConfigLogsLoading extends StatelessWidget {
  const ConfigLogsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppLocalizations.of(context)!.loadingLogsSettings,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConfigLogsError extends StatelessWidget {
  const ConfigLogsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppLocalizations.of(context)!.logSettingsNotLoaded,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onSurfaceVariant
              ),
            ),
          )
        ],
      ),
    );
  }
}