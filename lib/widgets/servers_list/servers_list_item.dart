// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/version_warning_modal.dart';
import 'package:adguard_home_manager/widgets/add_server_modal.dart';
import 'package:adguard_home_manager/widgets/servers_list/delete_modal.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServersListItem extends StatefulWidget {
  final ExpandableController expandableController;
  final Server server;
  final int index;
  final void Function(int) onChange;

  const ServersListItem({
    Key? key,
    required this.expandableController,
    required this.server,
    required this.index,
    required this.onChange
  }) : super(key: key);

  @override
  State<ServersListItem> createState() => _ServersListItemState();
}

class _ServersListItemState extends State<ServersListItem> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    widget.expandableController.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.expandableController.value == false) {
        animationController.animateTo(0);
      }
      else {
        animationController.animateBack(1);
      }
    });

    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
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
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
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
              onUnsupportedVersion: (version) => showDialog(
                context: context, 
                builder: (ctx) => VersionWarningModal(
                  version: version 
                ),
                barrierDismissible: false
              ),
            ),
          )
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => AddServerModal(
              server: server,
              window: false,
              onUnsupportedVersion: (version) => showDialog(
                context: context, 
                builder: (ctx) => VersionWarningModal(
                  version: version 
                ),
                barrierDismissible: false
              ),
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
        final ApiClient apiClient = ApiClient(server: server);
        serversProvider.setApiClient(apiClient);
        serversProvider.setSelectedServer(server);

        statusProvider.setServerStatusLoad(LoadStatus.loading);
        final serverStatus = await apiClient.getServerStatus();
        if (serverStatus['result'] == 'success') {
          statusProvider.setServerStatusData(
            data: serverStatus['data']
          );
          serversProvider.checkServerUpdatesAvailable(
            server: server,
            setValues: true
          );
          statusProvider.setServerStatusLoad(LoadStatus.loaded);
        }
        else {
          appConfigProvider.addLog(serverStatus['log']);
          statusProvider.setServerStatusLoad(LoadStatus.error);
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
                ? statusProvider.serverStatus != null
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
            ? statusProvider.serverStatus != null
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
                        textAlign: TextAlign.center,
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
                child: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id
                  ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: statusProvider.serverStatus != null
                        ? Colors.green
                        : Colors.orange,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          statusProvider.serverStatus != null
                            ? Icons.check
                            : Icons.warning,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          statusProvider.serverStatus != null
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

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceVariant,
            width: 1
          )
        )
      ),
      child: ExpandableNotifier(
        controller: widget.expandableController,
        child: Column(
          children: [
            Expandable(
              collapsed: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onChange(widget.index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: topRow(widget.server, widget.index),
                  ),
                ),
              ),
              expanded: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onChange(widget.index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        topRow(widget.server, widget.index),
                        bottomRow(widget.server, widget.index)
                      ],
                    ),
                  ),
                ),
              )
            ) 
          ],
        ),
      ),
    );
  }
}