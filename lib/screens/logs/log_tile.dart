// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_details_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/functions/format_time.dart';

class LogTile extends StatelessWidget {
  final Log log;
  final int length;
  final int index;

  const LogTile({
    Key? key,
    required this.log,
    required this.length,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    Widget logStatusWidget({
      required IconData icon, 
      required Color color, 
      required String text
    }) {
      return Flexible(
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 12
              ),  
            )
          ]
        ),
      );
    }
    
    Widget generateLogStatus() {
      final filter = getFilteredStatus(context, log.reason, false);
      return logStatusWidget(
        icon: filter['icon'],
        color: filter['color'],
        text: filter['label'],
      );
    }

    void blockUnblock(Log log, String newStatus) async {
      final ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingUserFilters);

      final rules = await getFilteringRules(server: serversProvider.selectedServer!);

      if (rules['result'] == 'success') {
        FilteringStatus oldStatus = serversProvider.filteringStatus!;

        List<String> newRules = rules['data'].userRules.where((domain) => !domain.contains(log.question.name)).toList();
        if (newStatus == 'block') {
          newRules.add("||${log.question.name}^");
        }
        else if (newStatus == 'unblock') {
          newRules.add("@@||${log.question.name}^");
        }
        FilteringStatus newObj = serversProvider.filteringStatus!;
        newObj.userRules = newRules;
        serversProvider.setFilteringStatus(newObj);

        final result  = await postFilteringRules(server: serversProvider.selectedServer!, data: {'rules': newRules});
        
        processModal.close();
        
        if (result['result'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.userFilteringRulesUpdated),
              backgroundColor: Colors.green,
            )
          );
        }
        else {
          appConfigProvider.addLog(result['log']);
          serversProvider.setFilteringStatus(oldStatus);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.userFilteringRulesNotUpdated),
              backgroundColor: Colors.red,
            )
          );
        }
      }
      else {
        appConfigProvider.addLog(rules['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.userFilteringRulesNotUpdated),
            backgroundColor: Colors.red,
          )
        );
      }
    }
    
    void openLogDetailsModal() {
      ScaffoldMessenger.of(context).clearSnackBars();
      showFlexibleBottomSheet(
        minHeight: 0.6,
        initHeight: 0.6,
        maxHeight: 0.95,
        isCollapsible: true,
        duration: const Duration(milliseconds: 250),
        anchors: [0.95],
        context: context, 
        builder: (ctx, controller, offset) => LogDetailsModal(
          scrollController: controller,
          log: log,
          blockUnblock: blockUnblock,
        ),
        bottomSheetColor: Colors.transparent,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: openLogDetailsModal,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            border: index < length
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor
                  )
                )
              : null
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width-130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.question.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (log.client.length <= 15) Row(
                      children: [
                        ...[
                          Icon(
                            Icons.smartphone_rounded,
                            size: 16,
                            color: Theme.of(context).listTileTheme.iconColor,
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            child: Text(
                              log.client,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).listTileTheme.iconColor,
                                fontSize: 13
                              ),
                            ),
                          )
                        ],
                        const SizedBox(width: 15),
                        ...[
                          Icon(
                            Icons.schedule_rounded,
                            size: 16,
                            color: Theme.of(context).listTileTheme.iconColor,
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            child: Text(
                              formatTimestampUTCFromAPI(log.time, 'HH:mm:ss'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).listTileTheme.iconColor,
                                fontSize: 13
                              ),
                            ),
                          )
                        ],
                      ],
                    ),
                    if (log.client.length > 15) Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.smartphone_rounded,
                              size: 16,
                              color: Theme.of(context).listTileTheme.iconColor,
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              child: Text(
                                log.client,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).listTileTheme.iconColor,
                                  fontSize: 13
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 16,
                              color: Theme.of(context).listTileTheme.iconColor,
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              child: Text(
                                formatTimestampUTCFromAPI(log.time, 'HH:mm:ss'),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).listTileTheme.iconColor,
                                  fontSize: 13
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              generateLogStatus()
            ],
          ),
        ),
      ),
    );
  }
}