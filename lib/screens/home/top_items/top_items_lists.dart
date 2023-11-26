import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items/top_items.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class TopItemsLists extends StatelessWidget {
  final List<HomeTopItems> order;
  
  const TopItemsLists({
    super.key, 
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    List<Widget> bottom = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
      ),
      const SizedBox(height: 16),
    ];

    void filterDomainLogs({required String value}) {
      logsProvider.setSearchText(value);
      logsProvider.setSelectedClients(null);
      logsProvider.setAppliedFilters(
        AppliedFiters(
          selectedResultStatus: 'all', 
          searchText: value,
          clients: null
        )
      );
      appConfigProvider.setSelectedScreen(2);
    }

    void filterClientLogs({required String value}) {
      logsProvider.setSearchText(null);
      logsProvider.setSelectedClients([value]);
      logsProvider.setAppliedFilters(
        AppliedFiters(
          selectedResultStatus: 'all', 
          searchText: null,
          clients: [value]
        )
      );
      appConfigProvider.setSelectedScreen(2);
    }

    void blockUnblock({required String domain, required String newStatus}) async {
      final ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingUserFilters);

      final rules = await statusProvider.blockUnblockDomain(
        domain: domain,
        newStatus: newStatus
      );

      processModal.close();

      if (!context.mounted) return;
      if (rules == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesNotUpdated, 
          color: Colors.red
        );
      }
    }

    void copyValueClipboard(value) {
      copyToClipboard(value: value, successMessage: AppLocalizations.of(context)!.copiedClipboard);
    }

    return Column(
      children: order.asMap().entries.map((item) {
        switch (item.value) {
          case HomeTopItems.queriedDomains:
            return Column(
              children: [
                TopItems(
                  label: AppLocalizations.of(context)!.topQueriedDomains, 
                  type: HomeTopItems.queriedDomains,
                  data: statusProvider.serverStatus?.stats.topQueriedDomains ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: [
                    MenuOption(
                      title: AppLocalizations.of(context)!.blockDomain,
                      icon: Icons.block_rounded, 
                      action: (v) => blockUnblock(domain: v.toString(), newStatus: 'block')
                    ),
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: copyValueClipboard
                    ),
                  ],
                  onTapEntry: (v) => filterDomainLogs(value: v.toString()),
                ),
                if (item.key < order.length - 1) ...bottom
              ],
            );
             
          case HomeTopItems.blockedDomains:
            return Column(
              children: [
                TopItems(
                  label: AppLocalizations.of(context)!.topBlockedDomains, 
                  type: HomeTopItems.blockedDomains,
                  data: statusProvider.serverStatus?.stats.topBlockedDomains ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: [
                    MenuOption(
                      title: AppLocalizations.of(context)!.unblockDomain,
                      icon: Icons.check_rounded, 
                      action: (v) => blockUnblock(domain: v, newStatus: 'unblock')
                    ),
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: copyValueClipboard
                    )
                  ],
                  onTapEntry: (v) => filterDomainLogs(value: v),
                ),
                if (item.key < order.length - 1) ...bottom
              ],
            );
                  
          case HomeTopItems.recurrentClients:
            return Column(
              children: [
                TopItems(
                  label: AppLocalizations.of(context)!.topClients, 
                  type: HomeTopItems.recurrentClients,
                  data: statusProvider.serverStatus?.stats.topClients ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: [
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: copyValueClipboard
                    )
                  ],
                  onTapEntry: (v) => filterClientLogs(value: v),
                ),
                if (item.key < order.length - 1) ...bottom
              ],
            );

          case HomeTopItems.topUpstreams:
            return statusProvider.serverStatus!.stats.topUpstreamResponses != null
              ? Column(
                  children: [
                    TopItems(
                      label: AppLocalizations.of(context)!.topUpstreams, 
                      type: HomeTopItems.topUpstreams,
                      data: statusProvider.serverStatus?.stats.topUpstreamResponses ?? [],
                      withChart: true,
                      withProgressBar: true,
                      buildValue: (v) => v.toString(),
                      menuOptions: [
                        MenuOption(
                          title: AppLocalizations.of(context)!.copyClipboard,
                          icon: Icons.copy_rounded, 
                          action: copyValueClipboard
                        )
                      ],
                    ),
                    if (item.key < order.length - 1) ...bottom
                  ],
                )
              : const SizedBox();

          case HomeTopItems.avgUpstreamResponseTime:
            return statusProvider.serverStatus!.stats.topUpstreamsAvgTime != null 
              ? Column(
                  children: [
                    TopItems(
                      label: AppLocalizations.of(context)!.averageUpstreamResponseTime, 
                      type: HomeTopItems.avgUpstreamResponseTime,
                      data: statusProvider.serverStatus?.stats.topUpstreamsAvgTime ?? [],
                      withChart: false,
                      withProgressBar: false,
                      buildValue: (v) => "${doubleFormat(v*1000, Platform.localeName)} ms",
                      menuOptions: [
                        MenuOption(
                          title: AppLocalizations.of(context)!.copyClipboard,
                          icon: Icons.copy_rounded, 
                          action: copyValueClipboard
                        )
                      ],
                    ),
                    if (item.key < order.length - 1) ...bottom
                  ],
                ) 
              : const SizedBox();
                
          default:
            return const SizedBox();
        }
      }).toList(),
    );
  }
}