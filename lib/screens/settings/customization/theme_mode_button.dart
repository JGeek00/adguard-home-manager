import 'package:flutter/material.dart';

class ThemeModeButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final int selected;
  final String label;
  final void Function(int) onChanged;
  final bool? disabled;

  const ThemeModeButton({
    Key? key,
    required this.icon,
    required this.value,
    required this.selected,
    required this.label,
    required this.onChanged,
    this.disabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color greyBackgroundColor = Theme.of(context).brightness == Brightness.light
      ?const Color.fromRGBO(200, 200, 200, 1)
      :const Color.fromRGBO(50, 50, 50, 1);
    final Color greyIconColor = Theme.of(context).brightness == Brightness.light
      ? const Color.fromRGBO(130, 130, 130, 1)
      : const Color.fromRGBO(100, 100, 100, 1);

    return ElevatedButton(
      onPressed: disabled == null || disabled == false
        ? () => onChanged(value)
        : null,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
        ),
        backgroundColor: MaterialStateProperty.all(
          value == selected
            ? disabled == null || disabled == false
              ? Theme.of(context).colorScheme.primary
              : greyBackgroundColor
            : disabled == null || disabled == false
              ? Theme.of(context).colorScheme.surfaceVariant
              : greyBackgroundColor,
        )
      ),
      child: AnimatedContainer(
        width: 118,
        height: 150,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: value == selected
                ? disabled == null || disabled == false
                  ? Theme.of(context).colorScheme.primary.computeLuminance() > 0.5 ? Colors.black : Colors.white
                  : greyIconColor
                : disabled == null || disabled == false
                  ? Theme.of(context).colorScheme.primary
                  : greyIconColor,
              size: 30,
            ),
            Text(
              label,
              style: TextStyle(
                color: value == selected
                  ? disabled == null || disabled == false
                      ? Theme.of(context).colorScheme.primary.computeLuminance() > 0.5 ? Colors.black : Colors.white
                      : greyIconColor
                    : disabled == null || disabled == false
                      ? Theme.of(context).colorScheme.primary
                      : greyIconColor,
                fontSize: 18
              ),
            )
          ],
        ),
      ),
    );
  }
}