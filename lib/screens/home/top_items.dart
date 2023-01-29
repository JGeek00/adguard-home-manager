// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items_options_modal.dart';
import 'package:adguard_home_manager/screens/top_items/top_items.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
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
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

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
        FilteringStatus oldStatus = serversProvider.serverStatus.data!.filteringStatus;

        List<String> newRules = rules['data'].userRules.where((d) => !d.contains(domain)).toList();
        if (newStatus == 'block') {
          newRules.add("||$domain^");
        }
        else if (newStatus == 'unblock') {
          newRules.add("@@||$domain^");
        }
        FilteringStatus newObj = serversProvider.serverStatus.data!.filteringStatus;
        newObj.userRules = newRules;
        serversProvider.setFilteringStatus(newObj);

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
          serversProvider.setFilteringStatus(oldStatus);
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

    void openOptionsModal(String domain) {
      showDialog(
        context: context, 
        builder: (context) => TopItemsOptionsModal(
          isBlocked: getIsBlocked(),
          changeStatus: (String status) => blockUnblock(domain, status),
          copyToClipboard: () => copyDomainClipboard(domain),
        )
      );
    }

    Widget rowItem(Map<String, dynamic> item) {
      String? name;
      if (clients != null && clients == true) {
        try {
          name = serversProvider.serverStatus.data!.clients.firstWhere((c) => c.ids.contains(item.keys.toList()[0])).name;
        } catch (e) {
          // ---- //
        }
      }

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: type == 'topQueriedDomains' || type == 'topBlockedDomains' 
            ?() {
                logsProvider.setSearchText(item.keys.toList()[0]);
                logsProvider.setAppliedFilters(
                  AppliedFiters(
                    selectedResultStatus: 'all', 
                    searchText: item.keys.toList()[0]
                  )
                );
                appConfigProvider.setSelectedScreen(2);
              }
            : null,
          onLongPress: type == 'topQueriedDomains' || type == 'topBlockedDomains'
            ? () => openOptionsModal(item.keys.toList()[0])
            : null,
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
          return serversProvider.serverStatus.data!.stats.topQueriedDomains;
          
        case 'topBlockedDomains':
          return serversProvider.serverStatus.data!.stats.topBlockedDomains;

        case 'topClients':
          return serversProvider.serverStatus.data!.stats.topClients;

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
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TopItemsScreen(
                          type: type,
                          title: label,
                          isClient: clients,
                          data: generateData(),
                        )
                      )
                    ),
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