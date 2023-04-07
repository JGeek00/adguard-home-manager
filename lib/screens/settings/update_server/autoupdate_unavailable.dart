import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AutoUpdateUnavailableModal extends StatelessWidget {
  const AutoUpdateUnavailableModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.error_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.autoupdateUnavailable,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.autoupdateUnavailableDescription,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(AppLocalizations.of(context)!.close)
            ),
          ],
        )
      ],
    );
  }
}