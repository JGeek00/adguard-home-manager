// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

Future<Map<String, dynamic>> blockUnblock(BuildContext context, String domain, String newStatus) async {
  final serversProvider = Provider.of<ServersProvider>(context, listen: false);
  final statusProvider = Provider.of<StatusProvider>(context, listen: false);
  final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);

  final ProcessModal processModal = ProcessModal(context: context);
  processModal.open(AppLocalizations.of(context)!.savingUserFilters);

  final rules = await getFilteringRules(server: serversProvider.selectedServer!);

  if (rules['result'] == 'success') {
    FilteringStatus oldStatus = statusProvider.serverStatus!.filteringStatus;
    List<String> newRules = rules['data'].userRules.where((d) => !d.contains(domain)).toList();
    if (newStatus == 'block') {
      newRules.add("||$domain^");
    }
    else if (newStatus == 'unblock') {
      newRules.add("@@||$domain^");
    }
    FilteringStatus newObj = statusProvider.serverStatus!.filteringStatus;
    newObj.userRules = newRules;
    serversProvider.setFilteringStatus(newObj);

    final result  = await postFilteringRules(server: serversProvider.selectedServer!, data: {'rules': newRules});
        
    processModal.close();
        
    if (result['result'] == 'success') {
      return {
        'success': true,
        'message': AppLocalizations.of(context)!.userFilteringRulesUpdated
      };
    }
    else {
      appConfigProvider.addLog(result['log']);
      serversProvider.setFilteringStatus(oldStatus);
      return {
        'success': false,
        'message': AppLocalizations.of(context)!.userFilteringRulesNotUpdated
      };
    }
  }
  else {
    appConfigProvider.addLog(rules['log']);
    return {
      'success': false,
      'message': AppLocalizations.of(context)!.userFilteringRulesNotUpdated
    };
  }
}