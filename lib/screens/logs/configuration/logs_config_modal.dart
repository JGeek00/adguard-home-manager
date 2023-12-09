import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/configuration/config_widgets.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class RetentionItem {
  final String label;
  final double value;

  const RetentionItem({
    required this.label,
    required this.value,
  });
}

class LogsConfigModal extends StatefulWidget {
  final BuildContext context;
  final void Function(Map<String, dynamic>) onConfirm;
  final void Function() onClear;
  final bool dialog;
  final String serverVersion;

  const LogsConfigModal({
    super.key,
    required this.context,
    required this.onConfirm,
    required this.onClear,
    required this.dialog,
    required this.serverVersion
  });

  @override
  State<LogsConfigModal> createState() => _LogsConfigModalState();
}

class _LogsConfigModalState extends State<LogsConfigModal> {
  bool generalSwitch = false;
  bool anonymizeClientIp = false;
  double? retentionTime;

  List<RetentionItem> retentionItems = [];

  LoadStatus loadStatus = LoadStatus.loading;

  void loadData() async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    final result = await serversProvider.apiClient2!.getQueryLogInfo();

    if (mounted) {
      if (result.successful == true) {
        setState(() {
          generalSwitch = result.content['enabled'];
          anonymizeClientIp = result.content['anonymize_client_ip'];
          retentionTime = result.content['interval'] != null 
            ? double.parse(result.content['interval'].toString()) 
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
    retentionItems = [
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          ),
          color: Theme.of(context).dialogBackgroundColor
        ),
        child: SafeArea(
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
          ),
        )
      );
    }
  }
}