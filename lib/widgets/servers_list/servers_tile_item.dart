// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/add_server_modal.dart';
import 'package:adguard_home_manager/widgets/servers_list/delete_modal.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServersTileItem extends StatefulWidget {
  final Server server;
  final int index;
  final void Function(int) onChange;

  const ServersTileItem({
    Key? key,
    required this.server,
    required this.index,
    required this.onChange
  }) : super(key: key);

  @override
  State<ServersTileItem> createState() => _ServersTileItemState();
}

class _ServersTileItemState extends State<ServersTileItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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
        if (width > 700) {
          showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (context) => AddServerModal(
              server: server,
              window: true,
            ),
          )
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => AddServerModal(
              server: server,
              window: false,
            )
          ))
        }
      }));
    }

    void connectToServer(Server server) async {
      final ProcessModal process = ProcessModal(context: context);
      process.open(AppLocalizations.of(context)!.connecting);

      final result = server.runningOnHa == true 
        ? await loginHA(server)
        : await login(server);

      if (result['result'] == 'success') {
        serversProvider.setSelectedServer(server);

        serversProvider.setServerStatusLoad(0);
        final serverStatus = await getServerStatus(server);
        if (serverStatus['result'] == 'success') {
          serversProvider.setServerStatusData(serverStatus['data']);
          serversProvider.checkServerUpdatesAvailable(server);
          serversProvider.setServerStatusLoad(1);
        }
        else {
          appConfigProvider.addLog(serverStatus['log']);
          serversProvider.setServerStatusLoad(2);
        }

        process.close();
      }
      else {
        process.close();
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.cannotConnect, 
          color: Colors.red
        );
      }
    }

    void setDefaultServer(Server server) async {
      final result = await serversProvider.setDefaultServer(server);
      if (result == null) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.connectionDefaultSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(
          AppLog(
            type: 'set_default_server', 
            dateTime: DateTime.now(),
            message: result.toString()
          )
        );
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.connectionDefaultFailed, 
          color: Colors.red
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
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
          Expanded(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: leadingIcon(server),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 3),
                          Text(
                            server.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurfaceVariant
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                // color: Theme.of(context).dialogBackgroundColor,
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
                child: serversProvider.selectedServer != null && 
                  serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id && serversProvider.serverStatus.data != null && 
                  serversProvider.selectedServer?.id == server.id
                    ? Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id && serversProvider.serverStatus.data != null
                          ? Colors.green
                          : Colors.orange,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        children: [
                          Icon(
                            serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id && serversProvider.serverStatus.data != null
                              ? Icons.check
                              : Icons.warning,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id && serversProvider.serverStatus.data != null
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
                          onPressed: () => connectToServer(server),
                          child: Text(AppLocalizations.of(context)!.connect),
                        ),
                      ),
              )
            ],
          )
        ],
      );
    }

    EdgeInsets generateMargins(int index) {
      if (index == 0) {
        return const EdgeInsets.only(top: 16, left: 16, right: 8, bottom: 8);
      }
      if (index == 1) {
        return const EdgeInsets.only(top: 16, left: 8, right: 16, bottom: 8);
      }
      else if (index == serversProvider.serversList.length-1 && (index+1)%2 == 0) {
        return const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 16);
      }
      else if (index == serversProvider.serversList.length-1 && (index+1)%2 == 1) {
        return const EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 16);
      }
      else {
        if ((index+1)%2 == 0) {
          return const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 8);
        }
        else {
          return const EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 8);
        }
      }
    }

    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Card(
        margin: generateMargins(widget.index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              topRow(widget.server, widget.index),
              bottomRow(widget.server, widget.index)
            ],
          ),
        ),
      ),
    );
  }
}