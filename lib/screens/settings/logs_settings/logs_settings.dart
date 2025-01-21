import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/logs_settings/config_widgets.dart';
import 'package:adguard_home_manager/widgets/load_status_widgets.dart';

import 'package:adguard_home_manager/models/querylog_config.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class DomainListItemController {
  final String id;
  final TextEditingController controller;
  bool error;

  DomainListItemController({
    required this.id,
    required this.controller,
    required this.error
  });
}

class LogsSettings extends StatefulWidget {
  const LogsSettings({super.key});

  @override
  State<LogsSettings> createState() => _LogsSettingsState();
}

class _LogsSettingsState extends State<LogsSettings> {
  final Uuid uuid = const Uuid();

  bool generalSwitch = false;
  bool anonymizeClientIp = false;
  String? retentionTime;
  List<DomainListItemController> _ignoredDomainsControllers = [];
  final _customTimeController = TextEditingController();
  String? _customTimeError = null;

  List<String> retentionItems = [
    "custom",
    "21600000",
    "86400000",
    "604800000",
    "2592000000",
    "7776000000"
  ];

  LoadStatus loadStatus = LoadStatus.loading;

  void loadData() async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    final result = await serversProvider.apiClient2!.getQueryLogInfo();

    if (!mounted) return;
    if (result.successful == true) {
      final data = result.content as QueryLogConfig;
      setState(() {
        generalSwitch = data.enabled ?? false;
        anonymizeClientIp = data.anonymizeClientIp ?? false;
        retentionTime = retentionItems.contains(data.interval.toString()) ? data.interval.toString() : "custom";
        if (data.interval != null && !retentionItems.contains(data.interval.toString())) {
          _customTimeController.text = (data.interval!/3.6e+6).toInt().toString();
        }
        if (data.ignored != null) {
          _ignoredDomainsControllers = data.ignored!.map((e) => DomainListItemController(
            id: uuid.v4(), 
            controller: TextEditingController(text: e), 
            error: false
          )).toList();
        }
        loadStatus = LoadStatus.loaded;
      });
    }
    else {
      setState(() => loadStatus = LoadStatus.error);
    }
  }

  void validateCustomTime(String value) {
    try {
      final regex = RegExp(r'^\d+$');
      final parsed = int.parse(value);
      if (!regex.hasMatch(value)) {
        setState(() => _customTimeError = AppLocalizations.of(context)!.invalidTime);
      }
      else if (parsed < 1) {
        setState(() => _customTimeError = AppLocalizations.of(context)!.notLess1Hour);
      }
      else {
        setState(() => _customTimeError = null);
      }
    } catch (_) {
      setState(() => _customTimeError = AppLocalizations.of(context)!.invalidTime);
    }
  }

  bool checkValidValues() {
    if (_ignoredDomainsControllers.where((d) =>  d.controller.text == "" || d.error == true).isNotEmpty) {
      return false;
    }
    if (retentionTime == "custom" && (_customTimeError != null || _customTimeController.text == "")) {
      return false;
    }
    return true;
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

    final validValues = checkValidValues();

    void clearQueries() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await serversProvider.apiClient2!.clearLogs();

      processModal.close();

      if (!context.mounted) return;

      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsCleared, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
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
          "interval": retentionTime == "custom" ? int.parse(_customTimeController.text)*3.6e+6 : int.parse(retentionTime!) ,
          "anonymize_client_ip": anonymizeClientIp,
          "ignored": _ignoredDomainsControllers.map((e) => e.controller.text).toList()
        }
      );
      
      processModal.close();

      if (!context.mounted) return;

      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
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
            onPressed: validValues ? () => updateConfig() : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          if (loadStatus == LoadStatus.loaded) PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: clearQueries,
                child: Row(
                  children: [
                    const Icon(Icons.delete_rounded),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.clearLogs),
                  ],
                )
              )
            ],
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (loadStatus) {
            case LoadStatus.loading:
              return LoadingData(text: AppLocalizations.of(context)!.loadingLogsSettings);
      
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
                onConfirm: updateConfig,
                ignoredDomainsControllers: _ignoredDomainsControllers,
                updateIgnoredDomainsControllers: (v) => setState(() => _ignoredDomainsControllers = v),
                customTimeController: _customTimeController,
                customTimeError: _customTimeError,
                validateCustomTime: validateCustomTime,
              );
      
            case LoadStatus.error:
              return ErrorLoadData(text: AppLocalizations.of(context)!.logSettingsNotLoaded,);
      
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}