import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/logs_filters_modal.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';

class LogsAppBar extends StatelessWidget with PreferredSizeWidget {
  const LogsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    void openFilersModal() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => const LogsFiltersModal(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true
      );
    }

    int getNumFiltersApplied() {
      int number = 0;
      if (logsProvider.logsOlderThan != null) {
        number++;
      }
      if (logsProvider.searchText != null) {
        number++;
      }
      if (logsProvider.selectedResultStatus != 'all') {
        number++;
      }
      return number;
    }

    return AppBar(
      title: Text(AppLocalizations.of(context)!.logs),
      actions: [
        logsProvider.loadStatus == 1 
          ? TextButton.icon(
              onPressed: openFilersModal, 
              icon: const Icon(Icons.filter_list_rounded),
              label: Text("${AppLocalizations.of(context)!.filters} ${getNumFiltersApplied() > 0 ? '(${getNumFiltersApplied().toString()})' : ''}"),
            )
          : const SizedBox(),
        const SizedBox(width: 5),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}