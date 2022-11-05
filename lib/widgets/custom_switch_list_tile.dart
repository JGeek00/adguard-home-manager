import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String title;
  final String? subtitle;
  final bool? disabled;

  const CustomSwitchListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.disabled,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled != null && disabled == true
          ? null
          : () => onChanged(!value),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12, left: 24, right: 12, bottom: 12
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-110,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabled != null && disabled == true
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
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
              Switch(
                value: value, 
                onChanged: disabled != null && disabled == true
                  ? null
                  : onChanged,
                activeColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}