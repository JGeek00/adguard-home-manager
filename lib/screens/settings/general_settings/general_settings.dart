import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/settings.dart';
import 'package:adguard_home_manager/screens/settings/general_settings/top_items_list/top_items_list_settings.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class GeneralSettings extends StatefulWidget {
  final bool splitView;

  const GeneralSettings({
    super.key,
    required this.splitView,
  });

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

enum AppUpdatesStatus { available, checking, recheck }

class _GeneralSettingsState extends State<GeneralSettings> {
  AppUpdatesStatus appUpdatesStatus = AppUpdatesStatus.recheck;

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
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsUpdatedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.cannotUpdateSettings, 
          color: Colors.red
        );
      }
    }

    // Future checkUpdatesAvailable() async {
    //   setState(() => appUpdatesStatus = AppUpdatesStatus.checking);
      
    //   final res = await checkAppUpdates(
    //     currentBuildNumber: appConfigProvider.getAppInfo!.buildNumber, 
    //     setUpdateAvailable: appConfigProvider.setAppUpdatesAvailable, 
    //     installationSource: appConfigProvider.installationSource,
    //     isBeta: appConfigProvider.getAppInfo!.version.contains('beta'),
    //   );

    //   if (!mounted) return;
    //   if (res != null) {
    //     setState(() => appUpdatesStatus = AppUpdatesStatus.available);
    //   }
    //   else {
    //     setState(() => appUpdatesStatus = AppUpdatesStatus.recheck);
    //   }
    // }

    // Widget generateAppUpdateStatus() {
    //   if (appUpdatesStatus == AppUpdatesStatus.available) {
    //     return IconButton(
    //       onPressed: appConfigProvider.appUpdatesAvailable != null
    //         ? () async {
    //             final link = getAppUpdateDownloadLink(appConfigProvider.appUpdatesAvailable!);
    //             if (link != null) {
    //               openUrl(link);
    //             }
    //           }
    //         : null, 
    //       icon: const Icon(Icons.download_rounded),
    //       tooltip: AppLocalizations.of(context)!.downloadUpdate,
    //     );
    //   }
    //   else if (appUpdatesStatus == AppUpdatesStatus.checking) {
    //     return const Padding(
    //       padding: EdgeInsets.only(right: 16),
    //       child: SizedBox(
    //         width: 24,
    //         height: 24,
    //         child: CircularProgressIndicator(
    //           strokeWidth: 3,
    //         )
    //       ),
    //     );
    //   }
    //   else {
    //     return IconButton(
    //       onPressed: checkUpdatesAvailable, 
    //       icon: const Icon(Icons.refresh_rounded),
    //       tooltip: AppLocalizations.of(context)!.checkUpdates,
    //     );
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SectionLabel(label: AppLocalizations.of(context)!.home),
            CustomListTile(
              icon: Icons.exposure_zero_rounded,
              title: AppLocalizations.of(context)!.hideZeroValues,
              subtitle: AppLocalizations.of(context)!.hideZeroValuesDescription,
              trailing: Switch(
                value: appConfigProvider.hideZeroValues, 
                onChanged: (value) => updateSettings(
                  newStatus: value, 
                  function: appConfigProvider.setHideZeroValues
                ),
              ),
              onTap: () => updateSettings(
                newStatus: !appConfigProvider.hideZeroValues, 
                function: appConfigProvider.setHideZeroValues
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 16,
                right: 10
              )
            ),
            CustomListTile(
              icon: Icons.show_chart_rounded,
              title: AppLocalizations.of(context)!.combinedChart,
              subtitle: AppLocalizations.of(context)!.combinedChartDescription,
              trailing: Switch(
                value: appConfigProvider.combinedChartHome, 
                onChanged: (value) => updateSettings(
                  newStatus: value, 
                  function: appConfigProvider.setCombinedChartHome
                ),
              ),
              onTap: () => updateSettings(
                newStatus: !appConfigProvider.combinedChartHome, 
                function: appConfigProvider.setCombinedChartHome
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 16,
                right: 10
              )
            ),
            CustomListTile(
              icon: Icons.remove_red_eye_rounded,
              title: AppLocalizations.of(context)!.hideServerAddress,
              subtitle: AppLocalizations.of(context)!.hideServerAddressDescription,
              trailing: Switch(
                value: appConfigProvider.hideServerAddress, 
                onChanged: (value) => updateSettings(
                  newStatus: value, 
                  function: appConfigProvider.setHideServerAddress
                ),
              ),
              onTap: () => updateSettings(
                newStatus: !appConfigProvider.hideServerAddress, 
                function: appConfigProvider.setHideServerAddress
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 16,
                right: 10
              )
            ),
            CustomListTile(
              icon: Icons.reorder_rounded,
              title: AppLocalizations.of(context)!.topItemsOrder,
              subtitle: AppLocalizations.of(context)!.topItemsOrderDescription,
              onTap: () => widget.splitView == true 
                ? Navigator.of(settingsNavigatorKey.currentContext!).push(
                    MaterialPageRoute(builder: (ctx) => const TopItemsListSettings())
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TopItemsListSettings()
                    )
                  ) 
            ),
            SectionLabel(label: AppLocalizations.of(context)!.logs),
            CustomListTile(
              icon: Icons.timer_rounded,
              title: AppLocalizations.of(context)!.timeLogs,
              subtitle: AppLocalizations.of(context)!.timeLogsDescription,
              trailing: Switch(
                value: appConfigProvider.showTimeLogs, 
                onChanged: (value) => updateSettings(
                  newStatus: value, 
                  function: appConfigProvider.setshowTimeLogs
                ),
              ),
              onTap: () => updateSettings(
                newStatus: !appConfigProvider.showTimeLogs, 
                function: appConfigProvider.setshowTimeLogs
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 16,
                right: 10
              )
            ),
            CustomListTile(
              icon: Icons.more,
              title: AppLocalizations.of(context)!.ipLogs,
              subtitle: AppLocalizations.of(context)!.ipLogsDescription,
              trailing: Switch(
                value: appConfigProvider.showIpLogs, 
                onChanged: (value) => updateSettings(
                  newStatus: value, 
                  function: appConfigProvider.setShowIpLogs
                ),
              ),
              onTap: () => updateSettings(
                newStatus: !appConfigProvider.showIpLogs, 
                function: appConfigProvider.setShowIpLogs
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 16,
                right: 10
              )
            ),
            // if (!(Platform.isAndroid || Platform.isIOS) || (Platform.isAndroid && (appConfigProvider.installationSource == InstallationAppReferrer.androidManually ))) ...[
            //   SectionLabel(label: AppLocalizations.of(context)!.application),
            //   CustomListTile(
            //     icon: Icons.system_update_rounded,
            //     title: AppLocalizations.of(context)!.appUpdates,
            //     subtitle: appConfigProvider.appUpdatesAvailable != null
            //       ? AppLocalizations.of(context)!.updateAvailable
            //       : AppLocalizations.of(context)!.usingLatestVersion,
            //     trailing: generateAppUpdateStatus()
            //   )
            // ]
          ],
        ),
      )
    );  
  }
}