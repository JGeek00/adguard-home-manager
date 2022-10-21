import 'package:flutter/material.dart';

class LogListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Widget? trailing;

  const LogListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 24,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 5),
                  subtitleWidget ?? SizedBox(
                    width: width-100,
                    child: Text(
                      subtitle!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).listTileTheme.iconColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          if (trailing != null) trailing!
        ],
      ),
    );
  }
}