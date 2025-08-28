import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';



String colorTranslation(BuildContext context, int index) {
  // This indexes has to be in sync with colors array at constants/colors.dart
  List<String> translations = [
    "AdGuard",
    AppLocalizations.of(context)!.red,
    AppLocalizations.of(context)!.green,
    AppLocalizations.of(context)!.blue,
    AppLocalizations.of(context)!.yellow,
    AppLocalizations.of(context)!.orange,
    AppLocalizations.of(context)!.brown,
    AppLocalizations.of(context)!.cyan,
    AppLocalizations.of(context)!.purple,
    AppLocalizations.of(context)!.pink,
    AppLocalizations.of(context)!.deepOrange,
    AppLocalizations.of(context)!.indigo,
  ];
  return translations[index];
}