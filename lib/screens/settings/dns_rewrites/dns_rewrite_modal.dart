import 'dart:io';

import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/models/rewrite_rules.dart';

class DnsRewriteModal extends StatelessWidget {
  final void Function(RewriteRules newRule, RewriteRules? previousRule) onConfirm;
  final bool dialog;
  final RewriteRules? rule;
  final void Function(RewriteRules) onDelete;

  const DnsRewriteModal({
    super.key,
    required this.onConfirm,
    required this.dialog,
    this.rule,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    if (dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: _Content(
            onConfirm: onConfirm,
            onDelete: onDelete,
            rule: rule,
          )
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            ),
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: SafeArea(
            child: _Content(
              onConfirm: onConfirm,
              onDelete: onDelete,
              rule: rule,
            ),
          )
        ),
      );
    }
  }
}

class _Content extends StatefulWidget {
  final void Function(RewriteRules newRule, RewriteRules? previousRule) onConfirm;
  final RewriteRules? rule;
  final void Function(RewriteRules) onDelete;

  const _Content({
    required this.onConfirm,
    this.rule,
    required this.onDelete
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController domainController = TextEditingController();
  String? domainError;
  final TextEditingController answerController = TextEditingController();

  bool validData = false;

  void validateDomain(String value) {
    if (Regexps.wildcardDomain.hasMatch(value)) {
      setState(() => domainError = null);
    }
    else {
      setState(() => domainError = AppLocalizations.of(context)!.domainNotValid);
    }
    checkValidValues();
  }

  void checkValidValues() {
    if (
      domainController.text != '' &&
      domainError == null &&
      answerController.text != ''
    ) {
      setState(() => validData = true);
    }
    else {
      setState(() => validData = false);
    }
  }

  @override
  void initState() {
    if (widget.rule != null) {
      domainController.text = widget.rule!.domain;
      answerController.text = widget.rule!.answer;
      validData = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Icon(
                            widget.rule != null
                              ? Icons.edit
                              : Icons.add,
                            size: 24,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.rule != null
                            ? AppLocalizations.of(context)!.editRewriteRule
                            : AppLocalizations.of(context)!.addDnsRewrite,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 12
                  ),
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 12
                  ),
                  child: TextFormField(
                    controller: answerController,
                    onChanged: (_) => checkValidValues(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.system_update_alt_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      labelText: AppLocalizations.of(context)!.answer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.rule != null) TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onDelete(
                    RewriteRules(
                      domain: domainController.text, 
                      answer: answerController.text,
                      enabled: true,
                    )
                  );
                },
                child: Text(AppLocalizations.of(context)!.delete),
              ),
              if (widget.rule == null) const SizedBox(),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: validData == true
                      ? () {
                          Navigator.pop(context);
                          widget.onConfirm(
                            RewriteRules(
                              domain: domainController.text, 
                              answer: answerController.text,
                              enabled: true,
                            ),
                            widget.rule
                          );
                        }
                      : null,
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(
                        color: validData == true
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        if (Platform.isIOS) const SizedBox(height: 16)
      ],
    );
  }
}