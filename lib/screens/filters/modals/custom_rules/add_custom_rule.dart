import 'package:flutter/material.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/modals/custom_rules/custom_rule_docs.dart';

enum _BlockingPresets { block, unblock, custom }

class AddCustomRule extends StatefulWidget {
  final void Function(String) onConfirm;
  final bool fullScreen;

  const AddCustomRule({
    super.key,
    required this.onConfirm,
    required this.fullScreen
  });

  @override
  State<AddCustomRule> createState() => _AddCustomRuleState();
}

class _AddCustomRuleState extends State<AddCustomRule> {
  final TextEditingController _domainController = TextEditingController();
  String? _domainError;

  _BlockingPresets _preset = _BlockingPresets.block;

  bool _addImportant = false;

  bool _checkValidValues() {
    if (
      _domainController.text != '' && 
      _domainError == null
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
      setState(() => _domainError = null);
    }
    else {
      setState(() => _domainError = AppLocalizations.of(context)!.domainNotValid);
    }
    _checkValidValues();
  }
    
  @override
  Widget build(BuildContext context) {
    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(onPressed: () => Navigator.pop(context)),
            title: Text(AppLocalizations.of(context)!.addCustomRule),
            actions: [
              IconButton(
                onPressed: _checkValidValues() == true
                  ? () {
                      Navigator.pop(context);
                      widget.onConfirm(
                        _buildRule(
                          domainController: _domainController,
                          important: _addImportant,
                          preset: _preset
                        )
                      );
                    }
                  : null, 
                icon: const Icon(Icons.check)
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: [
                _CustomRuleEditor(
                  domainController: _domainController,
                  domainError: _domainError,
                  important: _addImportant,
                  preset: _preset,
                  setImportant: (v) => setState(() => _addImportant = v),
                  setPreset: (v) => setState(() => _preset = v),
                  validateDomain: validateDomain
                )
              ]
            ),
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
                      onPressed: _checkValidValues() == true
                        ? () {
                            Navigator.pop(context);
                            widget.onConfirm(
                              _buildRule(
                                domainController: _domainController,
                                important: _addImportant,
                                preset: _preset
                              )
                            );
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
                    children: [
                      _CustomRuleEditor(
                        domainController: _domainController,
                        domainError: _domainError,
                        important: _addImportant,
                        preset: _preset,
                        setImportant: (v) => setState(() => _addImportant = v),
                        setPreset: (v) => setState(() => _preset = v),
                        validateDomain: validateDomain
                      )
                    ]
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

class _CustomRuleEditor extends StatelessWidget {
  final TextEditingController domainController;
  final String? domainError;
  final bool important;
  final void Function(bool) setImportant;
  final _BlockingPresets preset;
  final void Function(_BlockingPresets) setPreset;
  final void Function(String) validateDomain;

  const _CustomRuleEditor({
    required this.domainController,
    required this.domainError,
    required this.important,
    required this.setImportant,
    required this.preset,
    required this.setPreset,
    required this.validateDomain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                _buildRule(
                  domainController: domainController,
                  important: important,
                  preset: preset,
                ),
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
        Container(height: 30),
        SegmentedButtonSlide(
          entries: [
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.block),
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.unblock),
            SegmentedButtonSlideEntry(label: AppLocalizations.of(context)!.custom),
          ], 
          selectedEntry: preset.index,
          onChange: (v) => setPreset(_BlockingPresets.values[v]), 
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
            onTap: () => setImportant(!important),
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
                    value: important, 
                    onChanged: setImportant,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(height: 20),
        const CustomRuleDocs(),
        Container(height: 20)
      ]
    );
  }
}

 String _buildRule({
  String? value,
  required TextEditingController domainController,
  required _BlockingPresets preset,
  required bool important
}) {
    String rule = "";
    String fieldValue = value ?? domainController.text;
    if (preset == _BlockingPresets.block) {
      rule = "||${fieldValue.trim()}^";
    }
    else if (preset == _BlockingPresets.unblock) {
      rule = "@@||${fieldValue.trim()}^";
    }
    else {
      rule = fieldValue.trim();
    }
    if (important == true) {
      rule = "$rule\$important";
    }
    return rule;
  }