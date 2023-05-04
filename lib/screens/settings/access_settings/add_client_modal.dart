import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddClientModal extends StatefulWidget {
  final String type;
  final void Function(String, String) onConfirm;
  final bool dialog;

  const AddClientModal({
    Key? key,
    required this.type,
    required this.onConfirm,
    required this.dialog,
  }) : super(key: key);

  @override
  State<AddClientModal> createState() => _AddClientModalState();
}

class _AddClientModalState extends State<AddClientModal> {
  TextEditingController fieldController = TextEditingController();

  bool validData = false;

  void checkValidValues() {
    if (fieldController.text != '') {
      setState(() => validData = true);
    }
    else {
      setState(() => validData = false);
    }
  }
    
  @override
  Widget build(BuildContext context) {
    IconData icon() {
      switch (widget.type) {
        case 'allowed':
          return Icons.check;

        case 'disallowed':
          return Icons.block;

        case 'domains':
          return Icons.link_rounded;

        default:
          return Icons.check;
      }
    }

    String title() {
      switch (widget.type) {
        case 'allowed':
          return AppLocalizations.of(context)!.allowClient;

        case 'disallowed':
          return AppLocalizations.of(context)!.disallowClient;

        case 'domains':
          return AppLocalizations.of(context)!.disallowedDomains;

        default:
          return "";
      }
    }

    Widget content() {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon(),
                          size: 24,
                          color: Theme.of(context).listTileTheme.iconColor
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: fieldController,
                      onChanged: (_) => checkValidValues(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.link_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        helperText: widget.type == 'allowed' || widget.type == 'disallowed'
                          ? AppLocalizations.of(context)!.addClientFieldDescription : null,
                        labelText: widget.type == 'allowed' || widget.type == 'disallowed'
                          ? AppLocalizations.of(context)!.clientIdentifier
                          : AppLocalizations.of(context)!.domain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text(AppLocalizations.of(context)!.cancel)
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: validData == true
                      ? () {
                          Navigator.pop(context);
                          widget.onConfirm(fieldController.text, widget.type);
                        }
                      : null, 
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(
                        color: validData == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (widget.dialog == true) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400
            ),
            child: content()
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            )
          ),
          child: content()
        ),
      );
    }
  }
}