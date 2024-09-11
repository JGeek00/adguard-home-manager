import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items/top_items_section.dart';

import 'package:adguard_home_manager/providers/clients_provider.dart';
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
    final clientsProvider = Provider.of<ClientsProvider>(context);

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
          clients: []
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
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesNotUpdated, 
          color: Colors.red
        );
      }
    }

    void copyValueClipboard(dynamic value) {
      copyToClipboard(value: value, successMessage: AppLocalizations.of(context)!.copiedClipboard);
    }

    void blockUnblockClient(dynamic client) async {
      final currentList = clientsProvider.checkClientList(client);
      final newList = currentList == AccessSettingsList.allowed || currentList == null
        ? AccessSettingsList.disallowed
        : AccessSettingsList.allowed;

      ProcessModal processModal = ProcessModal();
      processModal.open(
        currentList == AccessSettingsList.allowed || currentList == null
          ? AppLocalizations.of(context)!.blockingClient
          : AppLocalizations.of(context)!.unblockingClient
      );

      final result = await clientsProvider.addClientList(client, newList);
      if (!context.mounted) return;

      processModal.close();

      if (result.successful == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientAddedSuccessfully, 
          color: Colors.green
        );
      }
      else if (result.successful == false && result.content == 'client_another_list') {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientAnotherList, 
          color: Colors.red
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: newList == AccessSettingsList.allowed || newList == AccessSettingsList.disallowed
            ? AppLocalizations.of(context)!.clientNotRemoved
            : AppLocalizations.of(context)!.domainNotAdded,
          color: Colors.red
        );
      }
    }

    return Column(
      children: order.asMap().entries.map((item) {
        switch (item.value) {
          case HomeTopItems.queriedDomains:
            return Column(
              children: [
                TopItemsSection(
                  label: AppLocalizations.of(context)!.topQueriedDomains, 
                  type: HomeTopItems.queriedDomains,
                  data: statusProvider.serverStatus?.stats.topQueriedDomains ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: (v) => [
                    MenuOption(
                      title: AppLocalizations.of(context)!.blockDomain,
                      icon: Icons.block_rounded, 
                      action: () => blockUnblock(domain: v.toString(), newStatus: 'block')
                    ),
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: () => copyValueClipboard(v)
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
                TopItemsSection(
                  label: AppLocalizations.of(context)!.topBlockedDomains, 
                  type: HomeTopItems.blockedDomains,
                  data: statusProvider.serverStatus?.stats.topBlockedDomains ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: (v) => [
                    MenuOption(
                      title: AppLocalizations.of(context)!.unblockDomain,
                      icon: Icons.check_rounded, 
                      action: () => blockUnblock(domain: v, newStatus: 'unblock')
                    ),
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: () => copyValueClipboard(v)
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
                TopItemsSection(
                  label: AppLocalizations.of(context)!.topClients, 
                  type: HomeTopItems.recurrentClients,
                  data: statusProvider.serverStatus?.stats.topClients ?? [],
                  withChart: true,
                  withProgressBar: true,
                  buildValue: (v) => v.toString(),
                  menuOptions: (v) => [
                    if (clientsProvider.clients?.clientsAllowedBlocked != null) MenuOption(
                      title: clientsProvider.checkClientList(v) == AccessSettingsList.allowed || clientsProvider.checkClientList(v) == null
                        ? AppLocalizations.of(context)!.blockClient
                        : AppLocalizations.of(context)!.unblockClient,
                      icon: clientsProvider.checkClientList(v) == AccessSettingsList.allowed || clientsProvider.checkClientList(v) == null
                        ? Icons.block_rounded
                        : Icons.check_rounded, 
                      action: () => blockUnblockClient(v)
                    ),
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded, 
                      action: () => copyValueClipboard(v)
                    ),
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
                    TopItemsSection(
                      label: AppLocalizations.of(context)!.topUpstreams, 
                      type: HomeTopItems.topUpstreams,
                      data: statusProvider.serverStatus?.stats.topUpstreamResponses ?? [],
                      withChart: true,
                      withProgressBar: true,
                      buildValue: (v) => v.toString(),
                      menuOptions: (v) => [
                        MenuOption(
                          title: AppLocalizations.of(context)!.copyClipboard,
                          icon: Icons.copy_rounded, 
                          action: () => copyValueClipboard(v)
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
                    TopItemsSection(
                      label: AppLocalizations.of(context)!.averageUpstreamResponseTime, 
                      type: HomeTopItems.avgUpstreamResponseTime,
                      data: statusProvider.serverStatus?.stats.topUpstreamsAvgTime ?? [],
                      withChart: false,
                      withProgressBar: false,
                      buildValue: (v) => "${doubleFormat(v*1000, Platform.localeName)} ms",
                      menuOptions: (v) => [
                        MenuOption(
                          title: AppLocalizations.of(context)!.copyClipboard,
                          icon: Icons.copy_rounded, 
                          action: () => copyValueClipboard(v)
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