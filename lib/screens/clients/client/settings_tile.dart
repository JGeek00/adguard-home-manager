import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String label;
  final bool? value;
  final void Function(bool)? onChange;
  final bool useGlobalSettingsFiltering;

  const SettingsTile({
    Key? key,
    required this.label,
    required this.value,
    this.onChange,
    required this.useGlobalSettingsFiltering
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onChange != null
            ?  value != null ? () => onChange!(!value!) : null
            : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 42,
              vertical: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                useGlobalSettingsFiltering == false
                  ? Switch(
                      value: value!, 
                      onChanged: onChange,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12
                      ),
                      child: Text(
                        "Global",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    )
              ],
            ),
          ),
        ),
      );
  }
}