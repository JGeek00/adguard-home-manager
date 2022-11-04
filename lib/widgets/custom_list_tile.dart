import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final void Function()? onTap;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsets? padding;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.onTap,
    this.icon,
    this.trailing,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          ),
        ),
      ),
    );
  }
}