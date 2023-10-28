import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/clients_list.dart';
import 'package:adguard_home_manager/screens/clients/added_list.dart';

import 'package:adguard_home_manager/constants/routes_names.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/clients.dart';

class Clients extends StatefulWidget {
  final Widget child;

  const Clients({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  bool searchMode = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    clientsProvider.fetchClients(updateLoading: true);

    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(
      () => Provider.of<AppConfigProvider>(context, listen: false).setSelectedClientsTab(tabController.index)
    );
  }

  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    
    final width = MediaQuery.of(context).size.width;

    PreferredSizeWidget tabBar() {
      return TabBar(
        controller: tabController,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.devices),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.activeClients)
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_rounded),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.added)
              ],
            ),
          ),
        ]
      );
    }

    Widget tabBarView(bool sliver) {
      return TabBarView(
        controller: tabController,
        children: [
          ClientsList(
            scrollController: scrollController,
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.filteredActiveClients : [],
            onClientSelected: (client) => context.go(
              RoutesNames.client, 
              extra: {
                "id": client.name != null && client.name != "" 
                  ? client.name 
                  : client.ip
              }
            ),
            splitView: isDesktop(width),
          ),
          AddedList(
            scrollController: scrollController,
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.filteredAddedClients : [], 
            onClientSelected: (client) => context.go(
              RoutesNames.client, 
              extra: { "id": client.name }
            ),
            splitView: isDesktop(width),
          ),
        ]
      );
    }

    return Row(
      children: [
        SizedBox(
          width: isDesktop(width) ? 300 : width,
          height: double.maxFinite,
          child: Material(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverAppBar(
                        title: searchMode == true
                          ? Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchMode = false;
                                      searchController.text = "";
                                      clientsProvider.setSearchTermClients(null);
                                    });
                                  }, 
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  tooltip: AppLocalizations.of(context)!.exitSearch,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: (value) => clientsProvider.setSearchTermClients(value),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            searchController.text = "";
                                            clientsProvider.setSearchTermClients(null);
                                          });
                                        },
                                        icon: const Icon(Icons.clear_rounded)
                                      ),
                                      hintText: AppLocalizations.of(context)!.search,
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                    ),
                                    autofocus: true,
                                  ),
                                )
                              ],
                            )
                          : Text(AppLocalizations.of(context)!.clients),
                        pinned: true,
                        floating: true,
                        centerTitle: false,
                        forceElevated: innerBoxIsScrolled,
                        actions: [
                          if (clientsProvider.loadStatus == LoadStatus.loaded && searchMode == false) ...[
                            IconButton(
                              onPressed: () => setState(() => searchMode = true), 
                              icon: const Icon(Icons.search),
                              tooltip: AppLocalizations.of(context)!.searchClients,
                            ),
                            const SizedBox(width: 10),
                          ]
                        ],
                        bottom: tabBar() 
                      ),
                    )
                  ];
                }), 
                body: tabBarView(true)
              )
            ),
          ),
        ),
        if (isDesktop(width) == true) Expanded(
          child: widget.child,
        )
      ],
    );
  }
}