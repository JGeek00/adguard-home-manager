import 'dart:io';

import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/options_modal.dart';
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
        builder: (context) => OptionsModal(
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