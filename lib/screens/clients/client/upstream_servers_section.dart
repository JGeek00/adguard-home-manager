import 'package:adguard_home_manager/screens/clients/client/client_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';

class UpstreamServersSection extends StatefulWidget {
  final List<ControllerListItem> upstreamServers;
  final void Function() onCheckValidValues;
  final void Function(List<ControllerListItem>) onUpdateUpstreamServers;

  const UpstreamServersSection({
    Key? key,
    required this.upstreamServers,
    required this.onCheckValidValues,
    required this.onUpdateUpstreamServers
  }) : super(key: key);

  @override
  State<UpstreamServersSection> createState() => _UpstreamServersSectionState();
}

class _UpstreamServersSectionState extends State<UpstreamServersSection> {
  final Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionLabel(
              label: AppLocalizations.of(context)!.upstreamServers,
              padding: const EdgeInsets.all(24),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => setState(() => widget.upstreamServers.add(
                  ControllerListItem(
                    id: uuid.v4(), 
                    controller: TextEditingController()
                  )
                )),
                icon: const Icon(Icons.add)
              ),
            )
          ],
        ),
        if (widget.upstreamServers.isNotEmpty) ...widget.upstreamServers.map((controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.controller,
                    onChanged: (_) => widget.onCheckValidValues,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.dns_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      labelText: AppLocalizations.of(context)!.serverAddress,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => widget.onUpdateUpstreamServers(
                    widget.upstreamServers.where((e) => e.id != controller.id).toList()
                  ),
                  icon: const Icon(Icons.remove_circle_outline_outlined)
                )
              ],
            ),
          ),
        )).toList(),
        if (widget.upstreamServers.isEmpty) Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.noUpstreamServers,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.willBeUsedGeneralServers,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}