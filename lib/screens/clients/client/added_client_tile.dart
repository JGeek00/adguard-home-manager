import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/options_menu.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AddedClientTile extends StatefulWidget {
  final Client client;
  final void Function(Client) onTap;
  final void Function(Client) onLongPress;
  final void Function(Client)? onEdit;
  final void Function(Client) onDelete;
  final Client? selectedClient;
  final bool? splitView;

  const AddedClientTile({
    super.key,
    required this.client,
    required this.onTap,
    required this.onLongPress,
    this.onEdit,
    required this.onDelete,
    this.selectedClient,
    required this.splitView,
  });

  @override
  State<AddedClientTile> createState() => _AddedClientTileState();
}

class _AddedClientTileState extends State<AddedClientTile> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    if (widget.splitView == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: OptionsMenu(
            options: [
              MenuOption(
                icon: Icons.copy_rounded,
                title: AppLocalizations.of(context)!.copyClipboard, 
                action: (_) => copyToClipboard(
                  value: widget.client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''), 
                  successMessage: AppLocalizations.of(context)!.copiedClipboard,
                )
              ),
            ],
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => widget.onTap(widget.client),
              onHover: (v) => setState(() => _isHover = v),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: widget.client == widget.selectedClient 
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                                      color: widget.client.safeSearch != null && widget.client.safeSearch!.enabled == true 
                                        ? appConfigProvider.useThemeColorForStatus == true
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.green
                                        : appConfigProvider.useThemeColorForStatus == true
                                          ? Colors.grey
                                          : Colors.red
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    if (widget.onEdit != null && _isHover == true) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => widget.onEdit!(widget.client), 
                        icon: const Icon(Icons.file_open_rounded),
                        tooltip: AppLocalizations.of(context)!.seeDetails,
                      )
                    ]
                  ],
                )
              ),
            ),
          ),
        ),
      );
    }
    else {
      return OptionsMenu(
        options: [
          if (widget.onEdit != null) MenuOption(
            title: AppLocalizations.of(context)!.seeDetails,
            icon: Icons.file_open_rounded,
            action: (_) => widget.onEdit!(widget.client)
          ),
          MenuOption(
            icon: Icons.copy_rounded,
            title: AppLocalizations.of(context)!.copyClipboard, 
            action: (_) => copyToClipboard(
              value: widget.client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''), 
              successMessage: AppLocalizations.of(context)!.copiedClipboard,
            )
          ),
        ],
        child: CustomListTile(
          onTap: () => widget.onTap(widget.client),
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
                    color: widget.client.safeSearch != null && widget.client.safeSearch!.enabled == true 
                      ? appConfigProvider.useThemeColorForStatus == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.green
                      : appConfigProvider.useThemeColorForStatus == true
                        ? Colors.grey
                        : Colors.red
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}