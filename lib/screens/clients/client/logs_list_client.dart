import 'dart:io';

import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_tile.dart';
import 'package:adguard_home_manager/screens/logs/details/log_details_screen.dart';

import 'package:adguard_home_manager/services/api_client.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class LogsListClient extends StatefulWidget {
  final String ip;
  final String? name;
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final bool splitView;

  const LogsListClient({
    super.key,
    required this.ip,
    this.name,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.splitView,
  });

  @override
  State<LogsListClient> createState() => _LogsListClientState();
}

class _LogsListClientState extends State<LogsListClient> {
  late ScrollController scrollController;

  bool isLoadingMore = false;

  int logsQuantity = 100;
  int offset = 0;

  int loadStatus = 0;
  LogsData? logsData;

  String previousIp = "";

  bool showDivider = true;

  CancelableOperation? cancelableRequest;

  Future fetchLogs({
    int? inOffset,
    bool? loadingMore,
    String? responseStatus,
    String? searchText,
  }) async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    
    int offst = inOffset ?? offset;

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = true);
    }

    if (cancelableRequest != null) cancelableRequest!.cancel(); 

    cancelableRequest = CancelableOperation.fromFuture(
      serversProvider.apiClient2!.getLogs(
        count: logsQuantity, 
        offset: offst,
        search: '"${widget.ip}"'
      )
    );

    final result = await cancelableRequest?.value as ApiResponse;
    if (!mounted) return;

    if (loadingMore != null && loadingMore == true && mounted) {
      setState(() => isLoadingMore = false);
    }

    if (result.successful == true) {
      setState(() => offset = inOffset != null ? inOffset+logsQuantity : offset+logsQuantity);
      if (loadingMore != null && loadingMore == true && logsData != null) {
        LogsData newLogsData = result.content;
        newLogsData.data = [...logsData!.data, ...result.content.data];
        setState(() => logsData = newLogsData);
      }
      else {
        LogsData newLogsData = result.content;
        setState(() => logsData = newLogsData);
      }
      setState(() => loadStatus = 1);
    }
    else {
      setState(() => loadStatus = 2);
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
    setState(() => previousIp = widget.ip);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (widget.ip != previousIp) {
      setState(() => loadStatus = 0);
      fetchLogs(inOffset: 0);
      setState(() => previousIp = widget.ip);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name != null && widget.name != '' ? widget.name! : widget.ip),
        centerTitle: true,
        surfaceTintColor: isDesktop(MediaQuery.of(context).size.width) 
          ? Colors.transparent 
          : null,
        actions: [
          if (!(Platform.isAndroid || Platform.isIOS)) ...[
            IconButton(
              onPressed: fetchLogs, 
              icon: const Icon(Icons.refresh_rounded),
              tooltip: AppLocalizations.of(context)!.refresh,
            ),
            const SizedBox(width: 8)
          ]
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (loadStatus) {
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              );

            case 1:
              if (logsData!.data.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: fetchLogs,
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: isLoadingMore == true 
                      ? logsData!.data.length+1
                      : logsData!.data.length,
                    itemBuilder: (context, index) {
                      if (isLoadingMore == true && index == logsData!.data.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      else {
                        return LogTile(
                          log: logsData!.data[index],
                          index: index,
                          length: logsData!.data.length,
                          useAlwaysNormalTile: true,
                          onLogTap: (log) => {
                            if (width > 700) {
                              showDialog(
                                context: context, 
                                builder: (context) => LogDetailsScreen(
                                  log: log, 
                                  dialog: true
                                )
                              )
                            }
                            else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LogDetailsScreen(
                                    log: log, 
                                    dialog: false
                                  )
                                )
                              )
                            }
                          },
                          twoColumns: widget.splitView,
                        );
                      }
                    }
                  ),
                );
              }
              else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noLogsDisplay,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }
            
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
                      textAlign: TextAlign.center,
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
        },
      )
    );
  }
}