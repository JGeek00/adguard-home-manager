// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_details_modal.dart';

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

    final width = MediaQuery.of(context).size.width;

    Widget logStatusWidget({
      required IconData icon, 
      required Color color, 
      required String text
    }) {
      return Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),  
          )
        ]
      );
    }
    
    Widget generateLogStatus() {
      switch (log.reason) {
        case "NotFilteredNotFound":
          return logStatusWidget(
            icon: Icons.verified_user_rounded, 
            color: Colors.green, 
            text: AppLocalizations.of(context)!.processed,
          );

        case "FilteredBlackList":
          return logStatusWidget(
            icon: Icons.verified_user_rounded, 
            color: Colors.red, 
            text: AppLocalizations.of(context)!.blockedBlacklist,
          );

        case "NotFilteredWhiteList":
          return logStatusWidget(
            icon: Icons.verified_user_rounded, 
            color: Colors.green, 
            text: AppLocalizations.of(context)!.processedWhitelist,
          );
          
        default:
          return  logStatusWidget(
            icon: Icons.shield_rounded, 
            color: Colors.grey, 
            text: "Unknwon"
          );
      }
    }

    void blockUnblock(Log log, String newStatus) async {
      FilteringStatus oldStatus = serversProvider.filteringStatus!;

      List<String> newRules = serversProvider.filteringStatus!.userRules.where((domain) => !domain.contains(log.question.name)).toList();
      if (newStatus == 'block') {
        newRules.add("||${log.question.name}^");
      }
      else if (newStatus == 'unblock') {
        newRules.add("@@||${log.question.name}^");
      }
      FilteringStatus newObj = serversProvider.filteringStatus!;
      newObj.userRules = newRules;
      serversProvider.setFilteringStatus(newObj);
      
      String formattedFilters = "";
      for (var rule in newObj.userRules) {
        if (formattedFilters == "") {
          formattedFilters = "$formattedFilters$rule";
        }
        else {
          formattedFilters = "$formattedFilters\n$rule";
        }
      }

      final ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingUserFilters);

      final result  = await postFilteringRules(server: serversProvider.selectedServer!, data: formattedFilters);
      
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
        serversProvider.setFilteringStatus(oldStatus);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.userFilteringRulesNotUpdated),
            backgroundColor: Colors.red,
          )
        );
      }
    }
    
    void openLogDetailsModal() {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => LogDetailsModal(
          log: log,
          blockUnblock: blockUnblock,
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: openLogDetailsModal,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(10),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  generateLogStatus(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: width-100,
                    child: Text(
                      log.question.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: width-100,
                    child: Text(
                      log.client,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13
                      ),
                    ),
                  )
                ],
              ),
              Text(
                formatTimestampUTC(log.time, 'HH:mm:ss')
              ),
            ],
          ),
        ),
      ),
    );
  }
}