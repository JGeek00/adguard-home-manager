import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


class ErrorMessageEncryption extends StatelessWidget {
  final String errorMessage;

  const ErrorMessageEncryption({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.error),
      content: Text(errorMessage),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.close)
            )
          ],
        )
      ],
    );
  }
}