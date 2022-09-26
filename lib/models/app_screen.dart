import 'package:flutter/material.dart';

class AppScreen {
  final String name;
  final IconData icon;
  final Widget widget;

  const AppScreen({
    required this.name,
    required this.icon,
    required this.widget
  });
}