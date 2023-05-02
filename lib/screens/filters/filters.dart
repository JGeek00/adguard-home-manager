// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/filters_list.dart';
import 'package:adguard_home_manager/screens/filters/check_host_modal.dart';
import 'package:adguard_home_manager/screens/filters/custom_rules_list.dart';
import 'package:adguard_home_manager/screens/filters/blocked_services_screen.dart';
import 'package:adguard_home_manager/screens/filters/update_interval_lists_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return FiltersWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider
    );
  }
}

class FiltersWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const FiltersWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  Future fetchFilters() async {
    widget.serversProvider.setFilteringLoadStatus(LoadStatus.loading, false);

    final result = await getFiltering(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setFilteringData(result['data']);
        widget.serversProvider.setFilteringLoadStatus(LoadStatus.loaded, false);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setFilteringLoadStatus(LoadStatus.error, false);
      }
    }
  }

  @override
  void initState() {
    fetchFilters();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() => widget.appConfigProvider.setSelectedFiltersTab(tabController.index));
  }

  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void fetchUpdateLists() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingLists);

      final result = await updateLists(server: serversProvider.selectedServer!);

      if (result['result'] == 'success') {
        final result2 = await getFiltering(server: widget.serversProvider.selectedServer!);

        processModal.close();

        if (mounted) {
          if (result2['result'] == 'success') {
            widget.serversProvider.setFilteringData(result2['data']);

            showSnacbkar(
              context: context, 
              appConfigProvider: appConfigProvider,
              label: "${result['data']['updated']} ${AppLocalizations.of(context)!.listsUpdated}", 
              color: Colors.green
            );
          }
          else {
            widget.appConfigProvider.addLog(result2['log']);

            showSnacbkar(
              context: context, 
              appConfigProvider: appConfigProvider,
              label:  AppLocalizations.of(context)!.listsNotLoaded, 
              color: Colors.red
            );
          }
        }
        
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listsNotUpdated, 
          color: Colors.red
        );
      }
    }

    void showCheckHostModal() {
      Future.delayed(const Duration(seconds: 0), () {
        if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
          showDialog(
            context: context, 
            builder: (context) => const CheckHostModal(
              dialog: true,
            ),
          );
        }
        else {
          showModalBottomSheet(
            context: context, 
            builder: (context) => const CheckHostModal(
              dialog: false,
            ),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
          );
        }
      });
    }

    void enableDisableFiltering() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(
        serversProvider.serverStatus.data!.filteringEnabled == true
          ? AppLocalizations.of(context)!.disableFiltering
          : AppLocalizations.of(context)!.enableFiltering
      );

      final result = await updateFiltering(
        server: serversProvider.selectedServer!, 
        enable: !serversProvider.serverStatus.data!.filteringEnabled
      );

      processModal.close();

      if (result['result'] == 'success') {
        serversProvider.setFilteringProtectionStatus(!serversProvider.serverStatus.data!.filteringEnabled);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.filteringStatusUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.filteringStatusNotUpdated, 
          color: Colors.red
        );
      }
    }

    void setUpdateFrequency(int value) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.changingUpdateFrequency);

      final result = await requestChangeUpdateFrequency(server: serversProvider.selectedServer!, data: {
        "enabled": serversProvider.filtering.data!.enabled,
        "interval": value
      });

      processModal.close();

      if (result['result'] == 'success') {
        serversProvider.setFiltersUpdateFrequency(value);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.updateFrequencyChanged, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.updateFrequencyNotChanged, 
          color: Colors.red
        );
      }
    }

    void openBlockedServicesModal() {
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BlockedServicesScreen(),
          )
        );
      });
    }

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: Text(AppLocalizations.of(context)!.filters),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                centerTitle: false,
                actions: serversProvider.filtering.loadStatus == LoadStatus.loaded ? [
                  IconButton(
                    onPressed: enableDisableFiltering, 
                    tooltip: serversProvider.filtering.data!.enabled == true
                      ? AppLocalizations.of(context)!.disableFiltering
                      : AppLocalizations.of(context)!.enableFiltering,
                    icon: Stack(
                      children: [
                        const Icon(Icons.power_settings_new_rounded),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white
                                ),
                                child: Icon(
                                  serversProvider.filtering.data!.enabled == true
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel,
                                  size: 12,
                                  color: serversProvider.filtering.data!.enabled == true
                                    ? appConfigProvider.useThemeColorForStatus == true
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.green
                                    : appConfigProvider.useThemeColorForStatus == true
                                      ? Colors.grey
                                      : Colors.red
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  IconButton(
                    onPressed: () {
                      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
                        showDialog(
                          context: context, 
                          builder: (context) => UpdateIntervalListsModal(
                            interval: serversProvider.filtering.data!.interval,
                            onChange: setUpdateFrequency,
                            dialog: true,
                          ),
                        );
                      }
                      else {
                        showModalBottomSheet(
                          context: context, 
                          builder: (context) => UpdateIntervalListsModal(
                            interval: serversProvider.filtering.data!.interval,
                            onChange: setUpdateFrequency,
                            dialog: false,
                          ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true
                        );
                      }
                    }, 
                    icon: const Icon(Icons.update_rounded)
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: fetchUpdateLists,
                        child: Row(
                          children: [
                            const Icon(Icons.sync_rounded),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.updateLists)
                          ],
                        )
                      ),
                      PopupMenuItem(
                        onTap: openBlockedServicesModal,
                        child: Row(
                          children: [
                            const Icon(Icons.block),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.blockedServices)
                          ],
                        )
                      ),
                      PopupMenuItem(
                        onTap: showCheckHostModal,
                        child: Row(
                          children: [
                            const Icon(Icons.shield_rounded),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.checkHostFiltered)
                          ],
                        )
                      ),
                    ]
                  ),
                  const SizedBox(width: 5),
                ] : [],
                bottom: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified_user_rounded),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.whitelists,)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.gpp_bad_rounded),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.blacklists)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.shield_rounded),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.customRules)
                        ],
                      ),
                    ),
                  ]
                )
              ),
            )
          ];
        }), 
        body: TabBarView(
          controller: tabController,
          children: [
            FiltersList(
              loadStatus: serversProvider.filtering.loadStatus,
              scrollController: scrollController,
              type: 'whitelist',
              data: serversProvider.filtering.loadStatus == LoadStatus.loaded
                ? serversProvider.filtering.data!.whitelistFilters : [],
              fetchData: fetchFilters,
            ),
            FiltersList(
              loadStatus: serversProvider.filtering.loadStatus,
              scrollController: scrollController,
              type: 'blacklist',
              data: serversProvider.filtering.loadStatus == LoadStatus.loaded
                ? serversProvider.filtering.data!.filters : [],
              fetchData: fetchFilters,
            ),
            CustomRulesList(
              loadStatus: serversProvider.filtering.loadStatus,
              scrollController: scrollController,
              data: serversProvider.filtering.loadStatus == LoadStatus.loaded
                ? serversProvider.filtering.data!.userRules : [],
              fetchData: fetchFilters,
            ),
          ]
        )
      )
    );
  }
}