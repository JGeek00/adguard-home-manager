import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/logs_list_client.dart';
import 'package:adguard_home_manager/screens/clients/added_list.dart';
import 'package:adguard_home_manager/screens/clients/clients_list.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';


class ClientsDesktopView extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const ClientsDesktopView({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<ClientsDesktopView> createState() => _ClientsDesktopViewState();
}

class _ClientsDesktopViewState extends State<ClientsDesktopView>  with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  
  AutoClient? selectedActiveClient;
  Client? selectedAddedClient;

  bool searchMode = false;
  final TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() => widget.appConfigProvider.setSelectedClientsTab(tabController.index));
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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
            onClientSelected: (client) => setState(() {
              selectedAddedClient = null;
              selectedActiveClient = client;
              SplitView.of(context).setSecondary(
                LogsListClient(
                  ip: client.ip,
                  name: client.name,
                  serversProvider: serversProvider,
                  appConfigProvider: appConfigProvider,
                )
              );
            }),
            selectedClient: selectedActiveClient,
            splitView: true,
            sliver: sliver,
          ),
          AddedList(
            scrollController: scrollController,
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.filteredAddedClients : [], 
            onClientSelected: (client) => setState(() {
              selectedActiveClient = null;
              selectedAddedClient = client;
              SplitView.of(context).setSecondary(
                LogsListClient(
                  ip: client.ids[0],
                  name: client.name,
                  serversProvider: serversProvider,
                  appConfigProvider: appConfigProvider,
                )
              );
            }),
            selectedClient: selectedAddedClient,
            splitView: true,
          ),
        ]
      );
    }

    Widget title() {
      if (searchMode == true) {
        return Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  searchMode = false;
                  searchController.text = "";
                  clientsProvider.setSearchTermClients(null);
                });
              }, 
              icon: const Icon(Icons.arrow_back_rounded)
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
              ),
            )
          ],
        );
      }
      else {
        return Text(AppLocalizations.of(context)!.clients);
      }
    }

    if (!(Platform.isAndroid || Platform.isIOS)) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: title(),
            centerTitle: false,
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
          body: tabBarView(false),
        ),
      );
    }
    else {
      return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: title(),
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
      );
    }
  }
}