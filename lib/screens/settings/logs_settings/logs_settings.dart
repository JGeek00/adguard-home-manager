import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/logs_settings/config_widgets.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class LogsSettings extends StatefulWidget {
  const LogsSettings({super.key});

  @override
  State<LogsSettings> createState() => _LogsSettingsState();
}

class _LogsSettingsState extends State<LogsSettings> {
  bool generalSwitch = false;
  bool anonymizeClientIp = false;
  double? retentionTime;

  List<int> retentionItems = [
    21600000,
    86400000,
    604800000,
    2592000000,
    7776000000
  ];

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
    loadData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void clearQueries() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await serversProvider.apiClient2!.clearLogs();

      processModal.close();

      if (!mounted) return;

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsCleared, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsNotCleared, 
          color: Colors.red
        );
      }
    }

    void updateConfig() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await serversProvider.apiClient2!.updateQueryLogParameters(
        data: {
          "enabled": generalSwitch,
          "interval": retentionTime,
          "anonymize_client_ip": anonymizeClientIp
        }
      );
      
      processModal.close();

      if (!mounted) return;

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigNotUpdated, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.logsSettings),
        actions: [
          if (loadStatus == LoadStatus.loaded) IconButton(
            onPressed: updateConfig, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Builder(
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
                onClear: clearQueries, 
                onConfirm: updateConfig
              );
      
            case LoadStatus.error:
              return const ConfigLogsError();
      
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}