// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/logs_config_modal.dart';
import 'package:adguard_home_manager/screens/logs/logs_filters_modal.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class LogsListAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final bool showDivider;

  const LogsListAppBar({
    Key? key,
    required this.innerBoxIsScrolled,
    required this.showDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void updateConfig(Map<String, dynamic> data) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = serverVersionIsAhead(
        currentVersion: statusProvider.serverStatus!.serverVersion, 
        referenceVersion: 'v0.107.28',
        referenceVersionBeta: 'v0.108.0-b.33'
      ) == true 
        ? await serversProvider.apiClient!.updateQueryLogParameters(data: data)
        : await serversProvider.apiClient!.updateQueryLogParametersLegacy(data: data);

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigUpdated, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigNotUpdated, 
          color: Colors.red
        );
      }
    }

    void clearQueries() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await serversProvider.apiClient!.clearLogs();

      processModal.close();

      if (result['result'] == 'success') {
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


    void openFilersModal() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => const LogsFiltersModal(
            dialog: true,
          ),
          barrierDismissible: false
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => const LogsFiltersModal(
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true
        );
      }
    }

    final Map<String, String> translatedString = {
      "all": AppLocalizations.of(context)!.all, 
      "filtered": AppLocalizations.of(context)!.filtered, 
      "processed": AppLocalizations.of(context)!.processedRow, 
      "whitelisted": AppLocalizations.of(context)!.processedWhitelistRow, 
      "blocked": AppLocalizations.of(context)!.blocked, 
      "blocked_safebrowsing": AppLocalizations.of(context)!.blockedSafeBrowsingRow, 
      "blocked_parental": AppLocalizations.of(context)!.blockedParentalRow, 
      "safe_search": AppLocalizations.of(context)!.safeSearch, 
    };

    return SliverAppBar.large(
      pinned: true,
      floating: true,
      centerTitle: false,
      forceElevated: innerBoxIsScrolled,
      surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      title: Text(AppLocalizations.of(context)!.logs),
      expandedHeight: logsProvider.appliedFilters.searchText != null || logsProvider.appliedFilters.selectedResultStatus != 'all' || logsProvider.appliedFilters.clients != null
        ? 170 : null,
      actions: [
        if (!(Platform.isAndroid || Platform.isIOS)) IconButton(
          onPressed: () => logsProvider.fetchLogs(inOffset: 0), 
          icon: const Icon(Icons.refresh_rounded),
          tooltip: AppLocalizations.of(context)!.refresh,
        ),
        logsProvider.loadStatus == LoadStatus.loaded
          ? IconButton(
              onPressed: openFilersModal, 
              icon: const Icon(Icons.filter_list_rounded),
              tooltip: AppLocalizations.of(context)!.filters,
            )
          : const SizedBox(),
        if (statusProvider.serverStatus != null) IconButton(
          tooltip: AppLocalizations.of(context)!.settings,
          onPressed: () => {
            if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
              showDialog(
                context: context, 
                builder: (context) => LogsConfigModal(
                  onConfirm: updateConfig,
                  onClear: clearQueries,
                  dialog: true,
                  serverVersion: statusProvider.serverStatus!.serverVersion,
                ),
                barrierDismissible: false
              )
            }
            else {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true, 
                builder: (context) => LogsConfigModal(
                  onConfirm: updateConfig,
                  onClear: clearQueries,
                  dialog: false,
                  serverVersion: statusProvider.serverStatus!.serverVersion,
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true
              )
            }
          }, 
          icon: const Icon(Icons.settings)
        ),
        const SizedBox(width: 5),
      ],
      bottom: logsProvider.appliedFilters.searchText != null || logsProvider.appliedFilters.selectedResultStatus != 'all' || logsProvider.appliedFilters.clients != null
        ? PreferredSize(
            preferredSize: const Size(double.maxFinite, 70),
            child: Container(
              height: 50,
              width: double.maxFinite,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: showDivider == true
                      ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
                      : Colors.transparent,
                  )
                )
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (logsProvider.appliedFilters.searchText != null) ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.search_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            logsProvider.appliedFilters.searchText!,
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                            searchText: null,
                            clients: logsProvider.appliedFilters.clients
                          )
                        );
                        logsProvider.setSearchText(null);
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          searchText: ''
                        );
                      },
                    ),
                  ],
                  if (logsProvider.appliedFilters.selectedResultStatus != 'all') ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.shield_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            translatedString[logsProvider.appliedFilters.selectedResultStatus]!,
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: 'all', 
                            searchText: logsProvider.appliedFilters.searchText,
                            clients: logsProvider.appliedFilters.clients
                          )
                        );
                        logsProvider.setSelectedResultStatus('all');
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          responseStatus: 'all'
                        );
                      },
                    ),
                  ],
                  if (logsProvider.appliedFilters.clients != null) ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.smartphone_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            logsProvider.appliedFilters.clients!.length == 1
                              ? logsProvider.appliedFilters.clients![0]
                              : "${logsProvider.appliedFilters.clients!.length} ${AppLocalizations.of(context)!.clients}",
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                            searchText: logsProvider.appliedFilters.searchText,
                            clients: null
                          )
                        );
                        logsProvider.setSelectedClients(null);
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          responseStatus: logsProvider.appliedFilters.selectedResultStatus
                        );
                      },
                    ),
                  ],
                  const SizedBox(width: 15),
                ],
              ),
            )
          )
      : null,
    );
  }
}