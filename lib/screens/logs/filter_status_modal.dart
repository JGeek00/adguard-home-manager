import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';

class FilterStatusModal extends StatefulWidget {
  final String value;
  final bool dialog;

  const FilterStatusModal({
    Key? key,
    required this.value,
    required this.dialog
  }) : super(key: key);

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

    void apply() async {
      logsProvider.setSelectedResultStatus(selectedResultStatus);

      Navigator.pop(context);
    }

    Widget filterStatusListItem({
      required String id,
      required IconData icon,
      required String label,
      required void Function(String?) onChanged
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged(id),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 24,
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                    const SizedBox(width: 16),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    )
                  ],
                ),
                Radio(
                  value: id, 
                  groupValue: selectedResultStatus, 
                  onChanged: onChanged
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              bottom: 16,
                            ),
                            child: Icon(
                              Icons.shield_rounded,
                              size: 24,
                              color: Theme.of(context).listTileTheme.iconColor
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.responseStatus,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(height: 16),
                  filterStatusListItem(
                    id: "all",
                    icon: Icons.shield_rounded, 
                    label: AppLocalizations.of(context)!.all, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "filtered",
                    icon: Icons.shield_rounded, 
                    label: AppLocalizations.of(context)!.filtered, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "processed",
                    icon: Icons.verified_user_rounded, 
                    label: AppLocalizations.of(context)!.processedRow, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "whitelisted",
                    icon: Icons.verified_user_rounded, 
                    label: AppLocalizations.of(context)!.processedWhitelistRow, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "blocked",
                    icon: Icons.gpp_bad_rounded, 
                    label: AppLocalizations.of(context)!.blocked, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "blocked_safebrowsing",
                    icon: Icons.gpp_bad_rounded, 
                    label: AppLocalizations.of(context)!.blockedSafeBrowsingRow, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "blocked_parental",
                    icon: Icons.gpp_bad_rounded, 
                    label: AppLocalizations.of(context)!.blockedParentalRow, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                  filterStatusListItem(
                    id: "safe_search",
                    icon: Icons.gpp_bad_rounded, 
                    label: AppLocalizations.of(context)!.blockedSafeSearchRow, 
                    onChanged: (value) => setState(() => selectedResultStatus = value!)
                  ),
                 
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: apply, 
                  child: Text(AppLocalizations.of(context)!.apply)
                )
              ],
            ),
          ),
          if (Platform.isIOS) const SizedBox(height: 16)
        ],
      );
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: content()
        ),
      );  
    }
    else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28) 
          ),
          color: Theme.of(context).dialogBackgroundColor
        ),
        child: content()
      );
    }
  }
}