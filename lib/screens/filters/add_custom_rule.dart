import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:adguard_home_manager/constants/urls.dart';

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
  final TextEditingController domainController = TextEditingController();
  String? domainError;

  int preset = 0;

  bool addImportant = false;

  bool checkValidValues() {
    if (
      domainController.text != '' && 
      domainError == null
    ) {
      return true;
    }
    else {
      return false;
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
    checkValidValues();
  }

  String buildRule({String?value}) {
    String rule = "";

    String fieldValue = value ?? domainController.text;
    
    if (preset == 0) {
      rule = "||${fieldValue.trim()}^";
    }
    else if (preset == 1) {
      rule = "@@||${fieldValue.trim()}^";
    }
    else {
      rule = fieldValue.trim();
    }
    
    if (addImportant == true) {
      rule = "$rule\$important";
    }

    return rule;
  }

  void openDocsPage() {
    FlutterWebBrowser.openWebPage(
      url: Urls.customRuleDocs,
      customTabsOptions: const CustomTabsOptions(
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: false,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      )
    );
  } 
    
  @override
  Widget build(BuildContext context) {
    Map<int, Widget> presets = {
      0: Text(
        AppLocalizations.of(context)!.block,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
      ),
      1: Text(
        AppLocalizations.of(context)!.unblock,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
      ),
      2: Text(
        AppLocalizations.of(context)!.custom,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCustomRule),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: domainController,
              onChanged: (value) => setState(() => {}),
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
          MaterialSegmentedControl(
            children: presets,
            selectionIndex: preset,
            onSegmentChosen: (value) => setState(() => preset = value),
            selectedColor: Theme.of(context).colorScheme.secondaryContainer,
            unselectedColor: Colors.transparent,
            borderColor: Theme.of(context).colorScheme.onSurface,
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                        const SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.examples,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurface
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
              onTap: openDocsPage,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        AppLocalizations.of(context)!.moreInformation,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.open_in_new,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
        // Padding(
        //   padding: const EdgeInsets.only(
        //     left: 28,
        //     right: 28,
        //     top: 20,
        //     bottom: 28
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       TextButton(
        //         onPressed: () => Navigator.pop(context), 
        //         child: Text(AppLocalizations.of(context)!.cancel)
        //       ),
        //       const SizedBox(width: 20),
        //       TextButton(
        //         onPressed: checkValidValues() == true
        //           ? () {
        //               Navigator.pop(context);
        //               widget.onConfirm(buildRule());
        //             }
        //           : null, 
        //         child: Text(
        //           AppLocalizations.of(context)!.confirm,
        //           style: TextStyle(
        //             color: checkValidValues() == true
        //               ? Theme.of(context).primaryColor
        //               : Colors.grey
        //           ),
        //         )
        //       ),
        //     ],
        //   ),
        // )