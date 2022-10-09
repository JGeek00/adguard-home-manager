// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/filters_list.dart';
import 'package:adguard_home_manager/screens/filters/custom_rules_list.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
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
    widget.serversProvider.setFilteringLoadStatus(0, false);

    final result = await getFiltering(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setFilteringData(result['data']);
        widget.serversProvider.setFilteringLoadStatus(1, false);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setFilteringLoadStatus(2, false);
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

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  title: Text(AppLocalizations.of(context)!.filters),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: fetchUpdateLists,
                          child: Row(
                            children: [
                              const Icon(Icons.update),
                              const SizedBox(width: 10),
                              Text(AppLocalizations.of(context)!.updateLists)
                            ],
                          )
                        ),
                        PopupMenuItem(
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
                  ],
                  bottom: TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.verified_user_rounded),
                        text: AppLocalizations.of(context)!.whitelists,
                      ),
                      Tab(
                        icon: const Icon(Icons.gpp_bad_rounded),
                        text: AppLocalizations.of(context)!.blacklists,
                      ),
                      Tab(
                        icon: const Icon(Icons.shield_rounded),
                        text: AppLocalizations.of(context)!.customRules,
                      ),
                    ]
                  )
                ),
              ),
            )
          ];
        }), 
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromRGBO(220, 220, 220, 1)
                  : const Color.fromRGBO(50, 50, 50, 1)
              )
            )
          ),
          child: TabBarView(
            controller: tabController,
            children: [
              RefreshIndicator(
                onRefresh: fetchFilters,
                child: FiltersList(
                  loadStatus: serversProvider.filtering.loadStatus,
                  scrollController: scrollController,
                  type: 'whitelist',
                  data: serversProvider.filtering.loadStatus == 1
                    ? serversProvider.filtering.data!.whitelistFilters : [],
                  fetchData: fetchFilters,
                )
              ),
              RefreshIndicator(
                onRefresh: fetchFilters,
                child: FiltersList(
                  loadStatus: serversProvider.filtering.loadStatus,
                  scrollController: scrollController,
                  type: 'blacklist',
                  data: serversProvider.filtering.loadStatus == 1
                    ? serversProvider.filtering.data!.filters : [],
                  fetchData: fetchFilters,
                )
              ),
              RefreshIndicator(
                onRefresh: fetchFilters,
                child: CustomRulesList(
                  loadStatus: serversProvider.filtering.loadStatus,
                  scrollController: scrollController,
                  data: serversProvider.filtering.loadStatus == 1
                    ? serversProvider.filtering.data!.userRules : [],
                  fetchData: fetchFilters,
                )
              ),
            ]
          )
        ),
      )
    );
  }
}