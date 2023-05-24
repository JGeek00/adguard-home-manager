// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class SafeSearchSettingsScreen extends StatelessWidget {
  const SafeSearchSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProviuder = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return SafeSearchSettingsScreenWidget(
      serversProvider: serversProvider,
      statusProvider: statusProviuder,
      appConfigProvider: appConfigProvider,
    );
  }
}

class SafeSearchSettingsScreenWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final StatusProvider statusProvider;
  final AppConfigProvider appConfigProvider;
    
  const SafeSearchSettingsScreenWidget({
    Key? key,
    required this.serversProvider,
    required this.statusProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<SafeSearchSettingsScreenWidget> createState() => _SafeSearchSettingsScreenWidgetState();
}

class _SafeSearchSettingsScreenWidgetState extends State<SafeSearchSettingsScreenWidget> {
  bool generalEnabled = false;
  bool bingEnabled = false;
  bool duckduckgoEnabled = false;
  bool googleEnabled = false;
  bool pixabayEnabled = false;
  bool yandexEnabled = false;
  bool youtubeEnabled = false;

  Future requestSafeSearchSettings() async {
    if (mounted) {
      final result = await getServerStatus(widget.serversProvider.selectedServer!);
      if (mounted) {
        if (result['result'] == 'success') {
          widget.statusProvider.setServerStatusData(
            data: result['data']
          );
          widget.statusProvider.setServerStatusLoad(LoadStatus.loaded);
          setState(() {
            generalEnabled = result['data'].safeSearchEnabled;
            bingEnabled = result['data'].safeSeachBing;
            duckduckgoEnabled = result['data'].safeSearchDuckduckgo;
            googleEnabled = result['data'].safeSearchGoogle;
            pixabayEnabled = result['data'].safeSearchPixabay;
            yandexEnabled = result['data'].safeSearchYandex;
            youtubeEnabled = result['data'].safeSearchYoutube;
          });
        }
        else {
          widget.appConfigProvider.addLog(result['log']);
          widget.statusProvider.setServerStatusLoad(LoadStatus.error);
        }
      }
    }
  }

  @override
  void initState() {
    if (widget.statusProvider.loadStatus == LoadStatus.loading) {
      requestSafeSearchSettings();
    }
    else if (widget.statusProvider.loadStatus == LoadStatus.loaded) {
      generalEnabled = widget.statusProvider.serverStatus!.safeSearchEnabled;
      bingEnabled = widget.statusProvider.serverStatus!.safeSeachBing!;
      duckduckgoEnabled = widget.statusProvider.serverStatus!.safeSearchDuckduckgo!;
      googleEnabled = widget.statusProvider.serverStatus!.safeSearchGoogle!;
      pixabayEnabled = widget.statusProvider.serverStatus!.safeSearchPixabay!;
      yandexEnabled = widget.statusProvider.serverStatus!.safeSearchYandex!;
      youtubeEnabled = widget.statusProvider.serverStatus!.safeSearchYoutube!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void saveConfig() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingSettings);

      final result = await updateSafeSearchSettings(
        server: serversProvider.selectedServer!, 
        body: {
          "enabled": generalEnabled,
          "bing": bingEnabled,
          "duckduckgo": duckduckgoEnabled,
          "google": googleEnabled,
          "pixabay": pixabayEnabled,
          "yandex": yandexEnabled,
          "youtube": youtubeEnabled
        }
      );

      processModal.close();

      if (result['result'] == 'success') {
        ServerStatus data = statusProvider.serverStatus!;
        data.safeSearchEnabled = generalEnabled;
        data.safeSeachBing = bingEnabled;
        data.safeSearchDuckduckgo = duckduckgoEnabled;
        data.safeSearchGoogle = googleEnabled;
        data.safeSearchPixabay = pixabayEnabled;
        data.safeSearchYandex = yandexEnabled;
        data.safeSearchYoutube = youtubeEnabled;

        statusProvider.setServerStatusData(
          data: data
        );

        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsUpdatedSuccessfully,
          color: Colors.green,
          labelColor: Colors.white
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsNotSaved,
          color: Colors.red,
          labelColor: Colors.white
        );
      }
    }

    Widget body() {
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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.safeSearchSettings),
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
      body: body(),
    );
  }
}