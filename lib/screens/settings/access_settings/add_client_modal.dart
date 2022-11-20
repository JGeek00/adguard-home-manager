import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddClientModal extends StatefulWidget {
  final String type;
  final void Function(String, String) onConfirm;
  final double width;

  const AddClientModal({
    Key? key,
    required this.type,
    required this.onConfirm,
    required this.width
  }) : super(key: key);

  @override
  State<AddClientModal> createState() => _AddClientModalState();
}

class _AddClientModalState extends State<AddClientModal> {
  double width = 0;

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
  void initState() {
    width = widget.width;
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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

    Widget body = Material(
      color: Colors.transparent,
      child: ListView(
        physics: 322 < MediaQuery.of(context).size.height
          ? const NeverScrollableScrollPhysics() 
          : null,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Icon(
              icon(),
              size: 24,
              color: Theme.of(context).listTileTheme.iconColor
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
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
          ),
        ],
      ),
    );

    Widget actionButtons = Padding(
      padding: const EdgeInsets.all(24),
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
    );

    if (width < 700) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 322,
          ),
          child: Container(
            width: double.maxFinite,
            height: 322,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28)
              )
            ),
            child: Column(
              children: [
                Expanded(
                  child: body
                ),
                actionButtons
              ],
            ),
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 322,
            ),
            child: Container(
              width: mediaQuery.size.width > 500
                ? 500
                : mediaQuery.size.width-50,
              height: MediaQuery.of(context).size.height-50,
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(28)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: body
                  ),
                  actionButtons
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}