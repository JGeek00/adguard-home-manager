// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_details_list.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class LogDetailsScreen extends StatelessWidget {
  final Log log;

  const LogDetailsScreen({
    Key? key,
    required this.log
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar.large(
                title:  Text(AppLocalizations.of(context)!.logDetails),
                actions: [
                  IconButton(
                    onPressed: () => blockUnblock(log, getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true ? 'unblock' : 'block'),
                    icon: Icon(
                      getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                        ? Icons.check_circle_rounded
                        : Icons.block
                    ),
                    tooltip: getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                      ? AppLocalizations.of(context)!.unblockDomain
                      : AppLocalizations.of(context)!.blockDomain,
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ),
          ),
        ],
        body: LogDetailsList(log: log)
      ),
    );
  }
}