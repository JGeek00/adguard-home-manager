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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: bold == true ? FontWeight.bold : FontWeight.w400
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