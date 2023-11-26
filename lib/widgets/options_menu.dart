import 'dart:io';

import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile_dialog.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/menu_option.dart';

class OptionsMenu extends StatelessWidget {
  final Widget child;
  final List<MenuOption> options;
  final dynamic value;
  final BorderRadius? borderRadius;
  final void Function(dynamic)? onTap;

  const OptionsMenu({
    super.key,
    required this.child,
    required this.options,
    this.value,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    void openOptionsModal() {
      showDialog(
        context: context, 
        builder: (context) => _OptionsModal(
          options: options,
          value: value
        )
      );
    }

    return Material(
      color: Colors.transparent,
      child: ContextMenuArea(
        builder: (context) => options.map((opt) => CustomListTile(
          title: opt.title,
          icon: opt.icon,
          onTap: () {
            opt.action(value);
            Navigator.pop(context);
          },
        )).toList(),
        child: InkWell(
          onTap: onTap != null
            ? () => onTap!(value)
            : null,
          onLongPress: (Platform.isAndroid || Platform.isIOS)
            ? () => openOptionsModal()
            : null,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}

class _OptionsModal extends StatelessWidget {
  final List<MenuOption> options;
  final dynamic value;

  const _OptionsModal({
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