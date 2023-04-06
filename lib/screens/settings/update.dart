// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html;
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void update() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.requestingUpdate);

      final result = await requestUpdateServer(server: serversProvider.selectedServer!);

      processModal.close();
      
      if (result['result'] == 'success') {
        serversProvider.clearUpdateAvailable(serversProvider.selectedServer!, serversProvider.updateAvailable.data!.newVersion);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateSuccessful,
          color: Colors.green,
          labelColor: Colors.white,
        );
      }
      else {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateFailed,
          color: Colors.red,
          labelColor: Colors.white,
        );
        appConfigProvider.addLog(result['log']);
      }
    }  

    Widget headerPortrait() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onPressed: () => Navigator.pop(context), 
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                tooltip: AppLocalizations.of(context)!.checkUpdates,
                onPressed: () => serversProvider.checkServerUpdatesAvailable(serversProvider.selectedServer!)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8, bottom: 16, left: 16, right: 16
            ),
            child: Column(
              children: [
                serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                  ? Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 4)
                      ],
                    )
                  : Icon(
                      serversProvider.updateAvailable.data!.updateAvailable != null
                        ? serversProvider.updateAvailable.data!.updateAvailable == true
                          ? Icons.system_update_rounded
                          : Icons.system_security_update_good_rounded
                        : Icons.system_security_update_warning_rounded,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                const SizedBox(height: 16),
                Text(
                  serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                    ? AppLocalizations.of(context)!.checkingUpdates
                    : serversProvider.updateAvailable.data!.updateAvailable != null
                      ? serversProvider.updateAvailable.data!.updateAvailable == true
                        ? AppLocalizations.of(context)!.updateAvailable
                        :  AppLocalizations.of(context)!.serverUpdated
                      : AppLocalizations.of(context)!.unknownStatus,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (serversProvider.updateAvailable.loadStatus == LoadStatus.loaded) Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serversProvider.updateAvailable.data!.updateAvailable != null && serversProvider.updateAvailable.data!.updateAvailable == true
                            ? AppLocalizations.of(context)!.newVersion
                            : AppLocalizations.of(context)!.currentVersion,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          serversProvider.updateAvailable.data!.updateAvailable != null
                            ? serversProvider.updateAvailable.data!.updateAvailable == true
                              ? serversProvider.updateAvailable.data!.newVersion
                              : serversProvider.updateAvailable.data!.currentVersion
                            : "N/A",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),
                        )
                      ],
                    ),
                    if (serversProvider.updateAvailable.loadStatus != LoadStatus.loaded) const SizedBox(),
                    FilledButton.icon(
                      icon: const Icon(Icons.download_rounded),
                      label: Text(AppLocalizations.of(context)!.updateNow),
                      onPressed: serversProvider.updateAvailable.data!.updateAvailable != null && serversProvider.updateAvailable.data!.updateAvailable == true 
                        ? () => update()
                        : null
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget headerLandscape() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onPressed: () => Navigator.pop(context), 
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                tooltip: AppLocalizations.of(context)!.checkUpdates,
                onPressed: () => serversProvider.checkServerUpdatesAvailable(serversProvider.selectedServer!)
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8, bottom: 16, left: 16, right: 16
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                    ? Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 4)
                        ],
                      )
                    : Icon(
                        serversProvider.updateAvailable.data!.updateAvailable != null
                          ? serversProvider.updateAvailable.data!.updateAvailable == true
                            ? Icons.system_update_rounded
                            : Icons.system_security_update_good_rounded
                          : Icons.system_security_update_warning_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  const SizedBox(height: 16),
                  Text(
                    serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                      ? AppLocalizations.of(context)!.checkingUpdates
                      : serversProvider.updateAvailable.data!.updateAvailable != null
                        ? serversProvider.updateAvailable.data!.updateAvailable == true
                          ? AppLocalizations.of(context)!.updateAvailable
                          :  AppLocalizations.of(context)!.serverUpdated
                        : AppLocalizations.of(context)!.unknownStatus,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (serversProvider.updateAvailable.loadStatus == LoadStatus.loaded) Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              serversProvider.updateAvailable.data!.updateAvailable != null && serversProvider.updateAvailable.data!.updateAvailable == true
                                ? AppLocalizations.of(context)!.newVersion
                                : AppLocalizations.of(context)!.currentVersion,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              serversProvider.updateAvailable.data!.updateAvailable != null
                                ? serversProvider.updateAvailable.data!.updateAvailable == true
                                  ? serversProvider.updateAvailable.data!.newVersion
                                  : serversProvider.updateAvailable.data!.currentVersion
                                : "N/A",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            )
                          ],
                        ),
                        if (serversProvider.updateAvailable.loadStatus != LoadStatus.loaded) const SizedBox(),
                        FilledButton.icon(
                          icon: const Icon(Icons.download_rounded),
                          label: Text(AppLocalizations.of(context)!.updateNow),
                          onPressed: serversProvider.updateAvailable.data!.updateAvailable != null && serversProvider.updateAvailable.data!.updateAvailable == true 
                            ? () => update()
                            : null
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    final changelog = serversProvider.updateAvailable.loadStatus == LoadStatus.loaded && serversProvider.updateAvailable.data!.changelog != null
      ? ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Changelog ${serversProvider.updateAvailable.data!.newVersion}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Html(
              data: html.parse(md.markdownToHtml(serversProvider.updateAvailable.data!.changelog!)).outerHtml,
              onLinkTap: (url, context, attributes, element) => url != null ? openUrl(url) : null,
            )
          )
        ],
      )
      : null;

    return Scaffold(
      body: MediaQuery.of(context).size.width > 700
        ? Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).viewPadding.top
                        ),
                        child: headerLandscape(),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: changelog ?? const SizedBox(),
                  ),
                ),
              )
            ],
          )
        : Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: SafeArea(
                  child: headerPortrait()
                )
              ),
              changelog != null
                ? Expanded(child: changelog)
                : const SizedBox(),
            ]
          )
    );
  }
}