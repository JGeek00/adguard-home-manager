import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile_dialog.dart';

class OptionsModal extends StatelessWidget {
  final List<MenuOption> options;
  final dynamic value;

  const OptionsModal({
    super.key,
    required this.options,
    this.value,
  });

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
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400
        ),
        child: SingleChildScrollView(
          child: Wrap(
            children: options.map((opt) => CustomListTileDialog(
              title: opt.title,
              icon: opt.icon,
              onTap: () {
                Navigator.pop(context);
                opt.action(value);
              },
            )).toList()
          ),
        ),
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