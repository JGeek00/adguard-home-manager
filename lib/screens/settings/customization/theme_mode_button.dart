import 'package:flutter/material.dart';

class ThemeModeButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final int selected;
  final String label;
  final void Function(int) onChanged;

  const ThemeModeButton({
    Key? key,
    required this.icon,
    required this.value,
    required this.selected,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          padding: const EdgeInsets.all(10),
          width: 150,
          height: 150,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: value == selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1),
            border: Border.all(
              color: Theme.of(context).primaryColor
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: value == selected
                  ? Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
                  : null,
                size: 30,
              ),
              Text(
                label,
                style: TextStyle(
                  color: value == selected
                    ? Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
                    : null,
                  fontSize: 18
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}