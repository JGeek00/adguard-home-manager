import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/logs_filters_modal.dart';

class LogsAppBar extends StatelessWidget with PreferredSizeWidget {
  const LogsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openFilersModal() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => const LogsFiltersModal(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true
      );
    }

    return AppBar(
      title: Text(AppLocalizations.of(context)!.logs),
      actions: [
        IconButton(
          onPressed: openFilersModal, 
          icon: const Icon(Icons.filter_list_rounded)
        ),
        const SizedBox(width: 5),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}