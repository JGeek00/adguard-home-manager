// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    Future updateHideZeroValues(bool newStatus) async {
      final result = await appConfigProvider.setHideZeroValues(newStatus);
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.settingsUpdatedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cannotUpdateSettings),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    Future updateShowNameTimeLogs(bool newStatus) async {
      final result = await appConfigProvider.setShowNameTimeLogs(newStatus);
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.settingsUpdatedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cannotUpdateSettings),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalSettings),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          CustomListTile(
            icon: Icons.exposure_zero_rounded,
            title: AppLocalizations.of(context)!.hideZeroValues,
            subtitle: AppLocalizations.of(context)!.hideZeroValuesDescription,
            trailing: Switch(
              value: appConfigProvider.hideZeroValues, 
              onChanged: updateHideZeroValues,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            onTap: () => updateHideZeroValues(!appConfigProvider.hideZeroValues),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 10
            )
          ),
          CustomListTile(
            icon: Icons.more,
            title: AppLocalizations.of(context)!.nameTimeLogs,
            subtitle: AppLocalizations.of(context)!.nameTimeLogsDescription,
            trailing: Switch(
              value: appConfigProvider.showNameTimeLogs, 
              onChanged: updateShowNameTimeLogs,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            onTap: () => updateShowNameTimeLogs(!appConfigProvider.showNameTimeLogs),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 10
            )
          ),
        ],
      ),
    );  
  }
}