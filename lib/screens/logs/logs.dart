// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/logs_filters_modal.dart';
import 'package:adguard_home_manager/screens/logs/logs_config_modal.dart';
import 'package:adguard_home_manager/screens/logs/log_tile.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Logs extends StatelessWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    return LogsWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
      logsProvider: logsProvider,
      selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus,
      searchText: logsProvider.appliedFilters.searchText,
    );
  }
}

class LogsWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final LogsProvider logsProvider;
  final String selectedResultStatus;
  final String? searchText;

  const LogsWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.logsProvider,
    required this.selectedResultStatus,
    required this.searchText,
  }) : super(key: key);

  @override
  State<LogsWidget> createState() => _LogsWidgetState();
}

class _LogsWidgetState extends State<LogsWidget> {
  late ScrollController scrollController;
  
  bool isLoadingMore = false;

  bool showDivider = true;

  Future fetchLogs({
    int? inOffset,
    bool? loadingMore,
    String? responseStatus,
    String? searchText,
  }) async {
    int offst = inOffset ?? widget.logsProvider.offset;

    String resStatus = responseStatus ?? widget.selectedResultStatus;
    String? search = searchText ?? widget.searchText;

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = true);
    }

    final result = await getLogs(
      server: widget.serversProvider.selectedServer!, 
      count: widget.logsProvider.logsQuantity, 
      offset: offst,
      olderThan: widget.logsProvider.logsOlderThan,
      responseStatus: resStatus,
      search: search
    );

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = false);
    }

    if (mounted) {
      if (result['result'] == 'success') {
        widget.logsProvider.setOffset(inOffset != null ? inOffset+widget.logsProvider.logsQuantity : widget.logsProvider.offset+widget.logsProvider.logsQuantity);
        if (loadingMore != null && loadingMore == true && widget.logsProvider.logsData != null) {
          LogsData newLogsData = result['data'];
          newLogsData.data = [...widget.logsProvider.logsData!.data, ...result['data'].data];
          widget.logsProvider.setLogsData(newLogsData);
        }
        else {
          widget.logsProvider.setLogsData(result['data']);
        }
        widget.logsProvider.setLoadStatus(1);
      }
      else {
        widget.logsProvider.setLoadStatus(2);
        widget.appConfigProvider.addLog(result['log']);
      }
    }
  }

  void fetchFilteringRules() async {
    final result = await getFilteringRules(server: widget.serversProvider.selectedServer!);
    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setFilteringStatus(result['data']);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    void updateConfig(Map<String, dynamic> data) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingSettings);

      final result = await updateQueryLogParameters(server: serversProvider.selectedServer!, data: data);

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsConfigUpdated, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
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
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsCleared, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.logsNotCleared, 
          color: Colors.red
        );
      }
    }


    void openFilersModal() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => const LogsFiltersModal(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true
      );
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
                    else {
                      return LogTile(
                        log: logsProvider.logsData!.data[index],
                        index: index,
                        length: logsProvider.logsData!.data.length,
                      );
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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.logs),
        actions: [
          logsProvider.loadStatus == 1 
            ? IconButton(
                onPressed: openFilersModal, 
                icon: const Icon(Icons.filter_list_rounded)
              )
            : const SizedBox(),
          IconButton(
            onPressed: () => {
              showModalBottomSheet(
                context: context, 
                builder: (context) => LogsConfigModal(
                  onConfirm: updateConfig,
                  onClear: clearQueries,
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true
              )
            }, 
            icon: const Icon(Icons.settings)
          ),
          const SizedBox(width: 5),
        ],
        bottom: logsProvider.appliedFilters.searchText != null || logsProvider.appliedFilters.selectedResultStatus != 'all'
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
                        ? Theme.of(context).dividerColor
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
                        avatar: Icon(
                          Icons.search,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: Row(
                          children: [
                            Text(
                              logsProvider.appliedFilters.searchText!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        deleteIcon: Icon(
                          Icons.cancel_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                        onDeleted: () {
                          logsProvider.setAppliedFilters(
                            AppliedFiters(
                              selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                              searchText: null
                            )
                          );
                          logsProvider.setSearchText(null);
                          fetchLogs(
                            inOffset: 0,
                            searchText: ''
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          )
                        ),
                        backgroundColor: Theme.of(context).dialogBackgroundColor,
                      ),
                    ],
                    if (logsProvider.appliedFilters.selectedResultStatus != 'all') ...[
                      const SizedBox(width: 15),
                      Chip(
                        avatar: Icon(
                          Icons.shield_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: Row(
                          children: [
                            Text(
                              translatedString[logsProvider.appliedFilters.selectedResultStatus]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        deleteIcon: Icon(
                          Icons.cancel_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                        onDeleted: () {
                          logsProvider.setAppliedFilters(
                            AppliedFiters(
                              selectedResultStatus: 'all', 
                              searchText: logsProvider.appliedFilters.searchText
                            )
                          );
                          logsProvider.setSelectedResultStatus('all');
                          fetchLogs(
                            inOffset: 0,
                            responseStatus: 'all'
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          )
                        ),
                        backgroundColor: Theme.of(context).dialogBackgroundColor,
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
}