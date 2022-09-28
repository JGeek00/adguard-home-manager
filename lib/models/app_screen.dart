import 'package:flutter/material.dart';

class AppScreen {
  final String name;
  final IconData icon;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? fab;

  const AppScreen({
    required this.name,
    required this.icon,
    this.appBar,
    required this.body,
    this.fab
  });
}