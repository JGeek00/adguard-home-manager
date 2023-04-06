import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/clients_list.dart';
import 'package:adguard_home_manager/screens/clients/search_clients.dart';
import 'package:adguard_home_manager/screens/clients/added_list.dart';

import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Clients extends StatelessWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ClientsWidget(
      server: serversProvider.selectedServer!,
      setLoadingStatus: serversProvider.setClientsLoadStatus,
      setClientsData: serversProvider.setClientsData,
      setSelectedClientsTab: appConfigProvider.setSelectedClientsTab,
      addLog: appConfigProvider.addLog,
    );
  }
}

class ClientsWidget extends StatefulWidget {
  final Server server;
  final void Function(LoadStatus, bool) setLoadingStatus;
  final void Function(ClientsData) setClientsData;
  final void Function(int) setSelectedClientsTab;
  final void Function(AppLog) addLog;

  const ClientsWidget({
    Key? key,
    required this.server,
    required this.setLoadingStatus,
    required this.setClientsData,
    required this.setSelectedClientsTab,
    required this.addLog,
  }) : super(key: key);

  @override
  State<ClientsWidget> createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> with TickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  Future fetchClients() async {
    widget.setLoadingStatus(LoadStatus.loading, false);
    final result = await getClients(widget.server);
    if (mounted) {
      if (result['result'] == 'success') {
        widget.setClientsData(result['data']);
        widget.setLoadingStatus(LoadStatus.loaded, true);
      }
      else {
        widget.addLog(result['log']);
        widget.setLoadingStatus(LoadStatus.error, true);
      }
    }
  }

  @override
  void initState() {
    fetchClients();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() => widget.setSelectedClientsTab(tabController.index));
  }

  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: Text(AppLocalizations.of(context)!.clients),
                pinned: true,
                floating: true,
                centerTitle: false,
                forceElevated: innerBoxIsScrolled,
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
                bottom: TabBar(
                  controller: tabController,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.devices),
                      text: AppLocalizations.of(context)!.activeClients,
                    ),
                    Tab(
                      icon: const Icon(Icons.add_rounded),
                      text: AppLocalizations.of(context)!.added,
                    ),
                  ]
                )
              ),
            )
          ];
        }), 
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
              )
            )
          ),
          child: TabBarView(
            controller: tabController,
            children: [
              ClientsList(
                scrollController: scrollController,
                loadStatus: serversProvider.clients.loadStatus,
                data: serversProvider.clients.loadStatus == LoadStatus.loaded
                  ? serversProvider.clients.data!.autoClientsData : [],
                fetchClients: fetchClients,
              ),
              AddedList(
                scrollController: scrollController,
                loadStatus: serversProvider.clients.loadStatus,
                data: serversProvider.clients.loadStatus == LoadStatus.loaded
                  ? serversProvider.clients.data!.clients : [], 
                fetchClients: fetchClients,
              ),
            ]
          )
        ),
      )
    );
  }
}