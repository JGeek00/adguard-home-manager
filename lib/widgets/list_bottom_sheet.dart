import 'package:flutter/material.dart';

class ListBottomSheet extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;

  const ListBottomSheet({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
    this.initialChildSize,
    this.maxChildSize,
    this.minChildSize,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize ?? 0.6,
      minChildSize: minChildSize ?? 0.3,
      maxChildSize: maxChildSize ?? 1,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: ListView(
              controller: controller,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: 24,
                        color: Theme.of(context).listTileTheme.iconColor
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                ),
                ...children
              ],
            ),
          ),
        );
      },
    );
  }
}