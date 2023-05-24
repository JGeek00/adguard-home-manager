// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/options_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/menu_option.dart';

class DomainOptions extends StatelessWidget {
  final bool isBlocked;
  final bool? isClient;
  final String? item;
  final Widget child;
  final void Function() onTap;
  final BorderRadius? borderRadius;

  const DomainOptions({
    Key? key,
    required this.isBlocked,
    this.isClient,
    required this.item,
    required this.child,
    required this.onTap,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void blockUnblock(String domain, String newStatus) async {
      final ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingUserFilters);

      final rules = await getFilteringRules(server: serversProvider.selectedServer!);

      if (rules['result'] == 'success') {
        FilteringStatus oldStatus = statusProvider.serverStatus!.filteringStatus;

        List<String> newRules = rules['data'].userRules.where((d) => !d.contains(domain)).toList();
        if (newStatus == 'block') {
          newRules.add("||$domain^");
        }
        else if (newStatus == 'unblock') {
          newRules.add("@@||$domain^");
        }
        FilteringStatus newObj = statusProvider.serverStatus!.filteringStatus;
        newObj.userRules = newRules;
        statusProvider.setFilteringStatus(newObj);

        final result  = await postFilteringRules(server: serversProvider.selectedServer!, data: {'rules': newRules});
        
        processModal.close();
        
        if (result['result'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.userFilteringRulesUpdated),
              backgroundColor: Colors.green,
            )
          );
        }
        else {
          appConfigProvider.addLog(result['log']);
          statusProvider.setFilteringStatus(oldStatus);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.userFilteringRulesNotUpdated),
              backgroundColor: Colors.red,
            )
          );
        }
      }
      else {
        appConfigProvider.addLog(rules['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.userFilteringRulesNotUpdated),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void copyDomainClipboard(String domain) async {
      await Clipboard.setData(
        ClipboardData(text: domain)
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.domainCopiedClipboard),
          backgroundColor: Colors.green,
        )
      );
    }

    List<MenuOption> generateOptions() {
      return [
        if (isClient != true && isBlocked == true) MenuOption(
          title: AppLocalizations.of(context)!.unblock, 
          icon: Icons.check,
          action: () => blockUnblock(item!, 'unblock')
        ),
        if (isClient != true && isBlocked == false) MenuOption(
          title: AppLocalizations.of(context)!.block, 
          icon: Icons.block,
          action: () => blockUnblock(item!, 'block')
        ),
        MenuOption(
          title: AppLocalizations.of(context)!.copyClipboard, 
          icon: Icons.copy,
          action: () => copyDomainClipboard(item!)
        ),
      ];
    }

    void openOptionsModal() {
      showDialog(
        context: context, 
        builder: (context) => OptionsModal(
          options: generateOptions(),
        )
      );
    }

    if (item != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: ContextMenuArea(
          builder: (context) => generateOptions().map((opt) => CustomListTile(
            title: opt.title,
            icon: opt.icon,
            onTap: () {
              opt.action();
              Navigator.pop(context);
            },
          )).toList(),
          child: InkWell(
            onTap: onTap,
            onLongPress: openOptionsModal,
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      );
    }
    else {
      return child;
    }
  }
}