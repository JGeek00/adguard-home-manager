import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClearDnsCacheDialog extends StatelessWidget {
  final void Function() onConfirm;

  const ClearDnsCacheDialog({
    Key? key,
    required this.onConfirm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.delete_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.clearDnsCache, 
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.clearDnsCacheMessage,
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
              child: Text(AppLocalizations.of(context)!.cancel)
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              }, 
              child: Text(AppLocalizations.of(context)!.confirm)
            )
          ],
        )
      ],
    );
  }
}