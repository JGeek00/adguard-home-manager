import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AddedClientTile extends StatefulWidget {
  final Client client;
  final void Function(Client) onTap;
  final void Function(Client) onLongPress;
  final void Function(Client) onEdit;
  final Client? selectedClient;
  final bool? splitView;

  const AddedClientTile({
    Key? key,
    required this.client,
    required this.onTap,
    required this.onLongPress,
    required this.onEdit,
    this.selectedClient,
    required this.splitView
  }) : super(key: key);

  @override
  State<AddedClientTile> createState() => _AddedClientTileState();
}

class _AddedClientTileState extends State<AddedClientTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    if (widget.splitView == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => widget.onTap(widget.client),
            onHover: (v) => setState(() => hover = v),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: widget.client == widget.selectedClient 
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.filter_list_rounded,
                                    size: 19,
                                    color: widget.client.filteringEnabled == true 
                                      ? appConfigProvider.useThemeColorForStatus == true
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.green
                                      : appConfigProvider.useThemeColorForStatus == true
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    Icons.vpn_lock_rounded,
                                    size: 18,
                                    color: widget.client.safebrowsingEnabled == true 
                                      ? appConfigProvider.useThemeColorForStatus == true
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.green
                                      : appConfigProvider.useThemeColorForStatus == true
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    Icons.block,
                                    size: 18,
                                    color: widget.client.parentalEnabled == true 
                                      ? appConfigProvider.useThemeColorForStatus == true
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.green
                                      : appConfigProvider.useThemeColorForStatus == true
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    Icons.search_rounded,
                                    size: 19,
                                    color: serverVersionIsAhead(
                                      currentVersion: serversProvider.serverStatus.data!.serverVersion, 
                                      referenceVersion: 'v0.107.28',
                                      referenceVersionBeta: 'v0.108.0-b.33'
                                    ) == true 
                                      ? widget.client.safeSearch != null && widget.client.safeSearch!.enabled == true 
                                        ? appConfigProvider.useThemeColorForStatus == true
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.green
                                        : appConfigProvider.useThemeColorForStatus == true
                                          ? Colors.grey
                                          : Colors.red
                                      : widget.client.safesearchEnabled == true
                                        ? appConfigProvider.useThemeColorForStatus == true
                                          ? Theme.of(context).colorScheme.primary
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
                      ],
                    ),
                  ),
                  if (hover == true) IconButton(
                    onPressed: () => widget.onEdit(widget.client), 
                    icon: const Icon(Icons.edit_rounded)
                  )
                ],
              )
            ),
          ),
        ),
      );
    }
    else {
      return CustomListTile(
        onLongPress: () => widget.onLongPress(widget.client),
        onTap: () => widget.onTap(widget.client),
        onHover: (v) => setState(() => hover = v),
        title: widget.client.name,
        subtitleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''),
              style: TextStyle(
                color: Theme.of(context).listTileTheme.textColor
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  size: 19,
                  color: widget.client.filteringEnabled == true 
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.vpn_lock_rounded,
                  size: 18,
                  color: widget.client.safebrowsingEnabled == true 
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.block,
                  size: 18,
                  color: widget.client.parentalEnabled == true 
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red,
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.search_rounded,
                  size: 19,
                  color: serverVersionIsAhead(
                    currentVersion: serversProvider.serverStatus.data!.serverVersion, 
                    referenceVersion: 'v0.107.28',
                    referenceVersionBeta: 'v0.108.0-b.33'
                  ) == true 
                    ? widget.client.safeSearch != null && widget.client.safeSearch!.enabled == true 
                      ? appConfigProvider.useThemeColorForStatus == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.green
                      : appConfigProvider.useThemeColorForStatus == true
                        ? Colors.grey
                        : Colors.red
                    : widget.client.safesearchEnabled == true
                      ? appConfigProvider.useThemeColorForStatus == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.green
                      : appConfigProvider.useThemeColorForStatus == true
                        ? Colors.grey
                        : Colors.red,
                )
              ],
            )
          ],
        ),
        trailing: hover == true
          ? IconButton(
              onPressed: () => widget.onEdit(widget.client), 
              icon: const Icon(Icons.edit_rounded)
            )
          : null,
      );
    }
  }
}