import 'dart:io';

import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/models/filtering.dart';

class AddListModal extends StatelessWidget {
  final String type;
  final Filter? list;
  final void Function({required String name, required String url, required String type})? onConfirm;
  final void Function({required Filter list, required String type})? onEdit;
  final bool dialog;

  const AddListModal({
    super.key,
    required this.type,
    this.list,
    this.onConfirm,
    this.onEdit,
    required this.dialog
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
            list: list,
            onConfirm: onConfirm,
            onEdit: onEdit,
            type: type,
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
            color: Theme.of(context).dialogBackgroundColor
          ),
          child: SafeArea(
            child: _Content(
              list: list,
              onConfirm: onConfirm,
              onEdit: onEdit,
              type: type,
            ),
          )
        ),
      );
    }
  }
}

class _Content extends StatefulWidget {
  final String type;
  final Filter? list;
  final void Function({required String name, required String url, required String type})? onConfirm;
  final void Function({required Filter list, required String type})? onEdit;

  const _Content({
    required this.type,
    required this.list,
    required this.onConfirm,
    required this.onEdit,
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  String? urlError;

  bool validData = false;

  void checkValidValues() {
    if (nameController.text != '' && urlController.text != '') {
      setState(() => validData = true);
    }
    else {
      setState(() => validData = false);
    }
  }

  void validateUrl(String value) {
    if (Regexps.url.hasMatch(value)) {
      setState(() => urlError = null);
    }
    else {
      final pathRegex = RegExp(r'^(((\\|\/)[a-z0-9^&@{}\[\],$=!\-#\(\)%\.\+~_]+)*(\\|\/))([^\\\/:\*\<>\|]+\.[a-z0-9]+)$');
      if (pathRegex.hasMatch(value)) {
        setState(() => urlError = null);
      }
      else {
        setState(() => urlError = AppLocalizations.of(context)!.urlNotValid);
      }
    }
  }

  @override
  void initState() {
    if (widget.list != null) {
      nameController.text = widget.list!.name;
      urlController.text = widget.list!.url;

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
                            widget.type == 'whitelist'
                              ? Icons.verified_user_rounded
                              : Icons.gpp_bad_rounded,
                            size: 24,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.list != null
                            ? widget.type == 'whitelist'
                              ? AppLocalizations.of(context)!.editWhitelist
                              : AppLocalizations.of(context)!.editBlacklist
                            : widget.type == 'whitelist'
                              ? AppLocalizations.of(context)!.addWhitelist
                              : AppLocalizations.of(context)!.addBlacklist,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: nameController,
                    onChanged: (_) => checkValidValues(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.badge_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      labelText: AppLocalizations.of(context)!.name,
                    ),
                  ),
                ),
                Container(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: urlController,
                    onChanged: validateUrl,
                    enabled: widget.list != null ? false : true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.link_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      errorText: urlError,
                      labelText: AppLocalizations.of(context)!.urlAbsolutePath,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text(AppLocalizations.of(context)!.cancel)
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (widget.list != null) {
                    final Filter newList = Filter(
                      url: urlController.text,
                      name: nameController.text, 
                      lastUpdated: widget.list!.lastUpdated, 
                      id: widget.list!.id, 
                      rulesCount: widget.list!.rulesCount, 
                      enabled: widget.list!.enabled
                    );
                    widget.onEdit!(
                      list: newList,
                      type: widget.type
                    );
                  }
                  else {
                    widget.onConfirm!(
                      name: nameController.text,
                      url: urlController.text,
                      type: widget.type
                    );
                  }
                }, 
                child: Text(
                  widget.list != null
                    ? AppLocalizations.of(context)!.save
                    : AppLocalizations.of(context)!.confirm
                )
              ),
            ],
          ),
        ),
        if (Platform.isIOS) const SizedBox(height: 16)
      ],
    );
  }
}