import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';

class FilterStatusModal extends StatefulWidget {
  final String value;

  const FilterStatusModal({
    Key? key,
    required this.value
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

    final height = MediaQuery.of(context).size.height;

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
                    ),
                    const SizedBox(width: 16),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
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

    return Container(
      height: height >= 720 == true
        ? 720
        : height-25,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28) 
        ),
        color: Theme.of(context).dialogBackgroundColor
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Icon(
              Icons.shield_rounded,
              size: 24,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.responseStatus,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              physics: height >= 720 == true
                ? const NeverScrollableScrollPhysics()
                : null,
              children: [
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
          )
        ],
      ),
    );
  }
}