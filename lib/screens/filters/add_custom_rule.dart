import 'package:flutter/material.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/urls.dart';

class AddCustomRule extends StatefulWidget {
  final void Function(String) onConfirm;
  final bool fullScreen;

  const AddCustomRule({
    Key? key,
    required this.onConfirm,
    required this.fullScreen
  }) : super(key: key);

  @override
  State<AddCustomRule> createState() => _AddCustomRuleState();
}

enum BlockingPresets { block, unblock, custom }

class _AddCustomRuleState extends State<AddCustomRule> {
  final TextEditingController domainController = TextEditingController();
  String? domainError;

  BlockingPresets preset = BlockingPresets.block;

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
    
    if (preset == BlockingPresets.block) {
      rule = "||${fieldValue.trim()}^";
    }
    else if (preset == BlockingPresets.unblock) {
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
    
  @override
  Widget build(BuildContext context) {

    List<Widget> content() {
      return [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
              child: Text(
                buildRule(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500
                ),
              )
            ),
          ],
        ),
        Container(height: 30),
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
        Container(height: 30),
        SegmentedButtonSlide(
          entries: [
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.block),
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.unblock),
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.custom),
          ], 
          selectedEntry: preset.index,
          onChange: (v) => setState(() => preset = BlockingPresets.values[v]), 
          colors: SegmentedButtonSlideColors(
            barColor: Theme.of(context).colorScheme.primary.withOpacity(0.2), 
            backgroundSelectedColor: Theme.of(context).colorScheme.primary, 
            foregroundSelectedColor: Theme.of(context).colorScheme.onPrimary, 
            foregroundUnselectedColor: Theme.of(context).colorScheme.onSurface, 
            hoverColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textOverflow: TextOverflow.ellipsis,
          fontSize: 14,
          height: 40,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
        ),
        Container(height: 20),
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
                  )
                ],
              ),
            ),
          ),
        ),
        Container(height: 20),
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
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "@@||example.org^",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example2,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "! Here goes a comment",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        Text(
                          "# Also a comment",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example3,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "/REGEX/",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example4,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
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
        Container(height: 20),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => openUrl(Urls.customRuleDocs),
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
        Container(height: 20)
      ];
    }

    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(onPressed: () => Navigator.pop(context)),
            title: Text(AppLocalizations.of(context)!.addCustomRule),
            actions: [
              IconButton(
                onPressed: checkValidValues() == true
                  ? () {
                      Navigator.pop(context);
                      widget.onConfirm(buildRule());
                    }
                  : null, 
                icon: const Icon(Icons.check)
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: ListView(
            children: content(),
          )
        ),
      );
    }
    else {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.addCustomRule,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: checkValidValues() == true
                        ? () {
                            Navigator.pop(context);
                            widget.onConfirm(buildRule());
                          }
                        : null, 
                      icon: const Icon(Icons.check)
                    )
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: content(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}