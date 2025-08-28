import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/filters/modals/custom_rules/custom_rule_docs.dart';

import 'package:adguard_home_manager/providers/filtering_provider.dart';

class EditCustomRules extends StatefulWidget {
  final bool fullScreen;
  final void Function(List<String>) onConfirm;

  const EditCustomRules({
    super.key,
    required this.fullScreen,
    required this.onConfirm,
  });

  @override
  State<EditCustomRules> createState() => _EditCustomRulesState();
}

class _EditCustomRulesState extends State<EditCustomRules> {
  final _fieldController = TextEditingController();

  @override
  void initState() {
    final filteringProvider = Provider.of<FilteringProvider>(context, listen: false);
    if (filteringProvider.filtering != null) {
      _fieldController.text = filteringProvider.filtering!.userRules.join("\n");
    }

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Material(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar.large(
                  pinned: true,
                  floating: true,
                  centerTitle: false,
                  forceElevated: innerBoxIsScrolled,
                  leading: CloseButton(onPressed: () => Navigator.pop(context)),
                  title: Text(AppLocalizations.of(context)!.editCustomRules),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onConfirm(_fieldController.text.split("\n"));
                      },
                      icon: const Icon(Icons.save_rounded),
                      tooltip: AppLocalizations.of(context)!.save,
                    ),
                    const SizedBox(width: 10)
                  ],
                )
              )
            ], 
            body: SafeArea(
              top: false,
              bottom: true,
              child: Builder(
                builder: (context) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverList.list(
                      children: [
                        _CustomRulesRawEditor(fieldController: _fieldController)
                      ] 
                    )
                  ],
                ),
              )
            )
          ),
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
                          AppLocalizations.of(context)!.editCustomRules,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onConfirm(_fieldController.text.split("\n"));
                      }, 
                      icon: const Icon(Icons.save_rounded),
                      tooltip: AppLocalizations.of(context)!.save,
                    )
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      _CustomRulesRawEditor(fieldController: _fieldController)
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

class _CustomRulesRawEditor extends StatelessWidget {
  final TextEditingController fieldController;

  const _CustomRulesRawEditor({
    required this.fieldController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: TextField(
              controller: fieldController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                labelText: AppLocalizations.of(context)!.rules,
                floatingLabelBehavior: FloatingLabelBehavior.always
              ),
              autocorrect: false,
              expands: true,
              minLines: null,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const CustomRuleDocs(),
        const SizedBox(height: 16),
      ],
    );
  }
}