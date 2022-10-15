import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteDnsRewrite extends StatelessWidget {
  final void Function() onConfirm;

  const DeleteDnsRewrite({
    Key? key,
    required this.onConfirm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const Icon(
            Icons.delete_rounded,
            size: 26,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.deleteDnsRewrite,
            textAlign: TextAlign.center,
          )
        ],
      ),
      content: Text(AppLocalizations.of(context)!.deleteDnsRewriteMessage),
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