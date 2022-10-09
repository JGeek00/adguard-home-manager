import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/access_settings/clients_list.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AccessSettings extends StatelessWidget {
  const AccessSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return AccessSettingsWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}

class AccessSettingsWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const AccessSettingsWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<AccessSettingsWidget> createState() => _AccessSettingsWidgetState();
}

class _AccessSettingsWidgetState extends State<AccessSettingsWidget> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;

  Future fetchClients() async {
    widget.serversProvider.setClientsLoadStatus(0, false);
    final result = await getClients(widget.serversProvider.selectedServer!);
    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setClientsData(result['data']);
        widget.serversProvider.setClientsLoadStatus(1, true);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setClientsLoadStatus(2, true);
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
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    return Scaffold(
      body: DefaultTabController(
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
                    title: Text(AppLocalizations.of(context)!.accessSettings),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: tabController,
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.check),
                          text: AppLocalizations.of(context)!.allowedClients,
                        ),
                        Tab(
                          icon: const Icon(Icons.block),
                          text: AppLocalizations.of(context)!.disallowedClients,
                        ),
                        Tab(
                          icon: const Icon(Icons.link_rounded),
                          text: AppLocalizations.of(context)!.disallowedDomains,
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
                ClientsList(
                  type: 'allowed',
                  scrollController: scrollController, 
                  loadStatus: serversProvider.clients.loadStatus, 
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.clientsAllowedBlocked!.allowedClients : [], 
                  fetchClients: fetchClients
                ),
                ClientsList(
                  type: 'disallowed',
                  scrollController: scrollController, 
                  loadStatus: serversProvider.clients.loadStatus, 
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.clientsAllowedBlocked!.disallowedClients : [], 
                  fetchClients: fetchClients
                ),
                ClientsList(
                  type: 'domains',
                  scrollController: scrollController, 
                  loadStatus: serversProvider.clients.loadStatus, 
                  data: serversProvider.clients.loadStatus == 1
                    ? serversProvider.clients.data!.clientsAllowedBlocked!.blockedHosts : [], 
                  fetchClients: fetchClients
                ),
              ]
            )
          ),
        )
      ),
    );
  }
}