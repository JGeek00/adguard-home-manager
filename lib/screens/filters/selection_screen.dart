import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';

class SelectionScreen extends StatefulWidget {
  final bool isModal;

  const SelectionScreen({
    Key? key,
    required this.isModal
  }) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  List<Filter> _selectedLists = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  void handleSelect(Filter list) {
    final isContained = _selectedLists.contains(list);
    if (isContained) {
      setState(() => _selectedLists = _selectedLists.where((l) => l != list).toList());
    }
    else {
      setState(() => _selectedLists.add(list));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteringProvider = Provider.of<FilteringProvider>(context);
    
    if (widget.isModal == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.selectionMode,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2, 
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
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
                        ]
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _List(
                              lists: filteringProvider.filtering!.whitelistFilters,
                              selectedLists: _selectedLists,
                              onSelect: handleSelect,
                            ),
                            _List(
                              lists: filteringProvider.filtering!.filters,
                              selectedLists: _selectedLists,
                              onSelect: handleSelect,
                            ),
                          ]
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      );
    }
    else {
      return Dialog.fullscreen(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    leading: CloseButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(AppLocalizations.of(context)!.selectionMode),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    centerTitle: false,
                    bottom: TabBar(
                      controller: _tabController,
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
                      ]
                    )
                  ),
                )
              ];
            }), 
            body: TabBarView(
              controller: _tabController,
              children: [
                _SliverList(
                  lists: filteringProvider.filtering!.whitelistFilters,
                  selectedLists: _selectedLists,
                  onSelect: handleSelect,
                ),
                _SliverList(
                  lists: filteringProvider.filtering!.filters,
                  selectedLists: _selectedLists,
                  onSelect: handleSelect,
                ),
              ]
            )
          )
        ),
      );
    }
  }
}

class _SliverList extends StatelessWidget {
  final List<Filter> lists;
  final List<Filter> selectedLists;
  final void Function(Filter) onSelect;

  const _SliverList({
    Key? key,
    required this.lists,
    required this.selectedLists,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              if (lists.isNotEmpty) SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CustomListTile(
                    title: lists[index].name,
                    subtitle: lists[index].url,
                    color: selectedLists.contains(lists[index])
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                    trailing: Column(
                      children: [
                        Icon(
                          lists[index].enabled == true 
                            ? Icons.check_rounded
                            : Icons.close_rounded,
                          size: 12,
                          color: lists[index].enabled == true
                            ? appConfigProvider.useThemeColorForStatus == true
                              ? Theme.of(context).colorScheme.primary
                              : Colors.green
                            : appConfigProvider.useThemeColorForStatus == true
                              ? Colors.grey
                              : Colors.red
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lists[index].enabled == true 
                            ? AppLocalizations.of(context)!.enabled
                            : AppLocalizations.of(context)!.disabled,
                          style: TextStyle(
                            fontSize: 10,
                            color: lists[index].enabled == true
                              ? appConfigProvider.useThemeColorForStatus == true
                                ? Theme.of(context).colorScheme.primary
                                : Colors.green
                              : appConfigProvider.useThemeColorForStatus == true
                                ? Colors.grey
                                : Colors.red
                          ),
                        )
                      ],
                    ),
                    onTap: () => onSelect(lists[index]),
                  ),
                  childCount: lists.length
                ),
              ),
              if (lists.isEmpty) SliverFillRemaining(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noItems,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  )
                )
              )
            ],
          );
        },
      ),
    );
  }
}

class _List extends StatelessWidget {
  final List<Filter> lists;
  final List<Filter> selectedLists;
  final void Function(Filter) onSelect;

  const _List({
    Key? key,
    required this.lists,
    required this.selectedLists,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ListView.builder(
      itemCount: lists.length,
      itemBuilder: (context, index) => CustomListTile(
        title: lists[index].name,
        subtitle: lists[index].url,
        color: selectedLists.contains(lists[index])
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
        trailing: Column(
          children: [
            Icon(
              lists[index].enabled == true 
                ? Icons.check_rounded
                : Icons.close_rounded,
              size: 12,
              color: lists[index].enabled == true
                ? appConfigProvider.useThemeColorForStatus == true
                  ? Theme.of(context).colorScheme.primary
                  : Colors.green
                : appConfigProvider.useThemeColorForStatus == true
                  ? Colors.grey
                  : Colors.red
            ),
            const SizedBox(height: 4),
            Text(
              lists[index].enabled == true 
                ? AppLocalizations.of(context)!.enabled
                : AppLocalizations.of(context)!.disabled,
              style: TextStyle(
                fontSize: 10,
                color: lists[index].enabled == true
                  ? appConfigProvider.useThemeColorForStatus == true
                    ? Theme.of(context).colorScheme.primary
                    : Colors.green
                  : appConfigProvider.useThemeColorForStatus == true
                    ? Colors.grey
                    : Colors.red
              ),
            )
          ],
        ),
        onTap: () => onSelect(lists[index]),
      ),
    );
  }
}