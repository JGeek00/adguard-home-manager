// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

void showSnacbkar({
  required BuildContext context, 
  required AppConfigProvider appConfigProvider,
  required String label, 
  required Color color
}) async {
  if (appConfigProvider.showingSnackbar == true) {
    ScaffoldMessenger.of(context).clearSnackBars();
    await Future.delayed(const Duration(milliseconds: 500));
  }
  appConfigProvider.setShowingSnackbar(true);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(label),
      backgroundColor: color,
    )
  ).closed.then((value) => appConfigProvider.setShowingSnackbar(false));
}