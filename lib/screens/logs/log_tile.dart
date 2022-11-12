// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/functions/format_time.dart';

class LogTile extends StatelessWidget {
  final Log log;
  final int length;
  final int index;
  final Log? selectedLog;
  final void Function(Log) onLogSelected;

  const LogTile({
    Key? key,
    required this.log,
    required this.length,
    required this.index,
    this.selectedLog,
    required this.onLogSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    Widget logStatusWidget({
      required IconData icon, 
      required Color color, 
      required String text
    }) {
      if (width < 700) {
        return Column(
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
        );
      }
      else {
        return Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 12
              ),  
            )
          ]
        );
      }
    }
    
    Widget generateLogStatus() {
      final filter = getFilteredStatus(context, appConfigProvider, log.reason, width >= 700);
      return logStatusWidget(
        icon: filter['icon'],
        color: filter['color'],
        text: filter['label'],
      );
    }

    Widget tileChild = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width >= 700 ? (width*0.4)-56 : width-130,
                child: Text(
                  log.question.name,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (log.client.length <= 15 && appConfigProvider.showNameTimeLogs == false) Row(
                children: [
                  ...[
                    Icon(
                      Icons.smartphone_rounded,
                      size: 16,
                      color: Theme.of(context).listTileTheme.textColor,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      child: Text(
                        log.client,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).listTileTheme.textColor,
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                  const SizedBox(width: 15),
                  ...[
                    Icon(
                      Icons.schedule_rounded,
                      size: 16,
                      color: Theme.of(context).listTileTheme.textColor,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      child: Text(
                        formatTimestampUTCFromAPI(log.time, 'HH:mm:ss'),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).listTileTheme.textColor,
                          fontSize: 13
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (log.client.length > 15 || appConfigProvider.showNameTimeLogs == true) Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: 16,
                        color: Theme.of(context).listTileTheme.textColor,
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        child: Text(
                          log.client,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).listTileTheme.textColor,
                            fontSize: 13
                          ),
                        ),
                      )
                    ],
                  ),
                  if (appConfigProvider.showNameTimeLogs == true && log.clientInfo!.name != '') ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.badge_rounded,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: Text(
                            log.clientInfo!.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.textColor,
                              fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: Theme.of(context).listTileTheme.textColor,
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        child: Text(
                          formatTimestampUTCFromAPI(log.time, 'HH:mm:ss'),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).listTileTheme.textColor,
                            fontSize: 13
                          ),
                        ),
                      )
                    ],
                  ),
                  if (appConfigProvider.showNameTimeLogs == true && log.elapsedMs != '') ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16,
                          color: Theme.of(context).listTileTheme.textColor,
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: Text(
                            "${double.parse(log.elapsedMs).toStringAsFixed(2)} ms",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.textColor,
                              fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ],
              ),
              if (width >= 700) ...[
                const SizedBox(height: 10),
                SizedBox(
                  child: generateLogStatus()
                )
              ]
            ],
          ),
        ),
        if (width < 700) ...[
          const SizedBox(width: 10),
          generateLogStatus()
        ]
      ],
    );
  
    if (width < 700) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onLogSelected(log),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: tileChild
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => onLogSelected(log),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: selectedLog == log 
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null
              ),
              child: tileChild
            ),
          ),
        ),
      );
    }
  }
}