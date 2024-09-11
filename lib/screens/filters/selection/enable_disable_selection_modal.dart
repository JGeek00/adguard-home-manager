import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/filtering.dart';

class EnableDisableSelectionModal extends StatefulWidget {
  final List<Filter> selectedWhitelists;
  final List<Filter> selectedBlacklists;
  final void Function() onDelete;

  const EnableDisableSelectionModal({
    super.key,
    required this.selectedBlacklists,
    required this.selectedWhitelists,
    required this.onDelete,
  });

  @override
  State<EnableDisableSelectionModal> createState() => _EnableDisableSelectionModalState();
}

class _EnableDisableSelectionModalState extends State<EnableDisableSelectionModal> {
  bool _whitelistExpanded = true;
  bool _blacklistExpanded = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.remove_moderator_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.enableDisableSelected,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                if (widget.selectedWhitelists.isNotEmpty) ExpansionPanelList(
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  elevation: 0,
                  expansionCallback: (_, isExpanded) => setState(() => _whitelistExpanded = isExpanded),
                  animationDuration: const Duration(milliseconds: 250),
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.transparent,
                      headerBuilder: (context, isExpanded) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.whitelists,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                        ],
                      ),
                      body: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: widget.selectedWhitelists.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "• ${widget.selectedWhitelists[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.selectedWhitelists[index].enabled == true
                                  ? AppLocalizations.of(context)!.disable
                                  : AppLocalizations.of(context)!.enable,
                                style: TextStyle(
                                  color: widget.selectedWhitelists[index].enabled == true
                                    ? Colors.red
                                    : Colors.green,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      isExpanded: _whitelistExpanded
                    ),
                  ],
                ),
                if (widget.selectedWhitelists.isNotEmpty && widget.selectedBlacklists.isNotEmpty) const Padding(padding: EdgeInsets.all(8)),
                if (widget.selectedBlacklists.isNotEmpty) ExpansionPanelList(
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  elevation: 0,
                  expansionCallback: (_, isExpanded) => setState(() => _blacklistExpanded = isExpanded),
                  animationDuration: const Duration(milliseconds: 250),
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.transparent,
                      headerBuilder: (context, isExpanded) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.blacklists,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                        ],
                      ),
                      body: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: widget.selectedBlacklists.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "• ${widget.selectedBlacklists[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.selectedBlacklists[index].enabled == true
                                  ? AppLocalizations.of(context)!.disable
                                  : AppLocalizations.of(context)!.enable,
                                style: TextStyle(
                                  color: widget.selectedBlacklists[index].enabled == true
                                    ? Colors.red
                                    : Colors.green,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      isExpanded: _blacklistExpanded
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(AppLocalizations.of(context)!.cancel)
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: widget.onDelete, 
              child: Text(AppLocalizations.of(context)!.confirm)
            ),
          ],
        )
      ],
    );
  }
}