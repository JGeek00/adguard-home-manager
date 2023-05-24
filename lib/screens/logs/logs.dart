// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/logs_filters_modal.dart';
import 'package:adguard_home_manager/screens/logs/logs_config_modal.dart';
import 'package:adguard_home_manager/screens/logs/log_tile.dart';
import 'package:adguard_home_manager/screens/logs/log_details_screen.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  late ScrollController scrollController;
  
  bool isLoadingMore = false;

  bool showDivider = true;

  Log? selectedLog;

  Future fetchLogs({
    int? inOffset,
    bool? loadingMore,
    String? responseStatus,
    String? searchText,
  }) async {
    final logsProvider = Provider.of<LogsProvider>(context, listen: false);
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    int offst = inOffset ?? logsProvider.offset;

    String resStatus = responseStatus ?? logsProvider.selectedResultStatus;
    String? search = searchText ?? logsProvider.searchText;

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = true);
    }

    final result = await getLogs(
      server: serversProvider.selectedServer!, 
      count: logsProvider.logsQuantity, 
      offset: offst,
      olderThan: logsProvider.logsOlderThan,
      responseStatus: resStatus,
      search: search
    );

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = false);
    }

    if (mounted) {
      if (result['result'] == 'success') {
        logsProvider.setOffset(inOffset != null ? inOffset+logsProvider.logsQuantity : logsProvider.offset+logsProvider.logsQuantity);
        if (loadingMore != null && loadingMore == true && logsProvider.logsData != null) {
          LogsData newLogsData = result['data'];
          newLogsData.data = [...logsProvider.logsData!.data, ...result['data'].data];
          if (logsProvider.appliedFilters.clients != null) {
            newLogsData.data = newLogsData.data.where(
              (item) => logsProvider.appliedFilters.clients!.contains(item.client)
            ).toList();
          }
          logsProvider.setLogsData(newLogsData);
        }
        else {
          LogsData newLogsData = result['data'];
          if (logsProvider.appliedFilters.clients != null) {
            newLogsData.data = newLogsData.data.where(
              (item) => logsProvider.appliedFilters.clients!.contains(item.client)
            ).toList();
          }
          logsProvider.setLogsData(newLogsData);
        }
        logsProvider.setLoadStatus(1);
      }
      else {
        logsProvider.setLoadStatus(2);
        appConfigProvider.addLog(result['log']);
      }
    }
  }

  void fetchFilteringRules() async {
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);

    final result = await getFilteringRules(server: serversProvider.selectedServer!);
    if (mounted) {
      if (result['result'] == 'success') {
        statusProvider.setFilteringStatus(result['data']);
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.couldntGetFilteringStatus),
            backgroundColor: Colors.red,
          )
        );
      }
    }
  }

  Future fetchClients() async {
    final logsProvider = Provider.of<LogsProvider>(context, listen: false);
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);

    final result = await getClients(serversProvider.selectedServer!);
    if (mounted) {
      if (result['result'] == 'success') {
        logsProvider.setClientsLoadStatus(1);
        logsProvider.setClients(result['data'].autoClients);
      }
      else {
        logsProvider.setClientsLoadStatus(2);
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.couldntGetFilteringStatus),
            backgroundColor: Colors.red,
          )
        );
      }
    }
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500 && isLoadingMore == false) {
      fetchLogs(loadingMore: true);
    }
    if (scrollController.position.pixels > 0) {
      setState(() => showDivider = false);
    }
    else {
      setState(() => showDivider = true);
    }
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(scrollListener);
    fetchLogs(inOffset: 0);
    fetchFilteringRules();
    fetchClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void updateConfig(Map<String, dynamic> data) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = serverVersionIsAhead(
        currentVersion: statusProvider.serverStatus!.serverVersion, 
        referenceVersion: 'v0.107.28',
        referenceVersionBeta: 'v0.108.0-b.33'
      ) == true 
        ? await updateQueryLogParameters(server: serversProvider.selectedServer!, data: data)
        : await updateQueryLogParametersLegacy(server: serversProvider.selectedServer!, data: data);

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

      final result = await clearLogs(server: serversProvider.selectedServer!);

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsCleared, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

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

    Widget generateBody() {
      switch (logsProvider.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingLogs,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );
        
        case 1:
          return RefreshIndicator(
            onRefresh: () async {
              await fetchLogs(inOffset: 0);
            },
            child: logsProvider.logsData!.data.isNotEmpty
              ? ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: isLoadingMore == true 
                    ? logsProvider.logsData!.data.length+1
                    : logsProvider.logsData!.data.length,
                  itemBuilder: (context, index) {
                    if (isLoadingMore == true && index == logsProvider.logsData!.data.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (logsProvider.logsData!.data[index].question.name != null) {
                      return LogTile(
                        log: logsProvider.logsData!.data[index],
                        index: index,
                        length: logsProvider.logsData!.data.length,
                        isLogSelected: selectedLog != null && selectedLog == logsProvider.logsData!.data[index],
                        onLogTap: (log) {
                          if (width <= 1100) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LogDetailsScreen(
                                log: log,
                                dialog: false,
                              )
                            ));
                          }
                          setState(() => selectedLog = log);
                        }
                      );
                    }
                    else {
                      return null;
                    }
                  }
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noLogsDisplay,
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (logsProvider.logsOlderThan != null) Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 20,
                          right: 20
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.noLogsThatOld,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ]
                  ),
                )
          );
          
        case 2:
          return SizedBox(
            width: double.maxFinite,
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
                Text(
                  AppLocalizations.of(context)!.logsNotLoaded,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    Widget logsScreen() {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.logs),
          centerTitle: false,
          actions: [
            if (!(Platform.isAndroid || Platform.isIOS)) IconButton(
              onPressed: () => fetchLogs(inOffset: 0), 
              icon: const Icon(Icons.refresh_rounded),
              tooltip: AppLocalizations.of(context)!.refresh,
            ),
            logsProvider.loadStatus == 1 
              ? IconButton(
                  onPressed: openFilersModal, 
                  icon: const Icon(Icons.filter_list_rounded),
                  tooltip: AppLocalizations.of(context)!.filters,
                )
              : const SizedBox(),
            IconButton(
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
                preferredSize: const Size(double.maxFinite, 50),
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
                            Icons.link_rounded,
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
                            fetchLogs(
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
                            fetchLogs(
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
                            fetchLogs(
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
        ),
        body: generateBody()
      );
    }

    if (width > 1100) {
      return Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: logsScreen()
            ),
            Expanded(
              flex: 2,
              child: selectedLog != null
                ? LogDetailsScreen(
                    log: selectedLog!,
                    dialog: false,
                  )
                : const SizedBox()
            )
          ],
        ),
      );
    }
    else {
      return logsScreen();
    }
  }
}