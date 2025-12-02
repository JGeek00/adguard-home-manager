// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/servers_list/server_tile_functions.dart';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServersTileItem extends StatefulWidget {
  final Server server;
  final int index;
  final void Function(int) onChange;
  final double breakingWidth;

  const ServersTileItem({
    super.key,
    required this.server,
    required this.index,
    required this.onChange,
    required this.breakingWidth
  });

  @override
  State<ServersTileItem> createState() => _ServersTileItemState();
}

class _ServersTileItemState extends State<ServersTileItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return FractionallySizedBox(
      widthFactor: width > widget.breakingWidth ? 0.5 : 1,
      child: Card(
        margin:  width > widget.breakingWidth
          ? generateMargins(index: widget.index, serversListLength: serversProvider.serversList.length)
          : const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _TopRow(server: widget.server, index: widget.index)
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8, right: 8, bottom: 16
              ),
              child: _BottomRow(
                server: widget.server,
                connectToServer: (s) => connectToServer(context: context, server: s),
                openServerModal: (s) => openServerModal(context: context, server: s, width: width),
                setDefaultServer: (s) => setDefaultServer(context: context, server: s),
                showDeleteModal: (s) => showDeleteModal(context: context, server: s),
              )
            )
          ],
        ),
      ),
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

class _TopRow extends StatelessWidget {
  final Server server;
  final int index;

  const _TopRow({
    required this.server,
    required this.index,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton(
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
              child: serversProvider.selectedServer != null && 
                serversProvider.selectedServer != null &&
                serversProvider.selectedServer?.id == server.id
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)!.connected,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: FilledButton.icon(
                        icon: const Icon(Icons.login),
                        onPressed: () => connectToServer(server),
                        label: Text(AppLocalizations.of(context)!.connect),
                      ),
                    ),
            )
          ],
        )
      ],
    );
  }
}