// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/management_modal/main_switch.dart';
import 'package:adguard_home_manager/screens/home/management_modal/small_switch.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ManagementModal extends StatefulWidget {
  final bool dialog;

  const ManagementModal({
    Key? key,
    required this.dialog
  }) : super(key: key);

  @override
  State<ManagementModal> createState() => _ManagementModalState();
}

class _ManagementModalState extends State<ManagementModal> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final ExpandableController expandableController = ExpandableController();

  @override
  void initState() {
    expandableController.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (expandableController.value == false) {
        animationController.animateTo(0);
      }
      else {
        animationController.animateBack(1);
      }
    });

    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )
    ..addListener(() => setState(() => {}));
    animation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut
    ));
    
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void updateBlocking({
      required bool value, 
      required String filter,
      int? time
    }) async {
      final result = await statusProvider.updateBlocking(
        block: filter, 
        newStatus: value,
        time: time
      );
      if (mounted && result != null) {
        if (result != false) {
          appConfigProvider.addLog(result);
        }
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.invalidUsernamePassword, 
          color: Colors.red
        );
      }
    }

    void disableWithCountdown(int time) async {
      updateBlocking(value: false, filter: 'general', time: time);
      expandableController.toggle();
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: _Modal(
                    expandableController: expandableController,
                    updateBlocking: updateBlocking,
                    disableWithCountdown: disableWithCountdown,
                    animation: animation,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text(AppLocalizations.of(context)!.close),
                    ),
                  ],
                ),
              ),
              if (Platform.isIOS) const SizedBox(height: 16)
            ],
          ),
        ),
      );
    }
    else {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: _Modal(
                  expandableController: expandableController,
                  updateBlocking: updateBlocking,
                  disableWithCountdown: disableWithCountdown,
                  animation: animation,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text(AppLocalizations.of(context)!.close),
                  ),
                ],
              ),
            ),
            if (Platform.isIOS) const SizedBox(height: 16)
          ],
        ),
      );
    }
  }
}

class _Modal extends StatelessWidget {
  final ExpandableController expandableController;
  final void Function({ required bool value, required String filter }) updateBlocking;
  final void Function(int) disableWithCountdown;
  final Animation<double> animation;

  const _Modal({
    Key? key,
    required this.expandableController,
    required this.updateBlocking,
    required this.disableWithCountdown,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return Wrap(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Icon(
                  Icons.shield_rounded,
                  size: 24,
                  color: Theme.of(context).listTileTheme.iconColor
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  AppLocalizations.of(context)!.manageServer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              ],
            ),
          ],
        ),

        MainSwitch(
          expandableController: expandableController,
          updateBlocking: updateBlocking,
          disableWithCountdown: disableWithCountdown,
          animation: animation,
        ),
        Container(height: 10),
        SmallSwitch(
          label: AppLocalizations.of(context)!.ruleFiltering,
          icon: Icons.filter_list_rounded,
          value: statusProvider.serverStatus!.filteringEnabled, 
          onChange: (value) => updateBlocking(value: value, filter: 'filtering'),
          disabled: statusProvider.protectionsManagementProcess.contains('filtering')
        ),
        SmallSwitch(
          label: AppLocalizations.of(context)!.safeBrowsing,
          icon: Icons.vpn_lock_rounded,
          value: statusProvider.serverStatus!.safeBrowsingEnabled, 
          onChange: (value) => updateBlocking(value: value, filter: 'safeBrowsing'),
          disabled: statusProvider.protectionsManagementProcess.contains('safeBrowsing')
        ),
        SmallSwitch(
          label: AppLocalizations.of(context)!.parentalFiltering,
          icon: Icons.block,
          value: statusProvider.serverStatus!.parentalControlEnabled, 
          onChange: (value) => updateBlocking(value: value, filter: 'parentalControl'),
          disabled: statusProvider.protectionsManagementProcess.contains('parentalControl')
        ),
        SmallSwitch(
          label: AppLocalizations.of(context)!.safeSearch,
          icon: Icons.search_rounded,
          value: statusProvider.serverStatus!.safeSearchEnabled, 
          onChange: (value) => updateBlocking(value: value, filter: 'safeSearch'),
          disabled: statusProvider.protectionsManagementProcess.contains('safeSearch')
        ),
      ],
    );
  }
}
