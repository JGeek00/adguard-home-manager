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
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      ),
                      const SizedBox(width: 20),
                    ],
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          if (subtitle != null || subtitleWidget != null) ...[
                            const SizedBox(height: 5),
                            if (subtitle == null && subtitleWidget != null) subtitleWidget!,
                            if (subtitle != null && subtitleWidget == null) Text(
                              subtitle!,
                              style: TextStyle(
                                color: Theme.of(context).listTileTheme.iconColor,
                                fontSize: 14
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