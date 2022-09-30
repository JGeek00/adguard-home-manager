import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_tile.dart';

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

    return LogsWidget(
      server: serversProvider.selectedServer!,
      createLog: appConfigProvider.addLog
    );
  }
}

class LogsWidget extends StatefulWidget {
  final Server server;
  final void Function(AppLog) createLog;

  const LogsWidget({
    Key? key,
    required this.server,
    required this.createLog
  }) : super(key: key);

  @override
  State<LogsWidget> createState() => _LogsWidgetState();
}

class _LogsWidgetState extends State<LogsWidget> {
  LogsList logsList = LogsList(
    loadStatus: 0, 
    logsData: null
  );

  int itemsPerLoad = 100;
  int offset = 0;

  late ScrollController scrollController;
  
  bool isLoadingMore = false;

  Future fetchLogs({
    int? inOffset,
    bool? loadingMore
  }) async {
    int offst = inOffset ?? offset;

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = true);
    }

    final result = await getLogs(server: widget.server, count: itemsPerLoad, offset: offst);

    if (loadingMore != null && loadingMore == true) {
      setState(() => isLoadingMore = false);
    }

    if (result['result'] == 'success') {
      setState(() {
        offset = inOffset != null ? inOffset+itemsPerLoad : offset+itemsPerLoad;
        if (loadingMore != null && loadingMore == true) {
          logsList.logsData!.data = [...logsList.logsData!.data, ...result['data'].data];
        }
        else {
          logsList.logsData = result['data'];
        }
        logsList.loadStatus = 1;
      });
    }
    else {
      setState(() {
        logsList.loadStatus = 2;
      });
      widget.createLog(result['log']);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (logsList.loadStatus) {
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
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 0),
            itemCount: isLoadingMore == true 
              ? logsList.logsData!.data.length+1
              : logsList.logsData!.data.length,
            itemBuilder: (context, index) {
              if (isLoadingMore == true && index == logsList.logsData!.data.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                return LogTile(
                  log: logsList.logsData!.data[index],
                  index: index,
                  length: logsList.logsData!.data.length,
                );
              }
            }
          ),
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