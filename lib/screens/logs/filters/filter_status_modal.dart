

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';

class FilterStatusModal extends StatefulWidget {
  final String value;
  final bool dialog;

  const FilterStatusModal({
    super.key,
    required this.value,
    required this.dialog
  });

  @override
  State<FilterStatusModal> createState() => _FilterStatusModalState();
}

class _FilterStatusModalState extends State<FilterStatusModal> {
  String selectedResultStatus = 'all';

  @override
  void initState() {
    setState(() => selectedResultStatus = widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CloseButton(
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppLocalizations.of(context)!.responseStatus,
                              style: const TextStyle(
                                fontSize: 22
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(height: 16),
                      _ItemsList(
                        selectedResultStatus: logsProvider.selectedResultStatus,
                        updateSelectedResultStatus: (v) => logsProvider.setSelectedResultStatus(value: v),
                      ),
                      Container(height: 16)
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      );  
    }
    else {
      return SizedBox(
        height: 700,
        child: ListBottomSheet(
          icon: Icons.shield_rounded, 
          title: AppLocalizations.of(context)!.responseStatus,
          initialChildSize: 1,
          minChildSize: 0.5,
          children: [
            _ItemsList(
              selectedResultStatus: logsProvider.selectedResultStatus,
              updateSelectedResultStatus: (v) => logsProvider.setSelectedResultStatus(value: v),
            )
          ]
        ),
      );
    }
  }
}

class _ItemsList extends StatelessWidget {
  final String selectedResultStatus;
  final void Function(String) updateSelectedResultStatus;

  const _ItemsList({
    required this.selectedResultStatus,
    required this.updateSelectedResultStatus
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "all",
          icon: Icons.shield_rounded, 
          label: AppLocalizations.of(context)!.all, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "filtered",
          icon: Icons.shield_rounded, 
          label: AppLocalizations.of(context)!.filtered, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "processed",
          icon: Icons.verified_user_rounded, 
          label: AppLocalizations.of(context)!.processedRow, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "whitelisted",
          icon: Icons.verified_user_rounded, 
          label: AppLocalizations.of(context)!.processedWhitelistRow, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "blocked",
          icon: Icons.gpp_bad_rounded, 
          label: AppLocalizations.of(context)!.blocked, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "blocked_safebrowsing",
          icon: Icons.gpp_bad_rounded, 
          label: AppLocalizations.of(context)!.blockedSafeBrowsingRow, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "blocked_parental",
          icon: Icons.gpp_bad_rounded, 
          label: AppLocalizations.of(context)!.blockedParentalRow, 
          onChanged: updateSelectedResultStatus
        ),
        _Item(
          selectedResultStatus: selectedResultStatus,
          id: "safe_search",
          icon: Icons.gpp_bad_rounded, 
          label: AppLocalizations.of(context)!.blockedSafeSearchRow, 
          onChanged: updateSelectedResultStatus
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String selectedResultStatus;
  final String id;
  final IconData icon;
  final String label;
  final void Function(String) onChanged;

  const _Item({
    required this.selectedResultStatus,
    required this.id,
    required this.icon,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 24,
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Radio(
                value: id, 
                groupValue: selectedResultStatus, 
                onChanged: (v) => onChanged(v!)
              )
            ],
          ),
        ),
      ),
    );
  }
}