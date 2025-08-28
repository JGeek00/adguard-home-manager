// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/screens/settings/update_server/autoupdate_unavailable.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html;
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    
    void showAutoUpdateUnavailableModal() {
      showModal(
        context: context, 
        builder: (context) => const AutoUpdateUnavailableModal()
      );
    }

    void update() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.requestingUpdate);

      final result = await serversProvider.apiClient2!.requestUpdateServer();

      processModal.close();
      
      if (result.successful == true) {
        serversProvider.recheckPeriodServerUpdated();
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateSuccessful,
          color: Colors.green,
          labelColor: Colors.white,
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateFailed,
          color: Colors.red,
          labelColor: Colors.white,
        );
      }
    }  

    Widget headerPortrait() {
      return Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (Navigator.canPop(context)) IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onPressed: () => Navigator.pop(context), 
              ),
              if (!Navigator.canPop(context)) const SizedBox(),
              IconButton(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                tooltip: AppLocalizations.of(context)!.checkUpdates,
                onPressed: () => serversProvider.checkServerUpdatesAvailable(
                  server: serversProvider.selectedServer!,
                )
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
                  ? const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 4)
                      ],
                    )
                  : Icon(
                      serversProvider.updateAvailable.data!.canAutoupdate == true
                        ? Icons.system_update_rounded
                        : Icons.system_security_update_good_rounded,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                const SizedBox(height: 16),
                Text(
                  serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                    ? AppLocalizations.of(context)!.checkingUpdates
                    : serversProvider.updateAvailable.data!.canAutoupdate == true
                      ? AppLocalizations.of(context)!.updateAvailable
                      :  AppLocalizations.of(context)!.serverUpdated,
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
                          serversProvider.updateAvailable.data!.canAutoupdate == true
                            ? AppLocalizations.of(context)!.newVersion
                            : AppLocalizations.of(context)!.currentVersion,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          serversProvider.updateAvailable.data!.canAutoupdate == true
                            ? serversProvider.updateAvailable.data!.newVersion ?? 'N/A'
                            : serversProvider.updateAvailable.data!.currentVersion,
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
                      onPressed: serversProvider.updatingServer == true
                        ? null
                        : serversProvider.updateAvailable.data!.canAutoupdate == true 
                          ? serversProvider.updateAvailable.data!.canAutoupdate != null && serversProvider.updateAvailable.data!.canAutoupdate == true
                            ? () => update()
                            : () => showAutoUpdateUnavailableModal()
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

    final SafeArea? changelog;
    if (serversProvider.updateAvailable.loadStatus == LoadStatus.loaded && serversProvider.updateAvailable.data!.changelog != null) {
      changelog = SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Changelog ${serversProvider.updateAvailable.data!.canAutoupdate == true 
                  ? serversProvider.updateAvailable.data!.newVersion
                  : serversProvider.updateAvailable.data!.currentVersion}",
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
                onLinkTap: (url, context, attributes) => url != null ? openUrl(url) : null,
              )
            )
          ],
        ),
      );
    } else {
      changelog = null;
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: SafeArea(
              child: headerPortrait()
            )
          ),
          const SizedBox(height: 16),
          changelog != null
            ? Expanded(child: changelog)
            : const SizedBox(),
        ]
      )
    );
  }
}