import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile_dialog.dart';

class TopItemsOptionsModal extends StatelessWidget {
  final bool? isBlocked;
  final void Function(String status)? changeStatus;
  final void Function() copyToClipboard;

  const TopItemsOptionsModal({
    Key? key,
    this.isBlocked,
    this.changeStatus,
    required this.copyToClipboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      title: Column(
        children: [
          Icon(
            Icons.more_horiz,
            size: 24,
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
          if (isBlocked == true && changeStatus != null) CustomListTileDialog(
            title: AppLocalizations.of(context)!.unblock,
            icon: Icons.check,
            onTap: () {
              Navigator.pop(context);
              changeStatus!('unblock');
            },
          ),
          if (isBlocked == false && changeStatus != null) CustomListTileDialog(
            title: AppLocalizations.of(context)!.block,
            icon: Icons.block,
            onTap: () {
              Navigator.pop(context);
              changeStatus!('block');
            },
          ),
          CustomListTileDialog(
            title: AppLocalizations.of(context)!.copyDomainClipboard,
            icon: Icons.copy,
            onTap: () {
              Navigator.pop(context);
              copyToClipboard();
            }
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(AppLocalizations.of(context)!.cancel)
            )
          ],
        )
      ],
    );
  }
}