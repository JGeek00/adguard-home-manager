// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/client_screen.dart';
import 'package:adguard_home_manager/screens/clients/options_modal.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class SearchClients extends StatelessWidget {
  const SearchClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    return SearchClientsWidget(
      serversProvider: serversProvider,
    );
  }
}

class SearchClientsWidget extends StatefulWidget {
  final ServersProvider serversProvider;

  const SearchClientsWidget({
    Key? key,
    required this.serversProvider,
  }) : super(key: key);

  @override
  State<SearchClientsWidget> createState() => _SearchClientsWidgetState();
}

class _SearchClientsWidgetState extends State<SearchClientsWidget> {
  late ScrollController scrollController;

  final TextEditingController searchController = TextEditingController();

  List<Client> clients = [];
  List<AutoClient> autoClients = [];

  List<Client> clientsScreen = [];
  List<AutoClient> autoClientsScreen = [];

  bool showDivider = true;

  void search(String value) {
    if (value == '') {
      setState(() {
        clientsScreen = [];
        autoClientsScreen = [];
      });
    }
    else {
      setState(() {
        clientsScreen = clients.where((client) => client.name.contains(value) || client.ids.where((e) => e.contains(value)).isNotEmpty).toList();
        autoClientsScreen = autoClients.where((client) => (client.name != null ? client.name!.contains(value) : true) || client.ip.contains(value)).toList();
      });
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels > 0) {
      setState(() => showDivider = false);
    }
    else {
      setState(() => showDivider = true);
    }
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(scrollListener);

    setState(() {
      clients = widget.serversProvider.clients.data!.clients;
      autoClients = widget.serversProvider.clients.data!.autoClientsData;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void deleteClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.removingClient);
      
      final result = await postDeleteClient(server: serversProvider.selectedServer!, name: client.name);
    
      processModal.close();

      if (result['result'] == 'success') {
        ClientsData clientsData = serversProvider.clients.data!;
        clientsData.clients = clientsData.clients.where((c) => c.name != client.name).toList();
        serversProvider.setClientsData(clientsData);
        setState(() {
          clients = clientsData.clients;
        });
        search(searchController.text);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientDeletedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotDeleted, 
          color: Colors.red
        );
      }
    }

    void confirmEditClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await postUpdateClient(server: serversProvider.selectedServer!, data: {
        'name': client.name,
        'data': client.toJson()
      });

      processModal.close();

      if (result['result'] == 'success') {
        ClientsData clientsData = serversProvider.clients.data!;
        clientsData.clients = clientsData.clients.map((e) {
          if (e.name == client.name) {
            return client;
          }
          else {
            return e;
          }
        }).toList();
        serversProvider.setClientsData(clientsData);

        setState(() {
          clients = clientsData.clients;
        });
        search(searchController.text);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientUpdatedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotUpdated, 
          color: Colors.red
        );
      }
    }

    void openClientModal(Client client) {
      Navigator.push(context, MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ClientScreen(
          onConfirm: confirmEditClient,
          onDelete: deleteClient,
          client: client,
        )
      ));
    }

    void openDeleteModal(Client client) {
      showModal(
        context: context, 
        builder: (ctx) => RemoveClientModal(
          onConfirm: () => deleteClient(client)
        )
      );
    }

    void openOptionsModal(Client client) {
      showModal(
        context: context, 
        builder: (ctx) => OptionsModal(
          onDelete: () => openDeleteModal(client),
          onEdit: () => openClientModal(client),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: TextFormField(
            controller: searchController,
            onChanged: search,
            decoration: InputDecoration(
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
        ),
        actions: [
          IconButton(
            onPressed: searchController.text != '' 
              ? () => setState(() {
                  searchController.text = '';
                  autoClientsScreen = autoClients;
                  clientsScreen = clients;
                })
              : null, 
            icon: const Icon(Icons.clear_rounded),
            tooltip: AppLocalizations.of(context)!.clearSearch,
          ),
          const SizedBox(width: 10)
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.maxFinite, 1),
          child: Container(
            width: double.maxFinite,
            height: 1,
            decoration: BoxDecoration(
              color: showDivider == true
                ? Colors.grey.withOpacity(0.5)
                : Colors.transparent
            ),
          ),
        ),
      ),
      body: clientsScreen.isNotEmpty || autoClientsScreen.isNotEmpty 
        ? ListView(
          controller: scrollController,
            children: [
              if (clientsScreen.isNotEmpty) ...[
                SectionLabel(
                  label: AppLocalizations.of(context)!.added,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: clientsScreen.length,
                  padding: const EdgeInsets.only(bottom: 0),
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: index == 0 
                      ? const EdgeInsets.only(left: 20, right: 20, bottom: 15)
                      : const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    isThreeLine: true,
                    onLongPress: () => openOptionsModal(clientsScreen[index]),
                    onTap: () => openClientModal(clientsScreen[index]),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        clientsScreen[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clientsScreen[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), '')),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              size: 19,
                              color: clientsScreen[index].filteringEnabled == true 
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.vpn_lock_rounded,
                              size: 18,
                              color: clientsScreen[index].safebrowsingEnabled == true 
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.block,
                              size: 18,
                              color: clientsScreen[index].parentalEnabled == true 
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.search_rounded,
                              size: 19,
                              color: clientsScreen[index].safesearchEnabled == true 
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                )
              ],
              if (autoClientsScreen.isNotEmpty) ...[
                SectionLabel(
                  label: AppLocalizations.of(context)!.activeClients,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                ),
                ListView.builder(                  
                  shrinkWrap: true,
                  primary: false,
                  itemCount: autoClientsScreen.length,
                  padding: const EdgeInsets.only(bottom: 0),
                  itemBuilder: (context, index) => CustomListTile(
                    title: autoClientsScreen[index].name != '' 
                      ? autoClientsScreen[index].name!
                      : autoClientsScreen[index].ip,
                    subtitle: autoClientsScreen[index].name != '' 
                      ? autoClientsScreen[index].ip 
                      : null,
                    trailing: Text(autoClientsScreen[index].source),
                    padding: index == 0
                      ? const EdgeInsets.only(left: 20, right: 20, bottom: 15)
                      : null,
                  )
                )
              ]
            ],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                searchController.text == ''
                  ? AppLocalizations.of(context)!.inputSearchTerm
                  : AppLocalizations.of(context)!.noClientsSearch,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 22
                ),
              ),
            ),
          )
    );
  }
}