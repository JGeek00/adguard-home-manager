import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';

class IdentifiersSection extends StatefulWidget {
  final List<Map<dynamic, dynamic>> identifiersControllers;
  final void Function(List<Map<dynamic, dynamic>>) onUpdateIdentifiersControllers;
  final void Function() onCheckValidValues;

  const IdentifiersSection({
    Key? key,
    required this.identifiersControllers,
    required this.onUpdateIdentifiersControllers,
    required this.onCheckValidValues
  }) : super(key: key);

  @override
  State<IdentifiersSection> createState() => _IdentifiersSectionState();
}

class _IdentifiersSectionState extends State<IdentifiersSection> {
  final Uuid uuid = const Uuid();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionLabel(
              label: AppLocalizations.of(context)!.identifiers,
              padding: const  EdgeInsets.only(
                left: 24, right: 24, top: 24, bottom: 12
              )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => widget.onUpdateIdentifiersControllers([
                  ...widget.identifiersControllers,
                  Map<String, Object>.from({
                    'id': uuid.v4(),
                    'controller': TextEditingController()
                  })
                ]),
                icon: const Icon(Icons.add)
              ),
            )
          ],
        ),
        if (widget.identifiersControllers.isNotEmpty) ...widget.identifiersControllers.map((controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller['controller'],
                  onChanged: (_) => widget.onCheckValidValues(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.tag),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    helperText: AppLocalizations.of(context)!.identifierHelper,
                    labelText: AppLocalizations.of(context)!.identifier,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: IconButton(
                  onPressed: () => widget.onUpdateIdentifiersControllers(
                    widget.identifiersControllers.where((e) => e['id'] != controller['id']).toList()
                  ),
                  icon: const Icon(Icons.remove_circle_outline_outlined)
                ),
              )
            ],
          ),
        )).toList(),
        if (widget.identifiersControllers.isEmpty) Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context)!.noIdentifiers,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}