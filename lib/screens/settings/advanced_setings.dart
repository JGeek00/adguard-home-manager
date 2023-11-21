// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AdvancedSettings extends StatelessWidget {
  const AdvancedSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    Future updateSettings({
      required bool newStatus,
      required Future Function(bool) function
    }) async {
      final result = await function(newStatus);
      if (!context.mounted) return;
      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsUpdatedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.cannotUpdateSettings, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.advancedSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      ),
      body: ListView(
        children: [
          CustomListTile(
            icon: Icons.lock,
            title: AppLocalizations.of(context)!.dontCheckCertificate,
            subtitle: AppLocalizations.of(context)!.dontCheckCertificateDescription,
            trailing: Switch(
              value: appConfigProvider.overrideSslCheck, 
              onChanged: (value) => updateSettings(
                newStatus: value,
                function: appConfigProvider.setOverrideSslCheck
              ),
            ),
            onTap: () => updateSettings(
              newStatus: !appConfigProvider.overrideSslCheck,
              function: appConfigProvider.setOverrideSslCheck
            ),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 10
            )
          ),
        ],
      )
    );  
  }
}