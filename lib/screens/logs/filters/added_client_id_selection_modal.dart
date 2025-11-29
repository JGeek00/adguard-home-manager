import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';

class AddedClientIdSelectionModal extends StatefulWidget {
  final List<String> clientIds;
  final void Function(String) onConfirm;

  const AddedClientIdSelectionModal({
    super.key,
    required this.clientIds,
    required this.onConfirm
  });

  @override
  State<AddedClientIdSelectionModal> createState() => _AddedClientIdSelectionModalState();
}

class _AddedClientIdSelectionModalState extends State<AddedClientIdSelectionModal> {
  String _selectedId = "";

  @override
  void initState() {
    _selectedId = widget.clientIds.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.selectIdToFilter),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: DropdownButtonFormField(
          items: widget.clientIds.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          )).toList(),
          initialValue: widget.clientIds.first,
          onChanged: (value) => setState(() => _selectedId = value!),
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            label: Text(AppLocalizations.of(context)!.clientIds)
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onConfirm(_selectedId);
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        )
      ],
    );
  }
}