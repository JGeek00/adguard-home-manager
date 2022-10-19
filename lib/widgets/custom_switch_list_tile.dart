import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String title;
  final String? subtitle;

  const CustomSwitchListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20, left: 24, right: 10, bottom: 20
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
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (subtitle != null) ... [
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-110,
                      child: Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              Switch(
                value: value, 
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}