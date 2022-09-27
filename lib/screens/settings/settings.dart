import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/theme_modal.dart';
import 'package:adguard_home_manager/screens/settings/custom_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/section_label.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final statusBarHeight = MediaQuery.of(context).viewInsets.top;

    String getThemeString() {
      switch (appConfigProvider.selectedThemeNumber) {
        case 0:
          return AppLocalizations.of(context)!.systemDefined;

        case 1:
          return AppLocalizations.of(context)!.light;

        case 2:
          return AppLocalizations.of(context)!.dark;

        default:
          return "";
      }
    }

    void openThemeModal() {
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => ThemeModal(
          statusBarHeight: statusBarHeight,
          selectedTheme: appConfigProvider.selectedThemeNumber,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    return ListView(
      children: [
        SectionLabel(label: AppLocalizations.of(context)!.appSettings),
        CustomListTile(
          leadingIcon: Icons.light_mode_rounded,
          label: AppLocalizations.of(context)!.theme, 
          description: getThemeString(),
          onTap: openThemeModal,
        ),
      ],
    );
  }
}