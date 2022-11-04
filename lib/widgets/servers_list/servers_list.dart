// ignore_for_file: use_build_context_synchronously
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/servers_list/delete_modal.dart';
import 'package:adguard_home_manager/widgets/add_server_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class ServersList extends StatefulWidget {
  final BuildContext context;
  final List<ExpandableController> controllers;
  final Function(int) onChange;
  final ScrollController scrollController;

  const ServersList({
    Key? key,
    required this.context,
    required this.controllers,
    required this.onChange,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ServersList> createState() => _ServersListState();
}

class _ServersListState extends State<ServersList> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    for (ExpandableController controller in widget.controllers) {
      controller.addListener(() async {
        await Future.delayed(const Duration(milliseconds: 200));
        if (controller.value == false) {
          animationController.animateTo(0);
        }
        else {
          animationController.animateBack(1);
        }
      });
    }

    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )
    ..addListener(() => setState(() => {}));
    animation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut
    ));
    
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    List<Server> servers = serversProvider.serversList;

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

      final result = server.runningOnHa == true 
        ? await loginHA(server)
        : await login(server);

      if (result['result'] == 'success') {
        serversProvider.setSelectedServer(server);

        serversProvider.setServerStatusLoad(0);
        final serverStatus = await getServerStatus(server);
        if (serverStatus['result'] == 'success') {
          serversProvider.setServerStatusData(serverStatus['data']);
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
          context: context, 
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
          context: context, 
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
          context: context, 
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
          Expanded(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: leadingIcon(servers[index]),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 3),
                          Text(
                            servers[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).listTileTheme.iconColor
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
          RotationTransition(
            turns: animation,
            child: const Icon(Icons.keyboard_arrow_down_rounded),
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
        controller: widget.scrollController,
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
            controller: widget.controllers[index],
            child: Column(
              children: [
                Expandable(
                  collapsed: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onChange(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: topRow(servers[index], index),
                      ),
                    ),
                  ),
                  expanded: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onChange(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              ),
            ),
          ),
        );
  }
}