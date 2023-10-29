import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/added_list.dart';
import 'package:adguard_home_manager/screens/clients/client/logs_list_client.dart';
import 'package:adguard_home_manager/screens/clients/clients_list.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ClientsLists extends StatefulWidget {
  final bool splitView;

  const ClientsLists({
    Key? key,
    required this.splitView,
  }) : super(key: key);

  @override
  State<ClientsLists> createState() => _ClientsListsState();
}

class _ClientsListsState extends State<ClientsLists> with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  bool searchMode = false;
  final TextEditingController searchController = TextEditingController();

  AutoClient? _selectedAutoClient;
  Client? _selectedClient;

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


  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void onAutoClientSelected(AutoClient client) {
      setState(() => _selectedAutoClient = client);
      final w = LogsListClient(
        ip: client.ip, 
        serversProvider: serversProvider, 
        appConfigProvider: appConfigProvider,
        splitView: widget.splitView,
      );
      if (widget.splitView) {
        SplitView.of(context).push(w);
      }
      else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => w,
        ));
      }
    }
    
    void onClientSelected(Client client) {
      setState(() => _selectedClient = client);
      final w = LogsListClient(
        ip: client.ids[0], 
        serversProvider: serversProvider, 
        appConfigProvider: appConfigProvider,
        splitView: widget.splitView,
      );
      if (widget.splitView) {
        SplitView.of(context).push(w);
      }
      else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => w,
        ));
      }
    }

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
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
                surfaceTintColor: isDesktop(MediaQuery.of(context).size.width) 
                  ? Colors.transparent 
                  : null,
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
                bottom: TabBar(
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
                )
              ),
            )
          ];
        }), 
        body: TabBarView(
          controller: tabController,
          children: [
            ClientsList(
              data: clientsProvider.loadStatus == LoadStatus.loaded
                ? clientsProvider.filteredActiveClients : [],
              onClientSelected: onAutoClientSelected,
              selectedClient: _selectedAutoClient,
              splitView: widget.splitView,
            ),
            AddedList(
              scrollController: scrollController,
              data: clientsProvider.loadStatus == LoadStatus.loaded
                ? clientsProvider.filteredAddedClients : [], 
              onClientSelected: onClientSelected,
              selectedClient: _selectedClient,
              splitView: widget.splitView,
            ),
          ]
        )
      )
    );
  }
}