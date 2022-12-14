import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class UpdateModal extends StatefulWidget {
  final GitHubRelease gitHubRelease;
  final void Function(String, String) onDownload;

  const UpdateModal({
    Key? key,
    required this.gitHubRelease,
    required this.onDownload,
  }) : super(key: key);

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  bool doNotRemember = false;

  String getDownloadLink() {
   return widget.gitHubRelease.assets.firstWhere((item) => item.browserDownloadUrl.contains('apk')).browserDownloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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
            "${AppLocalizations.of(context)!.newVersion}: ${widget.gitHubRelease.tagName}",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onDownload(getDownloadLink(), widget.gitHubRelease.tagName);
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