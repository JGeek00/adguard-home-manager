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
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16
      ),
      title: Column(
        children: [
          const Icon(Icons.more_horiz),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.options)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
            title: Text(
              AppLocalizations.of(context)!.edit,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
            title: Text(
              AppLocalizations.of(context)!.delete,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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