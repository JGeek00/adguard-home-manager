// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/screens/filters/add_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/add_custom_rule.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class FiltersFab extends StatelessWidget {
  final String type;

  const FiltersFab({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void confirmAddRule(String rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingRules);

      final List<String> newRules = serversProvider.filtering.data!.userRules;
      newRules.add(rule);

      final result = await setCustomRules(server: serversProvider.selectedServer!, rules: newRules);

      processModal.close();

      if (result['result'] == 'success') {
        FilteringData filteringData = serversProvider.filtering.data!;
        filteringData.userRules = newRules;
        serversProvider.setFilteringData(filteringData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleAddedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleNotAdded),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openAddCustomRule() {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => AddCustomRule(
          onConfirm: confirmAddRule
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    void confirmAddList({required String name, required String url}) async {
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
            serversProvider.setFilteringData(result2['data']);
            serversProvider.setFilteringLoadStatus(1, true);
          }
          else {
            appConfigProvider.addLog(result2['log']);
            serversProvider.setFilteringLoadStatus(2, true);
          }

          processModal.close();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${AppLocalizations.of(context)!.listAdded} $items."),
              backgroundColor: Colors.green,
            )
          );
        }
        else {
          processModal.close();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.listNotAdded),
              backgroundColor: Colors.red,
            )
          );
        }
      }
      else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains("Couldn't fetch filter from url")) {
        processModal.close();
        appConfigProvider.addLog(result1['log']);
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listUrlInvalid),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result1['result'] == 'error' && result1['log'].statusCode == '400' && result1['log'].resBody.toString().contains('Filter URL already added')) {
        processModal.close();
        appConfigProvider.addLog(result1['log']);
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listAlreadyAdded),
            backgroundColor: Colors.red,
          )
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listNotAdded),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openAddWhitelistBlacklist() {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => AddListModal(
          type: type,
          onConfirm: confirmAddList
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    return FloatingActionButton(
      onPressed: type == 'blacklist' || type == 'whitelist'
        ? () => openAddWhitelistBlacklist()
        : () => openAddCustomRule(),
      child: const Icon(Icons.add),
    );
  }
}