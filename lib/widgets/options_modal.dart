import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile_dialog.dart';

class OptionsModal extends StatelessWidget {
  final List<MenuOption> options;

  const OptionsModal({
    Key? key,
    required this.options,
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
        children: options.map((opt) => CustomListTileDialog(
          title: opt.title,
          icon: opt.icon,
          onTap: () {
            Navigator.pop(context);
            opt.action();
          },
        )).toList()
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