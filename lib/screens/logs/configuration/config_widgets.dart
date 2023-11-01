import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/configuration/logs_config_modal.dart';

class LogsConfigOptions extends StatelessWidget {
  final bool generalSwitch;
  final void Function(bool) updateGeneralSwitch;
  final bool anonymizeClientIp;
  final void Function(bool) updateAnonymizeClientIp;
  final List<RetentionItem> retentionItems; 
  final String? retentionTime;
  final void Function(String?) updateRetentionTime;
  final void Function() onClear;
  final void Function() onConfirm;

  const LogsConfigOptions({
    Key? key,
    required this.generalSwitch,
    required this.updateGeneralSwitch,
    required this.anonymizeClientIp,
    required this.updateAnonymizeClientIp,
    required this.retentionItems,
    required this.retentionTime,
    required this.updateRetentionTime,
    required this.onClear,
    required this.onConfirm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Icon(
                            Icons.settings,
                            size: 24,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.logsSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface
                          ), 
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
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
                Container(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => updateAnonymizeClientIp(!anonymizeClientIp),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.anonymizeClientIp,
                                  style: const TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                                Switch(
                                  value: anonymizeClientIp, 
                                  onChanged: updateAnonymizeClientIp,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: DropdownButtonFormField(
                          items: retentionItems.map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item.value.toString(),
                              child: Text(item.label),
                            );
                          }).toList(),
                          value: retentionTime,
                          onChanged: (value) => updateRetentionTime(value),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onClear();
                }, 
                child: Text(AppLocalizations.of(context)!.clearLogs)
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text(AppLocalizations.of(context)!.cancel)
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: retentionTime != ''
                      ? () {
                        Navigator.pop(context);
                        onConfirm();
                      }
                      : null, 
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(
                        color: retentionTime != ''
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
        ),
        if (Platform.isIOS) const SizedBox(height: 16)
      ],
    );
  }
}

class ConfigLogsLoading extends StatelessWidget {
  const ConfigLogsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class ConfigLogsError extends StatelessWidget {
  const ConfigLogsError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}