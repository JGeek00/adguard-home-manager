// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/servers_list/server_tile_functions.dart';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServersListItem extends StatefulWidget {
  final ExpandableController expandableController;
  final Server server;
  final int index;
  final void Function(int) onChange;

  const ServersListItem({
    super.key,
    required this.expandableController,
    required this.server,
    required this.index,
    required this.onChange
  });

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
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                    child: _TopRow(server: widget.server, animation: animation)
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
                        _TopRow(server: widget.server, animation: animation),
                        _BottomRow(
                          server: widget.server,
                          connectToServer: (s) => connectToServer(context: context, server: s),
                          openServerModal: (s) => openServerModal(context: context, server: s, width: width),
                          setDefaultServer: (s) => setDefaultServer(context: context, server: s),
                          showDeleteModal: (s) => showDeleteModal(context: context, server: s),
                        )
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

class _TopRow extends StatelessWidget {
  final Server server;
  final Animation<double> animation;

  const _TopRow({
    required this.server,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: _LeadingIcon(server: server),
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
}

class _LeadingIcon extends StatelessWidget {
  final Server server;

  const _LeadingIcon({
    required this.server,
  });

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    if (server.defaultServer == true) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.storage_rounded,
            color: serversProvider.selectedServer != null && serversProvider.selectedServer?.id == server.id
              ? Colors.green
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
          ? Colors.green
          : null,
      );
    }
  }
}

class _BottomRow extends StatelessWidget {
  final Server server;
  final void Function(Server) setDefaultServer;
  final void Function(Server) openServerModal;
  final void Function(Server) showDeleteModal;
  final void Function(Server) connectToServer;

  const _BottomRow({
    required this.server,
    required this.setDefaultServer,
    required this.openServerModal,
    required this.showDeleteModal,
    required this.connectToServer,
  });

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

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
                  onTap: (() => openServerModal(server)), 
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
}