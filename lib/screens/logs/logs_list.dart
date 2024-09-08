// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/details/log_details_screen.dart';
import 'package:adguard_home_manager/screens/logs/log_tile.dart';
import 'package:adguard_home_manager/screens/logs/logs_list_appbar.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class LogsListWidget extends StatefulWidget {
  final Log? selectedLog;
  final bool twoColumns;
  final void Function(Log) onLogSelected;

  const LogsListWidget({
    super.key,
    required this.twoColumns,
    required this.selectedLog,
    required this.onLogSelected,
  });

  @override
  State<LogsListWidget> createState() => _LogsListWidgetState();
}

class _LogsListWidgetState extends State<LogsListWidget> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool showDivider = true;

  void fetchFilteringRules() async {
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);

    final result = await statusProvider.getFilteringRules();
    if (mounted && result == false) {
      showSnacbkar(
        appConfigProvider: appConfigProvider, 
        label: AppLocalizations.of(context)!.couldntGetFilteringStatus, 
        color: Colors.red
      );
    }
  }

  Future fetchClients() async {
    final clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);

    final result = await clientsProvider.fetchClients();
    if (mounted && result == false) {
      showSnacbkar(
        appConfigProvider: appConfigProvider, 
        label: AppLocalizations.of(context)!.couldntGetFilteringStatus, 
        color: Colors.red
      );
    }
  }

  bool scrollListener(ScrollUpdateNotification scrollNotification) {
    final logsProvider = Provider.of<LogsProvider>(context, listen: false);

    if (scrollNotification.metrics.extentAfter < 500 && logsProvider.isLoadingMore == false) {
      logsProvider.fetchLogs(loadingMore: true);
    }
    if (scrollNotification.metrics.pixels > 0) {
      setState(() => showDivider = false);
    }
    else {
      setState(() => showDivider = true);
    }
    
    return false;
  }

  @override
  void initState() {
    final logsProvider = Provider.of<LogsProvider>(context, listen: false);

    logsProvider.fetchLogs(inOffset: 0);
    fetchFilteringRules();
    fetchClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);
    
    return ScaffoldMessenger(
      key: widget.twoColumns ? _scaffoldMessengerKey : null,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: LogsListAppBar(
                innerBoxIsScrolled: innerBoxIsScrolled, 
                showDivider: showDivider,
              )
            )
          ],
          body: Builder(
            builder: (context) {
              switch (logsProvider.loadStatus) {
                case LoadStatus.loading:
                  return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          SliverFillRemaining(
                            child: SizedBox(
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
                            )
                          )
                        ],
                      ),
                    ) 
                  );
                
                case LoadStatus.loaded:
                  return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => RefreshIndicator(
                        onRefresh: () async {
                          await logsProvider.fetchLogs(inOffset: 0);
                        },
                        displacement: 95,
                        child: NotificationListener(
                          onNotification: scrollListener,
                          child: CustomScrollView(
                            slivers: [
                              SliverOverlapInjector(
                                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              ),
                              if (logsProvider.logsData!.data.isNotEmpty) SliverList.builder(
                                itemCount: logsProvider.isLoadingMore 
                                  ? logsProvider.logsData!.data.length + 1 
                                  : logsProvider.logsData!.data.length,
                                itemBuilder: (context, index) {
                                  if (logsProvider.isLoadingMore == true && index == logsProvider.logsData!.data.length) {
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
                                      isLogSelected: widget.selectedLog != null && widget.selectedLog == logsProvider.logsData!.data[index],
                                      onLogTap: (log) {
                                        if (!widget.twoColumns) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => LogDetailsScreen(
                                                log: log,
                                                dialog: false,
                                                twoColumns: widget.twoColumns,
                                              )
                                            )
                                          );
                                        }
                                        widget.onLogSelected(log);
                                      },
                                      twoColumns: widget.twoColumns,
                                    );
                                  }
                                  else {
                                    return null;
                                  }
                                }
                              ),
                              if (logsProvider.logsData!.data.isEmpty) SliverFillRemaining(
                                child: Center(
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) 
                  );
                  
                case LoadStatus.error:
                  return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          SliverFillRemaining(
                            child: SizedBox(
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
                            )
                          )
                        ],
                      ),
                    ) 
                  );
      
                default:
                  return const SizedBox();
              }
            },
          )
        ),
      ),
    );
  }
}