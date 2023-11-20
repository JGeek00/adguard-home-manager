// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/modals/add_custom_rule.dart';
import 'package:adguard_home_manager/screens/filters/details/add_list_modal.dart';

import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AddFiltersButton extends StatelessWidget {
  final String type;
  final Widget Function(void Function()) widget;

  const AddFiltersButton({
    Key? key,
    required this.type,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void confirmAddRule(String rule) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.addingRule);

      final result = await filteringProvider.addCustomRule(rule);

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleAddedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddCustomRule() {
      showGeneralDialog(
        context: context, 
        barrierColor: !(width > 700 || !(Platform.isAndroid || Platform.isIOS))
          ?Colors.transparent 
          : Colors.black54,
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1), 
              end: const Offset(0, 0)
            ).animate(
              CurvedAnimation(
                parent: anim1, 
                curve: Curves.easeInOutCubicEmphasized
              )
            ),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => AddCustomRule(
          fullScreen: !(width > 700 || !(Platform.isAndroid || Platform.isIOS)),
          onConfirm: confirmAddRule,
        ),
      );
    }

    void confirmAddList({required String name, required String url, required String type}) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.addingList);

      final result = await filteringProvider.addList(name: name, url: url, type: type);

      processModal.close();

      if (result['success'] == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: "${AppLocalizations.of(context)!.listAdded} ${result['data']}.", 
          color: Colors.green
        );
      }
      else if (result['success'] == false && result['error'] == 'invalid_url') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listUrlInvalid, 
          color: Colors.red
        );
      }
      else if (result['success'] == false && result['error'] == 'url_exists') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listAlreadyAdded, 
          color: Colors.red
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddWhitelistBlacklist() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (ctx) => AddListModal(
            type: type,
            onConfirm: confirmAddList,
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (ctx) => AddListModal(
            type: type,
            onConfirm: confirmAddList,
            dialog: false,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent
        );
      }
    }

    return widget(
      type == 'blacklist' || type == 'whitelist'
        ? () => openAddWhitelistBlacklist()
        : () => openAddCustomRule(),
    );
  }
}