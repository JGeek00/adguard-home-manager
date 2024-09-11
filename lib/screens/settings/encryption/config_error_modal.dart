import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EncryptionErrorModal extends StatelessWidget {
  final String error;

  const EncryptionErrorModal({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.configError,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface
        ),
      ),
      content: Text(
        error,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.close)
        )
      ],
    );
  }
}