import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_toggle.dart';

class AddCustomRule extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(String) onConfirm;

  const AddCustomRule({
    Key? key,
    required this.scrollController,
    required this.onConfirm
  }) : super(key: key);

  @override
  State<AddCustomRule> createState() => _AddCustomRuleState();
}

class _AddCustomRuleState extends State<AddCustomRule> {
  final TextEditingController domainController = TextEditingController();
  String? domainError;

  bool validValues = false;

  String preset = "block";

  bool addImportant = false;

  void checkValidValues() {
    if (domainController.text != '') {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  void validateDomain(String value) {
    final domainRegex = RegExp(r'^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9]))\.([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}\.[a-zA-Z]{2,3})$');
    if (domainRegex.hasMatch(value)) {
      setState(() => domainError = null);
    }
    else {
      setState(() => domainError = AppLocalizations.of(context)!.domainNotValid);
    }
  }

  String buildRule() {
    String rule = "";
    
    if (preset == 'block') {
      rule = "||${domainController.text.trim()}^";
    }
    else if (preset == 'unblock') {
      rule = "@@||${domainController.text.trim()}^";
    }
    else {
      rule = domainController.text.trim();
    }
    
    if (addImportant == true) {
      rule = "$rule\$important";
    }

    return rule;
  }
    
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: widget.scrollController,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 28),
                    child: Icon(
                      Icons.shield_rounded,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.addCustomRule,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Theme.of(context).primaryColor
                          )
                        ),
                        child: Text(
                          buildRule(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextFormField(
                      controller: domainController,
                      onChanged: validateDomain,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.link_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: domainError,
                        labelText: AppLocalizations.of(context)!.domain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRadioToggle(
                        groupSelected: preset, 
                        value: 'block', 
                        label: AppLocalizations.of(context)!.block,
                        onTap: (value) => setState(() => preset = value)
                      ),
                      CustomRadioToggle(
                        groupSelected: preset, 
                        value: 'unblock', 
                        label: AppLocalizations.of(context)!.unblock,
                        onTap: (value) => setState(() => preset = value)
                      ),
                      CustomRadioToggle(
                        groupSelected: preset, 
                        value: 'custom', 
                        label: AppLocalizations.of(context)!.custom,
                        onTap: (value) => setState(() => preset = value)
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => addImportant = !addImportant),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.addImportant,
                                style: const TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ),
                            Switch(
                              value: addImportant, 
                              onChanged: (value) => setState(() => addImportant = value),
                              activeColor: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.info),
                                const SizedBox(width: 20),
                                Text(
                                  AppLocalizations.of(context)!.examples,
                                  style: const TextStyle(
                                    fontSize: 18
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "||example.org^",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    AppLocalizations.of(context)!.example1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "@@||example.org^",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    AppLocalizations.of(context)!.example2,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "! Here goes a comment",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  Text(
                                    "# Also a comment",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    AppLocalizations.of(context)!.example3,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "/REGEX/",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    AppLocalizations.of(context)!.example4,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppLocalizations.of(context)!.moreInformation,
                                style: const TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.open_in_new),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 28,
                top: 20,
                bottom: 28
              ),
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
                          widget.onConfirm(domainController.text);
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
            )
          ],
        ),
      ),
    );
  }
}