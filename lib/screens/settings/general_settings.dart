// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/custom_list_tile.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalSettings) ,
      ),
      body: ListView(
        children: [
          CustomListTile(
            leadingIcon: Icons.exposure_zero_rounded,
            label: AppLocalizations.of(context)!.hideZeroValues,
            description: AppLocalizations.of(context)!.hideZeroValuesDescription,
            trailing: Switch(
              value: appConfigProvider.hideZeroValues, 
              onChanged: updateHideZeroValues,
              activeColor: Theme.of(context).primaryColor,
            ),
            onTap: () => updateHideZeroValues(!appConfigProvider.hideZeroValues),
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