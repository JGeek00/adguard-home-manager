// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_tile.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/models/server.dart';
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
    );
  }
}

class LogsWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final LogsProvider logsProvider;

  const LogsWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.logsProvider,
  }) : super(key: key);

  @override
  State<LogsWidget> createState() => _LogsWidgetState();
}

class _LogsWidgetState extends State<LogsWidget> {
  late ScrollController scrollController;
  
  bool isLoadingMore = false;

  Future fetchLogs({
    int? inOffset,
    bool? loadingMore
  }) async {
    int offst = inOffset ?? widget.logsProvider.offset;

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = true);
    }

    final result = await getLogs(
      server: widget.serversProvider.selectedServer!, 
      count: widget.logsProvider.logsQuantity, 
      offset: offst,
      olderThan: widget.logsProvider.logsOlderThan,
      responseStatus: widget.logsProvider.selectedResultStatus,
      search: widget.logsProvider.searchText
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
    final logsProvider = Provider.of<LogsProvider>(context);

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
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
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
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.grey
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey
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
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        );

      default:
        return const SizedBox();
    }
  }
}