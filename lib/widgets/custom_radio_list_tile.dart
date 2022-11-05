import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/custom_radio.dart';

class CustomRadioListTile extends StatelessWidget {
  final String groupValue;
  final String value;
  final Color radioBackgroundColor;
  final String title;
  final String? subtitle;
  final void Function(String) onChanged;

  const CustomRadioListTile({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.radioBackgroundColor,
    required this.title,
    this.subtitle,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: 12
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              CustomRadio(
                value: value, 
                groupValue: groupValue, 
                backgroundColor: radioBackgroundColor,
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-110,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-110,
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          color: Theme.of(context).listTileTheme.textColor,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ] 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}