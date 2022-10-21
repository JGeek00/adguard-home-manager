import 'package:flutter/material.dart';

class FilterListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final bool? bold;

  const FilterListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
    this.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
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
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: color ?? Theme.of(context).listTileTheme.iconColor,
                    fontWeight: bold == true ? FontWeight.bold : null
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}