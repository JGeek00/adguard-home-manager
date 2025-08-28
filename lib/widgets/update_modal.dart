import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/functions/app_update_download_link.dart';
import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class UpdateModal extends StatefulWidget {
  final GitHubRelease gitHubRelease;
  final void Function(String, String) onDownload;

  const UpdateModal({
    super.key,
    required this.gitHubRelease,
    required this.onDownload,
  });

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  bool doNotRemember = false;

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final downloadLink = getAppUpdateDownloadLink(widget.gitHubRelease);

    return AlertDialog(
      scrollable: true,
      title: Column(
        children: [
          Icon(
            Icons.system_update_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.updateAvailable, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "${AppLocalizations.of(context)!.installedVersion}: ${appConfigProvider.getAppInfo!.version}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${AppLocalizations.of(context)!.newVersion}: ${widget.gitHubRelease.name.replaceAll('v', '')}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${AppLocalizations.of(context)!.source}: GitHub",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => setState(() => doNotRemember = !doNotRemember),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: doNotRemember, 
                  onChanged: (value) => setState(() => doNotRemember = value!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.doNotRememberAgainUpdate,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  )
                )
              ],
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: downloadLink != null 
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
          children: [
            if (downloadLink != null) TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onDownload(downloadLink, widget.gitHubRelease.tagName);
              }, 
              child: Text(AppLocalizations.of(context)!.download)
            ),
            TextButton(
              onPressed: () {
                if (doNotRemember == true) {
                  appConfigProvider.setDoNotRememberVersion(widget.gitHubRelease.tagName);
                }
                Navigator.pop(context);
              }, 
              child: Text(AppLocalizations.of(context)!.close)
            ),
          ],
        )
      ],
    );
  }
}