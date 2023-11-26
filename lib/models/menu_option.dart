import 'package:flutter/material.dart';

class MenuOption {
  final IconData? icon;
  final String title;
  final void Function(dynamic) action;
  final bool? disabled;

  const MenuOption({
    required this.title,
    required this.action,
    this.icon,
    this.disabled
  });
}