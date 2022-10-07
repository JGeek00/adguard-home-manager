import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCustomRule extends StatefulWidget {
  final void Function(String) onConfirm;

  const AddCustomRule({
    Key? key,
    required this.onConfirm
  }) : super(key: key);

  @override
  State<AddCustomRule> createState() => _AddCustomRuleState();
}

class _AddCustomRuleState extends State<AddCustomRule> {
  TextEditingController ruleController = TextEditingController();

  bool validValues = false;

  void checkValidValues() {
    if (ruleController.text != '') {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
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
            const Icon(
              Icons.shield_rounded,
              size: 26,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.addCustomRule,
              style: const TextStyle(
                fontSize: 24
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: ruleController,
              onChanged: (_) => checkValidValues(),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.rule),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                labelText: AppLocalizations.of(context)!.rule,
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
                          onPressed: validValues == true
                            ? () {
                                Navigator.pop(context);
                                widget.onConfirm(ruleController.text);
                              }
                            : null, 
                          child: Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                              color: validValues == true
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