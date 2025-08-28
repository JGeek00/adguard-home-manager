import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


class ResetSettingsModal extends StatelessWidget {
  final void Function() onConfirm;

  const ResetSettingsModal({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.restore_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.resetSettings,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.resetEncryptionSettingsDescription,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          }, 
          child: Text(AppLocalizations.of(context)!.confirm)
        ),
      ],
    );
  }
}