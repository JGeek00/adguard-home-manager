import 'package:flutter/material.dart';

class MasterSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool) onChange;
  final EdgeInsets? margin;

  const MasterSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: () => onChange(!value),
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: value, 
                  onChanged: onChange,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}