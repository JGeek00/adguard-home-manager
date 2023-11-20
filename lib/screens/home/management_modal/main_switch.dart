import 'dart:io';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class MainSwitch extends StatelessWidget {
  final ExpandableController expandableController;
  final void Function({ required bool value, required String filter }) updateBlocking;
  final void Function(int) disableWithCountdown;
  final Animation<double> animation;

  const MainSwitch({
    Key? key,
    required this.expandableController,
    required this.updateBlocking,
    required this.disableWithCountdown,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ExpandableNotifier(
        controller: expandableController,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: statusProvider.serverStatus!.generalEnabled == true && !statusProvider.protectionsManagementProcess.contains('general')
              ? () => expandableController.toggle()
              : null,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
              ),
              child: Expandable(
                theme: const ExpandableThemeData(
                  animationDuration: Duration(milliseconds: 200),
                  fadeCurve: Curves.ease
                ),
                collapsed: _TopRow(
                  legacyMode: false,
                  expandableController: expandableController,
                  updateBlocking: updateBlocking,
                  animation: animation,
                ), 
                expanded: Column(
                  children: [
                    _TopRow(
                      legacyMode: false,
                      expandableController: expandableController,
                      updateBlocking: updateBlocking,
                      animation: animation,
                    ),
                    _BottomRow(
                      disableWithCountdown: disableWithCountdown,
                    ),
                    const SizedBox(height: 8)
                  ],
                )
              ),
            ),
          ),
        )
      ) 
    );
  }
}

class _TopRow extends StatelessWidget {
  final bool legacyMode;
  final ExpandableController expandableController;
  final void Function({ required bool value, required String filter }) updateBlocking;
  final Animation<double> animation;

  const _TopRow({
    Key? key,
    required this.legacyMode,
    required this.expandableController,
    required this.updateBlocking,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (legacyMode == false) ...[
              RotationTransition(
                turns: animation,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 26,
                  color: statusProvider.serverStatus!.generalEnabled == true
                    ? Theme.of(context).colorScheme.onSurfaceVariant
                    : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.allProtections,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                if (statusProvider.serverStatus!.timeGeneralDisabled > 0) ...[
                  const SizedBox(height: 2),
                  if (statusProvider.currentDeadline != null) Text(
                    "${AppLocalizations.of(context)!.remainingTime}: ${formatRemainingSeconds(statusProvider.remainingTime)}"
                  )
                ]
              ],
            ),
          ],
        ),
        Switch(
          value: statusProvider.serverStatus!.generalEnabled, 
          onChanged: statusProvider.protectionsManagementProcess.contains('general') == false
            ? (value) {
              if (value == false && expandableController.expanded == true && legacyMode == false) {
                expandableController.toggle();
              }
              updateBlocking(
                value: value, 
                filter: legacyMode == true ? 'general_legacy' : 'general'
              );
            } : null,
        )
      ]
    );
  }
}

class _BottomRow extends StatefulWidget {
  final void Function(int) disableWithCountdown;
  
  const _BottomRow({
    Key? key,
    required this.disableWithCountdown,
  }) : super(key: key);

  @override
  State<_BottomRow> createState() => _BottomRowState();
}

class _BottomRowState extends State<_BottomRow> {
  final _chipsScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return Container(
      height: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 50 : 40,
      margin: const EdgeInsets.only(top: 8),
      child: Scrollbar(
        controller: _chipsScrollController,
        thumbVisibility: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
        interactive: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
        thickness: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 8 : 0,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 16 : 0
          ),
          child: ListView(
            controller: _chipsScrollController,
            scrollDirection: Axis.horizontal,
            children: [
              ActionChip(
                label: Text(AppLocalizations.of(context)!.seconds(30)),
                onPressed: statusProvider.protectionsManagementProcess.contains('general') == false && statusProvider.serverStatus!.generalEnabled == true
                  ? () => widget.disableWithCountdown(29000)
                  : null,
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: Text(AppLocalizations.of(context)!.minute(1)),
                onPressed: statusProvider.protectionsManagementProcess.contains('general') == false && statusProvider.serverStatus!.generalEnabled == true
                  ? () => widget.disableWithCountdown(59000)
                  : null,
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: Text(AppLocalizations.of(context)!.minutes(10)),
                onPressed: statusProvider.protectionsManagementProcess.contains('general') == false && statusProvider.serverStatus!.generalEnabled == true
                  ? () => widget.disableWithCountdown(599000)
                  : null,
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: Text(AppLocalizations.of(context)!.hour(1)),
                onPressed: statusProvider.protectionsManagementProcess.contains('general') == false && statusProvider.serverStatus!.generalEnabled == true
                  ? () => widget.disableWithCountdown(3599000)
                  : null,
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: Text(AppLocalizations.of(context)!.hours(24)),
                onPressed: statusProvider.protectionsManagementProcess.contains('general') == false && statusProvider.serverStatus!.generalEnabled == true
                  ? () => widget.disableWithCountdown(86399000)
                  : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}