import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/logs_list_client.dart';
import 'package:adguard_home_manager/screens/clients/added_list.dart';
import 'package:adguard_home_manager/screens/clients/clients_list.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/screens/clients/search_clients.dart';


class ClientsDesktopView extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final Future Function() fetchClients;

  const ClientsDesktopView({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.fetchClients
  }) : super(key: key);

  @override
  State<ClientsDesktopView> createState() => _ClientsDesktopViewState();
}

class _ClientsDesktopViewState extends State<ClientsDesktopView>  with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  
  AutoClient? selectedActiveClient;
  Client? selectedAddedClient;
  
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

    Widget tabBarView() {
      return TabBarView(
        controller: tabController,
        children: [
          ClientsList(
            scrollController: scrollController,
            loadStatus: serversProvider.clients.loadStatus,
            data: serversProvider.clients.loadStatus == LoadStatus.loaded
              ? serversProvider.clients.data!.autoClientsData : [],
            fetchClients: widget.fetchClients,
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
            splitView: true
          ),
          AddedList(
            scrollController: scrollController,
            loadStatus: serversProvider.clients.loadStatus,
            data: serversProvider.clients.loadStatus == LoadStatus.loaded
              ? serversProvider.clients.data!.clients : [], 
            fetchClients: widget.fetchClients,
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.clients),
          centerTitle: false,
          actions: [
            if (serversProvider.clients.loadStatus == LoadStatus.loaded) ...[
              IconButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SearchClients()
                  ))
                }, 
                icon: const Icon(Icons.search),
                tooltip: AppLocalizations.of(context)!.searchClients,
              ),
              const SizedBox(width: 10),
            ]
          ],
          bottom: tabBar() 
        ),
        body: tabBarView(),
      ),
    );
  }
}