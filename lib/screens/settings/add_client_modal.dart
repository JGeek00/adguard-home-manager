import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddClientModal extends StatefulWidget {
  final String type;
  final void Function(String, String) onConfirm;

  const AddClientModal({
    Key? key,
    required this.type,
    required this.onConfirm
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

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 322,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          )
        ),
        child: Column(
          children: [
            Icon(
              icon(),
              size: 26,
            ),
            const SizedBox(height: 20),
            Text(
              title(),
              style: const TextStyle(
                fontSize: 24
              ),
            ),
            const SizedBox(height: 30),
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
                helperText: widget.type == 'allowed' || widget.type == 'blocked'
                  ? AppLocalizations.of(context)!.addClientFieldDescription : null,
                labelText: widget.type == 'allowed' || widget.type == 'blocked'
                  ? AppLocalizations.of(context)!.clientIdentifier
                  : AppLocalizations.of(context)!.domain,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)!.cancel)
                        ),
                        const SizedBox(width: 20),
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
                                ? Theme.of(context).primaryColor
                                : Colors.grey
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}