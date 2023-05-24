// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/domain_options.dart';
import 'package:adguard_home_manager/screens/top_items/top_items_modal.dart';
import 'package:adguard_home_manager/widgets/options_modal.dart';
import 'package:adguard_home_manager/screens/top_items/top_items.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
class TopItems extends StatelessWidget {
  final String type;
  final String label;
  final List<Map<String, dynamic>> data;
  final bool? clients;

  const TopItems({
    Key? key,
    required this.type,
    required this.label,
    required this.data,
    this.clients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    bool? getIsBlocked() {
      if (type == 'topBlockedDomains') {
        return true;
      }
      else if (type == 'topQueriedDomains') {
        return false;
      }
      else {
        return null;
      }
    }

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

    List<MenuOption> generateOptions(String domain) {
      final isBlocked = getIsBlocked();
      return [
        if (isBlocked == true) MenuOption(
          title: AppLocalizations.of(context)!.unblock, 
          icon: Icons.check,
          action: () => blockUnblock(domain, 'unblock')
        ),
        if (isBlocked == false) MenuOption(
          title: AppLocalizations.of(context)!.block, 
          icon: Icons.check,
          action: () => blockUnblock(domain, 'block')
        ),
        MenuOption(
          title: AppLocalizations.of(context)!.copyClipboard, 
          icon: Icons.check,
          action: () => copyDomainClipboard(domain)
        ),
      ];
    }

    void openOptionsModal(String domain, String type) {
      showDialog(
        context: context, 
        builder: (context) => OptionsModal(
          options: generateOptions(domain),
        )
      );
    }

    Widget rowItem(Map<String, dynamic> item) {
      String? name;
      if (clients != null && clients == true) {
        try {
          name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(item.keys.toList()[0])).name;
        } catch (e) {
          // ---- //
        }
      }

      return Material(
        color: Colors.transparent,
        child: DomainOptions(
          item: item.keys.toList()[0],
          isClient: type == 'topClients',
          isBlocked: type == 'topBlockedDomains',
          onTap: () {
            if (type == 'topQueriedDomains' || type == 'topBlockedDomains') {
              logsProvider.setSearchText(item.keys.toList()[0]);
              logsProvider.setSelectedClients(null);
              logsProvider.setAppliedFilters(
                AppliedFiters(
                  selectedResultStatus: 'all', 
                  searchText: item.keys.toList()[0],
                  clients: null
                )
              );
              appConfigProvider.setSelectedScreen(2);
            }
            else if (type == 'topClients') {
              logsProvider.setSearchText(null);
              logsProvider.setSelectedClients([item.keys.toList()[0]]);
              logsProvider.setAppliedFilters(
                AppliedFiters(
                  selectedResultStatus: 'all', 
                  searchText: null,
                  clients: [item.keys.toList()[0]]
                )
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.keys.toList()[0],
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      if (name != null) ...[
                        const SizedBox(height: 5),
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                Text(
                  item.values.toList()[0].toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    List<Map<String, dynamic>> generateData() {
      switch (type) {
        case 'topQueriedDomains':
          return statusProvider.serverStatus!.stats.topQueriedDomains;
          
        case 'topBlockedDomains':
          return statusProvider.serverStatus!.stats.topBlockedDomains;

        case 'topClients':
          return statusProvider.serverStatus!.stats.topClients;

        default:
          return [];
      }
    }

    return SizedBox(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          const SizedBox(height: 20),
          if (data.isEmpty) Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 10
            ),
            child: Text(
              AppLocalizations.of(context)!.noItems,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (data.isNotEmpty) rowItem(data[0]),
          if (data.length >= 2) rowItem(data[1]),
          if (data.length >= 3) rowItem(data[2]),
          if (data.length >= 4) rowItem(data[3]),
          if (data.length >= 5) rowItem(data[4]),
          if (data.length > 5) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {
                      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => TopItemsModal(
                            type: type,
                            title: label,
                            isClient: clients,
                            data: generateData(),
                          )
                        )
                      }
                      else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TopItemsScreen(
                              type: type,
                              title: label,
                              isClient: clients,
                              data: generateData(),
                            )
                          )
                        )
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.viewMore),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ]
        ],
      ),
    );
  }
}