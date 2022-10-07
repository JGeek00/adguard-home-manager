import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OptionsModal extends StatelessWidget {
  final void Function() onEdit;
  final void Function() onDelete;

  const OptionsModal({
    Key? key,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      title: Column(
        children: [
          const Icon(Icons.more_horiz),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.options)
        ],
      ),
      content: SizedBox(
        height: 150,
        width: double.minPositive,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 25),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onEdit();
              },
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.edit),
              ),
              leading: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.edit),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
              leading: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.delete),
              ),
            ),
          ],
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