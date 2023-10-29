// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class SafeSearchSettingsScreen extends StatefulWidget {    
  const SafeSearchSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SafeSearchSettingsScreen> createState() => _SafeSearchSettingsScreenState();
}

class _SafeSearchSettingsScreenState extends State<SafeSearchSettingsScreen> {
  bool generalEnabled = false;
  bool bingEnabled = false;
  bool duckduckgoEnabled = false;
  bool googleEnabled = false;
  bool pixabayEnabled = false;
  bool yandexEnabled = false;
  bool youtubeEnabled = false;
  
  Future requestSafeSearchSettings() async {
    final result = await Provider.of<StatusProvider>(context, listen: false).getServerStatus();
    if (mounted && result == true) {
      final statusProvider = Provider.of<StatusProvider>(context, listen: false);
      if (statusProvider.serverStatus != null) {
        setState(() {
          generalEnabled = statusProvider.serverStatus!.safeSearchEnabled;
          bingEnabled = statusProvider.serverStatus!.safeSeachBing ?? false;
          duckduckgoEnabled = statusProvider.serverStatus!.safeSearchDuckduckgo ?? false;
          googleEnabled = statusProvider.serverStatus!.safeSearchGoogle ?? false;
          pixabayEnabled = statusProvider.serverStatus!.safeSearchPixabay ?? false;
          yandexEnabled = statusProvider.serverStatus!.safeSearchYandex ?? false;
          youtubeEnabled = statusProvider.serverStatus!.safeSearchYoutube ?? false;
        });
      }
    }
  }

  @override
  void initState() {
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);

    if (statusProvider.loadStatus == LoadStatus.loading) {
      requestSafeSearchSettings();
    }
    else if (statusProvider.loadStatus == LoadStatus.loaded) {
      generalEnabled = statusProvider.serverStatus!.safeSearchEnabled;
      bingEnabled = statusProvider.serverStatus!.safeSeachBing!;
      duckduckgoEnabled = statusProvider.serverStatus!.safeSearchDuckduckgo!;
      googleEnabled = statusProvider.serverStatus!.safeSearchGoogle!;
      pixabayEnabled = statusProvider.serverStatus!.safeSearchPixabay!;
      yandexEnabled = statusProvider.serverStatus!.safeSearchYandex!;
      youtubeEnabled = statusProvider.serverStatus!.safeSearchYoutube!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void saveConfig() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingSettings);

      final result = await statusProvider.updateSafeSearchConfig({
        "enabled": generalEnabled,
        "bing": bingEnabled,
        "duckduckgo": duckduckgoEnabled,
        "google": googleEnabled,
        "pixabay": pixabayEnabled,
        "yandex": yandexEnabled,
        "youtube": youtubeEnabled
      });

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsUpdatedSuccessfully,
          color: Colors.green,
          labelColor: Colors.white
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsNotSaved,
          color: Colors.red,
          labelColor: Colors.white
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.safeSearchSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: statusProvider.loadStatus == LoadStatus.loaded
              ? () => saveConfig()
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (statusProvider.loadStatus) {
            case LoadStatus.loading:
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.loadingSafeSearchSettings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              );
              
            case LoadStatus.loaded: 
              return RefreshIndicator(
                onRefresh: requestSafeSearchSettings,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 8
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(28),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(28),
                          onTap: () => setState(() => generalEnabled = !generalEnabled),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(28)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.enableSafeSearch,
                                  style: const TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                                Switch(
                                  value: generalEnabled, 
                                  onChanged: (value) => setState(() => generalEnabled = value)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomCheckboxListTile(
                      value: bingEnabled, 
                      onChanged: (value) => setState(() => bingEnabled = value), 
                      title: "Bing",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                    CustomCheckboxListTile(
                      value: duckduckgoEnabled, 
                      onChanged: (value) => setState(() => duckduckgoEnabled = value), 
                      title: "DuckDuckGo",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                    CustomCheckboxListTile(
                      value: googleEnabled, 
                      onChanged: (value) => setState(() => googleEnabled = value), 
                      title: "Google",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                    CustomCheckboxListTile(
                      value: pixabayEnabled, 
                      onChanged: (value) => setState(() => pixabayEnabled = value), 
                      title: "Pixabay",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                    CustomCheckboxListTile(
                      value: yandexEnabled, 
                      onChanged: (value) => setState(() => yandexEnabled = value), 
                      title: "Yandex",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                    CustomCheckboxListTile(
                      value: youtubeEnabled, 
                      onChanged: (value) => setState(() => youtubeEnabled = value), 
                      title: "YouTube",
                      padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 40, bottom: 8
                      ),
                      disabled: !generalEnabled,
                    ),
                  ],
                ),
              );

            case LoadStatus.error:
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.safeSearchSettingsNotLoaded,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              );


            default:
              return const SizedBox();
          }
        },
      )
    );
  }
}