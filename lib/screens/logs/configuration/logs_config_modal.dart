import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/configuration/config_widgets.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class RetentionItem {
  final String label;
  final double value;

  const RetentionItem({
    required this.label,
    required this.value,
  });
}

class LogsConfigModal extends StatelessWidget {
  final void Function(Map<String, dynamic>) onConfirm;
  final void Function() onClear;
  final bool dialog;
  final String serverVersion;

  const LogsConfigModal({
    Key? key,
    required this.onConfirm,
    required this.onClear,
    required this.dialog,
    required this.serverVersion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return LogsConfigModalWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
      context: context,
      onConfirm: onConfirm,
      onClear: onClear,
      dialog: dialog,
      serverVersion: serverVersion,
    );
  }
}

class LogsConfigModalWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final BuildContext context;
  final void Function(Map<String, dynamic>) onConfirm;
  final void Function() onClear;
  final bool dialog;
  final String serverVersion;

  const LogsConfigModalWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.context,
    required this.onConfirm,
    required this.onClear,
    required this.dialog,
    required this.serverVersion
  }) : super(key: key);

  @override
  State<LogsConfigModalWidget> createState() => _LogsConfigModalWidgetState();
}

class _LogsConfigModalWidgetState extends State<LogsConfigModalWidget> {
  bool generalSwitch = false;
  bool anonymizeClientIp = false;
  double? retentionTime;

  List<RetentionItem> retentionItems = [];

  LoadStatus loadStatus = LoadStatus.loading;

  void loadData() async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    final result = serverVersionIsAhead(
      currentVersion: widget.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    ) == true 
      ? await serversProvider.apiClient!.getQueryLogInfo()
      : await serversProvider.apiClient!.getQueryLogInfoLegacy();

    if (mounted) {
      if (result['result'] == 'success') {
        setState(() {
          generalSwitch = result['data']['enabled'];
          anonymizeClientIp = result['data']['anonymize_client_ip'];
          retentionTime = result['data']['interval'] != null 
            ? double.parse(result['data']['interval'].toString()) 
            : null;
          loadStatus = LoadStatus.loaded;
        });
      }
      else {
        setState(() => loadStatus = LoadStatus.error);
      }
    }
  }

  @override
  void initState() {
    retentionItems = serverVersionIsAhead(
      currentVersion: widget.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    ) == true ? [
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.hours6,
        value: 21600000
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.hours24,
        value: 86400000
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days7,
        value: 604800000
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days30,
        value: 2592000000
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days90,
        value: 7776000000
      ),
    ] : [
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.hours6,
        value: 0.25
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.hours24,
        value: 1
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days7,
        value: 7
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days30,
        value: 30
      ),
      RetentionItem(
        label: AppLocalizations.of(widget.context)!.days90,
        value: 90
      ),
    ];

    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Builder(
            builder: (context) {
              switch (loadStatus) {
                case LoadStatus.loading:
                  return const ConfigLogsLoading();

                case LoadStatus.loaded:
                  return LogsConfigOptions(
                    generalSwitch: generalSwitch, 
                    updateGeneralSwitch: (v) => setState(() => generalSwitch = v), 
                    anonymizeClientIp: anonymizeClientIp, 
                    updateAnonymizeClientIp: (v) => setState(() => anonymizeClientIp = v), 
                    retentionItems: retentionItems, 
                    retentionTime: retentionTime, 
                    updateRetentionTime: (v) => setState(() => retentionTime = v), 
                    onClear: () => widget.onClear(), 
                    onConfirm: () => widget.onConfirm({
                      "enabled": generalSwitch,
                      "interval": retentionTime,
                      "anonymize_client_ip": anonymizeClientIp
                    })
                  );

                case LoadStatus.error:
                  return const ConfigLogsError();

                default:
                  return const SizedBox();
              }
            },
          )
        ),
      );
    }
    else {
      return Container(
        height: Platform.isIOS ? 436 : 420,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          ),
          color: Theme.of(context).dialogBackgroundColor
        ),
        child: Builder(
          builder: (context) {
            switch (loadStatus) {
              case LoadStatus.loading:
                return const ConfigLogsLoading();

              case LoadStatus.loaded:
                return LogsConfigOptions(
                  generalSwitch: generalSwitch, 
                  updateGeneralSwitch: (v) => setState(() => generalSwitch = v), 
                  anonymizeClientIp: anonymizeClientIp, 
                  updateAnonymizeClientIp: (v) => setState(() => anonymizeClientIp = v), 
                  retentionItems: retentionItems, 
                  retentionTime: retentionTime, 
                  updateRetentionTime: (v) => setState(() => retentionTime = v), 
                  onClear: () => widget.onClear(), 
                  onConfirm: () => widget.onConfirm({
                    "enabled": generalSwitch,
                    "interval": retentionTime,
                    "anonymize_client_ip": anonymizeClientIp
                  })
                );

              case LoadStatus.error:
                return const ConfigLogsError();

              default:
                return const SizedBox();
            }
          },
        )
      );
    }
  }
}