import 'package:flutter/material.dart';

class SmallSwitch extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value; 
  final void Function(bool) onChange;
  final bool disabled;

  const SmallSwitch({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChange,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled == false
          ? () => onChange(!value)
          : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 44,
            vertical: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: Theme.of(context).listTileTheme.iconColor,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Switch(
                value: value, 
                onChanged: disabled == false
                  ? onChange
                  : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}