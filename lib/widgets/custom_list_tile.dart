import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function() onTap;
  final IconData? icon;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: const Color.fromRGBO(104, 104, 104, 1),
                ),
                const SizedBox(width: 20),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-84,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-84,
                      child: Text(
                        subtitle!,
                        style: const TextStyle(
                          color: Color.fromRGBO(104, 104, 104, 1),
                          fontSize: 14
                        ),
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}