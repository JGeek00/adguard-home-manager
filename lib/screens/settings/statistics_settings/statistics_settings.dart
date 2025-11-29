import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/logs_settings/logs_settings.dart';
import 'package:adguard_home_manager/widgets/load_status_widgets.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/master_switch.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/statistics_config.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class StatisticsSettings extends StatefulWidget {
  const StatisticsSettings({super.key});

  @override
  State<StatisticsSettings> createState() => _StatisticsSettingsState();
}

class _StatisticsSettingsState extends State<StatisticsSettings> {
  final Uuid uuid = const Uuid();
  LoadStatus _loadStatus = LoadStatus.loading;
  bool _generalSwitch = false;
  final List<String> _retentionItems = [
    "custom",
    "86400000",
    "604800000",
    "2592000000",
    "7776000000"
  ];
  final _customTimeController = TextEditingController();
  String? _customTimeError;
  String? _retentionTime;
  List<DomainListItemController> _ignoredDomainsControllers = [];

  void loadData() async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    final result = await serversProvider.apiClient2!.getStatisticsConfig();

    if (!mounted) return;
    if (result.successful == true) {
      final data = result.content as StatisticsConfig;
      setState(() {
        _generalSwitch = data.enabled ?? false;
        if (_retentionItems.contains(data.interval.toString())) {
          _retentionTime = data.interval.toString();
        }
        else if (data.interval != null) {
          _retentionTime = "custom";
          _customTimeController.text = Duration(milliseconds: data.interval!).inHours.toString();
        }
        if (data.ignored != null) {
          _ignoredDomainsControllers = data.ignored!.map((e) => DomainListItemController(
            id: uuid.v4(), 
            controller: TextEditingController(text: e), 
            error: false
          )).toList();
        }
        _loadStatus = LoadStatus.loaded;
      });
    }
    else {
      setState(() => _loadStatus = LoadStatus.error);
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

    final List<String> dropdownItemTranslation = [
      AppLocalizations.of(context)!.custom,
      AppLocalizations.of(context)!.hours24,
      AppLocalizations.of(context)!.days7,
      AppLocalizations.of(context)!.days30,
      AppLocalizations.of(context)!.days90,
    ];
    

    void validateDomain(String value, String id) {
      bool error = false;
      if (Regexps.domain.hasMatch(value)) {
        error = false;
      }
      else {
        error = true;
      }
      setState(() {
        _ignoredDomainsControllers = _ignoredDomainsControllers.map((entry) {
          if (entry.id != id) return entry;
          return DomainListItemController(
            id: id, 
            controller: entry.controller, 
            error: error
          );
        }).toList();
      });
    }

    void validateCustomTime(String v) {
      try {
        final regex = RegExp(r'^\d+$');
        final parsed = int.parse(v);
        if (!regex.hasMatch(v)) {
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

    void updateConfig() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await serversProvider.apiClient2!.updateStatisticsSettings(
        body: {
          "enabled": _generalSwitch,
          "interval": _retentionTime == "custom" 
            ? Duration(hours: int.parse(_customTimeController.text)).inMilliseconds 
            : int.parse(_retentionTime ?? _retentionItems[0]),
          "ignored": _ignoredDomainsControllers.map((e) => e.controller.text).toList()
        }
      );
      
      processModal.close();

      if (!context.mounted) return;

      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.statisticsConfigUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.statisticsConfigNotUpdated, 
          color: Colors.red
        );
      }
    }

    final validValues = _ignoredDomainsControllers.where(
        (d) =>  d.controller.text == "" || d.error == true
      ).isEmpty && 
      (_retentionTime != "custom" ||
      (_retentionTime == "custom" && _customTimeController.text != "" && _customTimeError == null));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.statisticsSettings),
        actions: [
          IconButton(
            onPressed: validValues ? () => updateConfig() : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (_loadStatus) {
            case LoadStatus.loading:
              return LoadingData(text: AppLocalizations.of(context)!.loadingStatisticsSettings);

            case LoadStatus.loaded:
              return ListView(
                children: [
                  const SizedBox(height: 8),
                  MasterSwitch(
                    label: AppLocalizations.of(context)!.enableLog, 
                    value: _generalSwitch, 
                    onChange: (v) => setState(() => _generalSwitch = v)
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField(
                      items: _retentionItems.asMap().entries.map((item) => DropdownMenuItem(
                        value: item.value,
                        child: Text(dropdownItemTranslation[item.key]),
                      )).toList(),
                      initialValue: _retentionTime,
                      onChanged: (value) => setState(() {
                        if (value != null && value != "custom") {
                          _customTimeError = null;
                          _customTimeController.text = "";
                        }
                        _retentionTime = value;
                      }),
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
                  if (_retentionTime == "custom") Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24
                    ),
                    child: TextFormField(
                      controller: _customTimeController,
                      onChanged: validateCustomTime,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.schedule_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        labelText: AppLocalizations.of(context)!.customTimeInHours,
                        errorText: _customTimeError
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionLabel(
                          label: AppLocalizations.of(context)!.ignoredDomains,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: IconButton(
                            onPressed: () => setState(() => _ignoredDomainsControllers = [
                              ..._ignoredDomainsControllers,
                              DomainListItemController(
                                id: uuid.v4(), 
                                controller: TextEditingController(),
                                error: false
                              ),
                            ]),
                            icon: const Icon(Icons.add),
                            tooltip: AppLocalizations.of(context)!.addDomain,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (_ignoredDomainsControllers.isNotEmpty) ..._ignoredDomainsControllers.map((controller) => Padding(
                    padding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 16, right: 6
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.controller,
                            onChanged: (v) => validateDomain(v, controller.id),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.link_rounded),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                                )
                              ),
                              labelText: AppLocalizations.of(context)!.domain,
                              errorText: controller.error 
                                ? AppLocalizations.of(context)!.invalidDomain
                                : null
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Padding(
                          padding: controller.error
                            ? const EdgeInsets.only(bottom: 24)
                            : const EdgeInsets.all(0),
                          child: IconButton(
                            onPressed: () => setState(() => _ignoredDomainsControllers = _ignoredDomainsControllers.where((e) => e.id != controller.id).toList()),
                            icon: const Icon(Icons.remove_circle_outline_outlined),
                            tooltip: AppLocalizations.of(context)!.removeDomain,
                          ),
                        )
                      ],
                    ),
                  )),
                  if (_ignoredDomainsControllers.isEmpty) Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      AppLocalizations.of(context)!.noIgnoredDomainsAdded,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              );

            case LoadStatus.error:
              return ErrorLoadData(text: AppLocalizations.of(context)!.statisticsSettingsLoadError);
              
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}