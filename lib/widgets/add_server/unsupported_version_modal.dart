import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/config/minimum_server_version.dart';

class UnsupportedVersionModal extends StatelessWidget {
  final String serverVersion;
  final void Function() onClose;

  const UnsupportedVersionModal({
    super.key,
    required this.serverVersion,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.error_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.unsupportedServerVersion,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.unsupportedServerVersionMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.yourVersion(serverVersion),
            style: const TextStyle(
              fontStyle: FontStyle.italic
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.minimumRequiredVersion(
              serverVersion.contains("b")
                ? MinimumServerVersion.beta
                : MinimumServerVersion.stable
            ),
            style: const TextStyle(
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onClose();
          }, 
          child: Text(AppLocalizations.of(context)!.close)
        ),
      ],
    );
  }
}