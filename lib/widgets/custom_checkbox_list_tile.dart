import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String title;
  final String? subtitle;
  final bool? disabled;
  final EdgeInsets? padding;

  const CustomCheckboxListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.disabled,
    this.subtitle,
    this.padding
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
          padding: padding ?? const EdgeInsets.only(
            top: 12, left: 16, right: 18, bottom: 16
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: disabled == true
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onSurface,
                  disabledColor: Colors.grey
                ),
                child: Checkbox(
                  value: value, 
                  onChanged: (value) => disabled != null && disabled == true && value != null
                    ? null
                    : onChanged(value!),
                  tristate: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: disabled == true
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}