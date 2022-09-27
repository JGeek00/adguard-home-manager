// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/servers_list/delete_modal.dart';
import 'package:adguard_home_manager/widgets/add_server_modal.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class ServersList extends StatelessWidget {
  final BuildContext context;
  final List<ExpandableController> controllers;
  final Function(int) onChange;

  const ServersList({
    Key? key,
    required this.context,
    required this.controllers,
    required this.onChange
  }) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    List<Server> servers = serversProvider.serversList;

    final width = MediaQuery.of(context).size.width;

    void showDeleteModal(Server server) async {
      await Future.delayed(const Duration(seconds: 0), () => {
        showDialog(
          context: context, 
          builder: (context) => DeleteModal(
            serverToDelete: server,
          ),
          barrierDismissible: false
        )
      });
    }

    void openAddServerBottomSheet({Server? server}) async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => AddServerModal(server: server)
        ))
      }));
    }

    void connectToServer(Server server) async {
      final ProcessModal process = ProcessModal(context: context);
      process.open(AppLocalizations.of(context)!.connecting);

      final result = await login(server);

      if (result['result'] == 'success') {
        serversProvider.setSelectedServer(server);

        serversProvider.setServerStatusLoad(0);
        final serverStatus = await getServerStatus(server);
        if (serverStatus['result'] == 'success') {
          serversProvider.setServerStatusData(serverStatus['data']);
          serversProvider.setServerStatusLoad(1);
        }
        else {
          serversProvider.setServerStatusLoad(2);
        }

        process.close();
      }
      else {
        process.close();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cannotConnect),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void setDefaultServer(Server server) async {
      final result = await serversProvider.setDefaultServer(server);
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.connectionDefaultSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.connectionDefaultFailed),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    Widget leadingIcon(Server server) {
      if (server.defaultServer == true) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.storage_rounded,
              color: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id
                ? serversProvider.serverStatus.data != null
                  ? Colors.green
                  : Colors.orange
                : null,
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
      else {
        return Icon(
          Icons.storage_rounded,
          color: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id
            ? serversProvider.serverStatus.data != null
              ? Colors.green
              : Colors.orange
            : null,
        );
      }
    }

    Widget topRow(Server server, int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            margin: const EdgeInsets.only(right: 12),
            child: leadingIcon(servers[index]),
          ),
          SizedBox(
            width: width-168,
            child: Column(
              children: [
                Text(
                  "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      servers[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => onChange(index),
            icon: const Icon(Icons.arrow_drop_down),
            splashRadius: 20,
          ),
        ],
      );
    }

    Widget bottomRow(Server server, int index) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                color: Theme.of(context).dialogBackgroundColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: server.defaultServer == false 
                      ? true
                      : false,
                    onTap: server.defaultServer == false 
                      ? (() => setDefaultServer(server))
                      : null, 
                    child: SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.star),
                          const SizedBox(width: 15),
                          Text(
                            server.defaultServer == true 
                              ? AppLocalizations.of(context)!.defaultConnection
                              : AppLocalizations.of(context)!.setDefault,
                          )
                        ],
                      ),
                    )
                  ),
                  PopupMenuItem(
                    onTap: (() => openAddServerBottomSheet(server: server)), 
                    child: Row(
                      children: [
                        const Icon(Icons.edit),
                        const SizedBox(width: 15),
                        Text(AppLocalizations.of(context)!.edit)
                      ],
                    )
                  ),
                  PopupMenuItem(
                    onTap: (() => showDeleteModal(server)), 
                    child: Row(
                      children: [
                        const Icon(Icons.delete),
                        const SizedBox(width: 15),
                        Text(AppLocalizations.of(context)!.delete)
                      ],
                    )
                  ),
                ]
              ),
              SizedBox(
                child: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == servers[index].id
                  ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: serversProvider.serverStatus.data != null
                        ? Colors.green
                        : Colors.orange,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          serversProvider.serverStatus.data != null
                            ? Icons.check
                            : Icons.warning,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          serversProvider.serverStatus.data != null
                            ? AppLocalizations.of(context)!.connected
                            : AppLocalizations.of(context)!.selectedDisconnected,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                      ),
                  )
                  : Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () => connectToServer(servers[index]),
                        child: Text(AppLocalizations.of(context)!.connect),
                      ),
                    ),
              )
            ],
          )
        ],
      );
    }

    return servers.isNotEmpty ? 
      ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1
              )
            )
          ),
          child: ExpandableNotifier(
            controller: controllers[index],
            child: Column(
              children: [
                Expandable(
                  collapsed: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(index),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: topRow(servers[index], index),
                      ),
                    ),
                  ),
                  expanded: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(index),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            topRow(servers[index], index),
                            bottomRow(servers[index], index)
                          ],
                        ),
                      ),
                    ),
                  )
                ) 
              ],
            ),
          ),
        )
    ) : SizedBox(
          height: double.maxFinite,
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noSavedConnections,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.grey,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        );
  }
}