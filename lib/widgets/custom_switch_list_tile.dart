import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String title;
  final String? subtitle;
  final bool? disabled;
  final EdgeInsets? padding;
  final IconData? leadingIcon;

  const CustomSwitchListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.disabled,
    this.subtitle,
    this.padding,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled != null && disabled == true
          ? null
          : () => onChanged(!value),
        child: Padding(
          padding: padding ?? const EdgeInsets.only(
            top: 12, left: 16, right: 18, bottom: 16
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabled != null && disabled == true
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (subtitle != null) ... [
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-110,
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabled != null && disabled == true
                              ? Theme.of(context).listTileTheme.textColor!.withOpacity(0.38)
                              : Theme.of(context).listTileTheme.textColor
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: value, 
                onChanged: disabled != null && disabled == true
                  ? null
                  : onChanged,
              )
            ],
          ),
        ),
      ),
    );
  }
}