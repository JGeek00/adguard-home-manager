// ignore_for_file: use_build_context_synchronously

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
  const FiltersFab({Key? key}) : super(key: key);

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

    void openAddClient() {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => AddCustomRule(
          onConfirm: confirmAddRule
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    return FloatingActionButton(
      onPressed: openAddClient,
      child: const Icon(Icons.add),
    );
  }
}