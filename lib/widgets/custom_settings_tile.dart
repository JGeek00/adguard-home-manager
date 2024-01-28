import 'package:flutter/material.dart';

class CustomSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final void Function()? onTap;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsets? padding;
  final int thisItem;
  final int? selectedItem;

  const CustomSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.onTap,
    this.icon,
    this.trailing,
    this.padding,
    required this.thisItem,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    Widget tileBody = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).listTileTheme.iconColor,
                ),
                const SizedBox(width: 16),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (subtitle != null || subtitleWidget != null) ...[
                      const SizedBox(height: 5),
                      if (subtitle == null && subtitleWidget != null) subtitleWidget!,
                      if (subtitle != null && subtitleWidget == null) Text(
                        subtitle!,
                        style: TextStyle(
                          color: Theme.of(context).listTileTheme.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          trailing!
        ]
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: thisItem == selectedItem 
                ? Theme.of(context).colorScheme.primaryContainer
                : null
            ),
            child: tileBody
          ),
        ),
      ),
    );
  }
}