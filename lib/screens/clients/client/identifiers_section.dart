import 'package:adguard_home_manager/screens/clients/client/client_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/section_label.dart';

class IdentifiersSection extends StatefulWidget {
  final List<ControllerListItem> identifiersControllers;
  final void Function(List<ControllerListItem>) onUpdateIdentifiersControllers;
  final void Function() onCheckValidValues;

  const IdentifiersSection({
    super.key,
    required this.identifiersControllers,
    required this.onUpdateIdentifiersControllers,
    required this.onCheckValidValues
  });

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
                left: 16, right: 16, top: 24, bottom: 12
              )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () => widget.onUpdateIdentifiersControllers([
                  ...widget.identifiersControllers,
                  ControllerListItem(
                    id: uuid.v4(), 
                    controller: TextEditingController()
                  ),
                ]),
                icon: const Icon(Icons.add)
              ),
            )
          ],
        ),
        if (widget.identifiersControllers.isNotEmpty) ...widget.identifiersControllers.map((controller) => Padding(
          padding: const EdgeInsets.only(
            top: 12, bottom: 12, left: 16, right: 10
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.controller,
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
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: IconButton(
                  onPressed: () => widget.onUpdateIdentifiersControllers(
                    widget.identifiersControllers.where((e) => e.id != controller.id).toList()
                  ),
                  icon: const Icon(Icons.remove_circle_outline_outlined)
                ),
              )
            ],
          ),
        )),
        if (widget.identifiersControllers.isEmpty) Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
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