import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/constants/enums.dart';

class SortCustomRulesModal extends StatelessWidget {
  final CustomRulesSorting sortingMethod;
  final void Function(CustomRulesSorting) onSelect;

  const SortCustomRulesModal({
    super.key,
    required this.sortingMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      scrollable: true,
      title: Column(
        children: [
          Icon(
            Icons.sort_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.sortingOptions,
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
        child: Column(
          children: [
            _CustomListTileDialog(
              title: AppLocalizations.of(context)!.topToBottom, 
              icon: Icons.arrow_downward_rounded, 
              onTap: () {
                Navigator.pop(context);
                onSelect(CustomRulesSorting.topBottom);
              }, 
              isSelected: sortingMethod == CustomRulesSorting.topBottom
            ),
            _CustomListTileDialog(
              title: AppLocalizations.of(context)!.bottomToTop, 
              icon: Icons.arrow_upward_rounded, 
              onTap: () {
                Navigator.pop(context);
                onSelect(CustomRulesSorting.bottomTop);
              }, 
              isSelected: sortingMethod == CustomRulesSorting.bottomTop
            ),
          ]
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(AppLocalizations.of(context)!.close)
            )
          ],
        )
      ],
    );
  }
}

class _CustomListTileDialog extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  final bool isSelected;

  const _CustomListTileDialog({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 24),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Icon(
                isSelected == true ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}