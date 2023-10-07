import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile_dialog.dart';

class OptionsModal extends StatelessWidget {
  final void Function() onEdit;
  final void Function() onDelete;

  const OptionsModal({
    Key? key,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16
      ),
      title: Column(
        children: [
          Icon(
            Icons.more_horiz,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.options,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          if (statusProvider.serverStatus != null) CustomListTileDialog(
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
            title: AppLocalizations.of(context)!.edit,
            icon: Icons.edit,
          ),
          CustomListTileDialog(
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
            title: AppLocalizations.of(context)!.delete,
            icon: Icons.delete,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.close)
        )
      ],
    );
  }
}