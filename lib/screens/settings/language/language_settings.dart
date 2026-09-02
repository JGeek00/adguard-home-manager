import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/languages.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    final selected = appConfigProvider.selectedLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
        centerTitle: false,
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      ),
      body: SafeArea(
        child: RadioGroup<String?>(
          groupValue: selected,
          onChanged: (value) => appConfigProvider.setSelectedLanguage(value),
          child: ListView(
            children: [
              RadioListTile<String?>(
                value: null,
                title: Text(AppLocalizations.of(context)!.systemDefined),
              ),
              const Divider(),
              ...sortedAppLanguages.map((language) => RadioListTile<String?>(
                value: language.tag,
                title: Text(language.name),
              )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
