import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/clients_list.dart';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Clients extends StatelessWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    return ClientsWidget(
      server: serversProvider.selectedServer!,
      setLoadingStatus: serversProvider.setClientsLoadStatus,
      setClientsData: serversProvider.setClientsData,
    );
  }
}

class ClientsWidget extends StatefulWidget {
  final Server server;
  final void Function(int, bool) setLoadingStatus;
  final void Function(ClientsData) setClientsData;

  const ClientsWidget({
    Key? key,
    required this.server,
    required this.setLoadingStatus,
    required this.setClientsData,
  }) : super(key: key);

  @override
  State<ClientsWidget> createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> {
  void fetchClients() async {
    widget.setLoadingStatus(0, false);
    final result = await getClients(widget.server);
    if (result['result'] == 'success') {
      widget.setClientsData(result['data']);
      widget.setLoadingStatus(1, true);
    }
    else {
      widget.setLoadingStatus(2, true);
    }
  }

  @override
  void initState() {
    fetchClients();
    super.initState();
  }

  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    switch (serversProvider.clients.loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
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
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        );
      
      case 1:
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
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.devices),
                        text: AppLocalizations.of(context)!.clients,
                      ),
                      Tab(
                        icon: const Icon(Icons.check),
                        text: AppLocalizations.of(context)!.allowed,
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
            body: TabBarView(
              children: [
                ClientsList(
                  data: serversProvider.clients.data!.autoClientsData,
                ),
                ClientsList(
                  data: generateClientsList(
                    serversProvider.clients.data!.autoClientsData, 
                    serversProvider.clients.data!.clientsAllowedBlocked!.allowedClients, 
                  )
                ),
                ClientsList(
                  data: generateClientsList(
                    serversProvider.clients.data!.autoClientsData, 
                    serversProvider.clients.data!.clientsAllowedBlocked!.disallowedClients, 
                  )
                ),
              ],
            )
          )
        );
        
      case 2:
        return SizedBox(
          width: double.maxFinite,
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
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        );

      default:
        return const SizedBox();
    }
  }
}