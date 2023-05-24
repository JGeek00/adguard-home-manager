// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/add_custom_rule.dart';
import 'package:adguard_home_manager/screens/filters/add_list_modal.dart';

import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AddFiltersButton extends StatelessWidget {
  final String type;
  final Widget Function(void Function()) widget;

  const AddFiltersButton({
    Key? key,
    required this.type,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void confirmAddRule(String rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingRule);

      final List<String> newRules = filteringProvider.filtering!.userRules;
      newRules.add(rule);

      final result = await setCustomRules(server: serversProvider.selectedServer!, rules: newRules);

      processModal.close();

      if (result['result'] == 'success') {
        Filtering filteringData = filteringProvider.filtering!;
        filteringData.userRules = newRules;
        filteringProvider.setFilteringData(filteringData);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleAddedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddCustomRule() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => AddCustomRule(
            onConfirm: confirmAddRule,
            dialog: true,
          ),
          barrierDismissible: false
        );
      }
      else {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => AddCustomRule(
              onConfirm: confirmAddRule,
              dialog: false,
            ),
          )
        );
      }
    }

    void confirmAddList({required String name, required String url, required String type}) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingList);

      final result1 = await addFilteringList(server: serversProvider.selectedServer!, data: {
        'name': name,
        'url': url,
        'whitelist': type == 'whitelist' ? true : false
      });

      if (result1['result'] == 'success') {
        if (result1['data'].toString().contains("OK")) {
          final result2 = await getFiltering(server: serversProvider.selectedServer!);
          final items = result1['data'].toString().split(' ')[1];

          if (result2['result'] == 'success') {
            filteringProvider.setFilteringData(result2['data']);
            filteringProvider.setFilteringLoadStatus(LoadStatus.loaded, true);
          }
          else {
            appConfigProvider.addLog(result2['log']);
            filteringProvider.setFilteringLoadStatus(LoadStatus.error, true);
          }

          processModal.close();

          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: "${AppLocalizations.of(context)!.listAdded} $items.", 
            color: Colors.green
          );
        }
        else {
          processModal.close();

          showSnacbkar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.listNotAdded, 
            color: Colors.red
          );
        }
      }
      else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains("Couldn't fetch filter from url")) {
        processModal.close();
        appConfigProvider.addLog(result1['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listUrlInvalid, 
          color: Colors.red
        );
      }
      else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains('Filter URL already added')) {
        processModal.close();
        appConfigProvider.addLog(result1['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listAlreadyAdded, 
          color: Colors.red
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddWhitelistBlacklist() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (ctx) => AddListModal(
            type: type,
            onConfirm: confirmAddList,
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          builder: (ctx) => AddListModal(
            type: type,
            onConfirm: confirmAddList,
            dialog: false,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent
        );
      }
    }

    return widget(
      type == 'blacklist' || type == 'whitelist'
        ? () => openAddWhitelistBlacklist()
        : () => openAddCustomRule(),
    );
  }
}