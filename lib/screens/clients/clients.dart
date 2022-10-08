import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/clients_list.dart';
import 'package:adguard_home_manager/screens/clients/blocked_list.dart';
import 'package:adguard_home_manager/screens/clients/added_list.dart';

import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/server.dart';
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
  final void Function(int, bool) setLoadingStatus;
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

  Future fetchClients() async {
    widget.setLoadingStatus(0, false);
    final result = await getClients(widget.server);
    if (mounted) {
      if (result['result'] == 'success') {
        widget.setClientsData(result['data']);
        widget.setLoadingStatus(1, true);
      }
      else {
        widget.addLog(result['log']);
        widget.setLoadingStatus(2, true);
      }
    }
  }

  @override
  void initState() {
    fetchClients();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
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

    Widget generateBody() {
      switch (serversProvider.clients.loadStatus) {
      case 0:
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height-171,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.loadingStatus,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        
        case 1:
        return Container();
          
        case 2:
          return Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height-171,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.errorLoadServerStatus,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );

        default:
          return const SizedBox();
      }
    }

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(AppLocalizations.of(context)!.clients),
              centerTitle: true,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.devices),
                    text: AppLocalizations.of(context)!.activeClients,
                  ),
                  Tab(
                    icon: const Icon(Icons.add),
                    text: AppLocalizations.of(context)!.added,
                  ),
                  Tab(
                    icon: const Icon(Icons.block),
                    text: AppLocalizations.of(context)!.blocked,
                  ),
                ]
              )
            )
          ];
        }), 
        body: Container(
          decoration: BoxDecoration(
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
                onRefresh: fetchClients,
                child: ClientsList(
                  loadStatus: serversProvider.clients.loadStatus,
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.autoClientsData : [],
                  fetchClients: fetchClients,
                ),
              ),
              RefreshIndicator(
                onRefresh: fetchClients,
                child: AddedList(
                  loadStatus: serversProvider.clients.loadStatus,
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.clients : [], 
                  fetchClients: fetchClients,
                )
              ),
              RefreshIndicator(
                onRefresh: fetchClients,
                child: BlockedList(
                  loadStatus: serversProvider.clients.loadStatus,
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.clientsAllowedBlocked!.disallowedClients : [], 
                  fetchClients: fetchClients,
                )
              ),
            ]
          )
        ),
      )
    );
  }
}