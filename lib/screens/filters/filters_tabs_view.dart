import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/custom_rules_list.dart';
import 'package:adguard_home_manager/screens/filters/filters_list.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class FiltersTabsView extends StatefulWidget {
  final AppConfigProvider appConfigProvider;
  final Future Function() fetchFilters;
  final List<Widget> actions;
  final void Function(String) onRemoveCustomRule;
  final void Function(Filter, String) onOpenDetailsModal;

  const FiltersTabsView({
    Key? key,
    required this.appConfigProvider,
    required this.fetchFilters,
    required this.actions,
    required this.onOpenDetailsModal,
    required this.onRemoveCustomRule
  }) : super(key: key);

  @override
  State<FiltersTabsView> createState() => _FiltersTabsViewState();
}

class _FiltersTabsViewState extends State<FiltersTabsView> with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    widget.fetchFilters();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() => widget.appConfigProvider.setSelectedFiltersTab(tabController.index));
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

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
                actions: widget.actions,
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
              fetchData: widget.fetchFilters,
              onOpenDetailsScreen: widget.onOpenDetailsModal,
            ),
            FiltersList(
              loadStatus: serversProvider.filtering.loadStatus,
              scrollController: scrollController,
              type: 'blacklist',
              data: serversProvider.filtering.loadStatus == LoadStatus.loaded
                ? serversProvider.filtering.data!.filters : [],
              fetchData: widget.fetchFilters,
              onOpenDetailsScreen: widget.onOpenDetailsModal,
            ),
            CustomRulesList(
              loadStatus: serversProvider.filtering.loadStatus,
              scrollController: scrollController,
              data: serversProvider.filtering.loadStatus == LoadStatus.loaded
                ? serversProvider.filtering.data!.userRules : [],
              fetchData: widget.fetchFilters,
              onRemoveCustomRule: widget.onRemoveCustomRule,
            ),
          ]
        )
      )
    );
  }
}