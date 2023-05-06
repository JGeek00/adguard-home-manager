// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

Future<bool> enableDisableList({
  required BuildContext context, 
  required ServersProvider serversProvider, 
  required AppConfigProvider appConfigProvider, 
  required Filter list, 
  required String listType, 
}) async {
  ProcessModal processModal = ProcessModal(context: context);
  processModal.open(
    list.enabled == true
      ? AppLocalizations.of(context)!.disablingList
      : AppLocalizations.of(context)!.enablingList,
  );

  final result = await updateFilterList(server: serversProvider.selectedServer!, data: {
    "data": {
      "enabled": !list.enabled,
      "name": list.name,
      "url": list.url
    },
    "url": list.url,
    "whitelist": listType == 'whitelist' ? true : false
  });
     
  processModal.close();
       
  if (result['result'] == 'success') {
    final result2 = await getFiltering(server: serversProvider.selectedServer!);

    if (result2['result'] == 'success') {
      serversProvider.setFilteringData(result2['data']);
      serversProvider.setFilteringLoadStatus(LoadStatus.loaded, true);
    }
    else {
      appConfigProvider.addLog(result2['log']);
      serversProvider.setFilteringLoadStatus(LoadStatus.error, true);
    }
    
    return true;
  }
  else {
    appConfigProvider.addLog(result['log']);
    
    return false;
  }
}

Future<bool> editList({
  required BuildContext context,
  required ServersProvider serversProvider,
  required AppConfigProvider appConfigProvider,
  required Filter list,
  required String type
}) async {
  ProcessModal processModal = ProcessModal(context: context);
  processModal.open(AppLocalizations.of(context)!.updatingListData);
      
  final result1 = await updateFilterList(server: serversProvider.selectedServer!, data: {
    "data": {
      "enabled": list.enabled,
      "name": list.name,
      "url": list.url
    },
    "url": list.url,
    "whitelist": type == 'whitelist' ? true : false
  });
       
  if (result1['result'] == 'success') {
    final result2 = await getFiltering(server: serversProvider.selectedServer!);
        
    if (result2['result'] == 'success') {
      serversProvider.setFilteringData(result2['data']);
      serversProvider.setFilteringLoadStatus(LoadStatus.loaded, true);
    }
    else {
      appConfigProvider.addLog(result2['log']);
      serversProvider.setFilteringLoadStatus(LoadStatus.error, true);
    }
        
    processModal.close();

    return true;
  }
  else {
    processModal.close();
    appConfigProvider.addLog(result1['log']);

    return false;
  }
}

Future<bool> deleteList({
  required BuildContext context, 
  required ServersProvider serversProvider,
  required AppConfigProvider appConfigProvider,
  required Filter list,
  required String type
}) async {
  ProcessModal processModal = ProcessModal(context: context);
  processModal.open(AppLocalizations.of(context)!.deletingList);
      
  final result1 = await deleteFilterList(server: serversProvider.selectedServer!, data: {
    "url": list.url,
    "whitelist": type == 'whitelist' ? true : false
  });
      
  if (result1['result'] == 'success') {
    final result2 = await getFiltering(server: serversProvider.selectedServer!);
         
    if (result2['result'] == 'success') {
      serversProvider.setFilteringData(result2['data']);
      serversProvider.setFilteringLoadStatus(LoadStatus.loaded, true);
    }
    else {
      appConfigProvider.addLog(result2['log']);
      serversProvider.setFilteringLoadStatus(LoadStatus.loading, true);
    } 
           
    processModal.close();
      
    return true;
  }
  else {
    processModal.close();
    appConfigProvider.addLog(result1['log']);

    return false;
  }
}