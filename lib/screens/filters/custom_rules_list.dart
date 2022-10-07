// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/fab.dart';
import 'package:adguard_home_manager/screens/filters/remove_custom_rule_modal.dart';

import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class CustomRulesList extends StatelessWidget {
  final List<String> data;

  const CustomRulesList({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void removeCustomRule(String rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingRules);

      final List<String> newRules = serversProvider.filtering.data!.userRules.where((r) => r != rule).toList();

      final result = await setCustomRules(server: serversProvider.selectedServer!, rules: newRules);

      processModal.close();

      if (result['result'] == 'success') {
        FilteringData filteringData = serversProvider.filtering.data!;
        filteringData.userRules = newRules;
        serversProvider.setFilteringData(filteringData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleRemovedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.ruleNotRemoved),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openRemoveCustomRuleModal(String rule) {
      showDialog(
        context: context, 
        builder: (context) => RemoveCustomRule(
          onConfirm: () => removeCustomRule(rule),
        )
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(data[index]),
            trailing: IconButton(
              onPressed: () => openRemoveCustomRuleModal(data[index]),
              icon: const Icon(Icons.delete)
            ),
          )
        ),
        const Positioned(
          bottom: 20,
          right: 20,
          child: FiltersFab()
        )
      ],
    );
  }
}