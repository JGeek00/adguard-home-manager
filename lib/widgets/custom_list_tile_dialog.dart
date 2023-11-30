import 'package:flutter/material.dart';

class CustomListTileDialog extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onTap;

  const CustomListTileDialog({
    super.key,
    required this.title,
    this.icon,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 24),
              ],
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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