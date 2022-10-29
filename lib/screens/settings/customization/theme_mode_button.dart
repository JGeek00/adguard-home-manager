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

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: disabled == null || disabled == false
          ? () => onChanged(value)
          : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          padding: const EdgeInsets.all(10),
          width: 150,
          height: 150,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: value == selected
              ? disabled == null || disabled == false
                ? Theme.of(context).primaryColor
                : greyBackgroundColor
              : disabled == null || disabled == false
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : greyBackgroundColor,
            border: Border.all(
              color: disabled == null || disabled == false
                ? Theme.of(context).primaryColor
                : greyBackgroundColor
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: value == selected
                  ? disabled == null || disabled == false
                    ? Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
                    : greyIconColor
                  : disabled == null || disabled == false
                    ? null
                    : greyIconColor,
                size: 30,
              ),
              Text(
                label,
                style: TextStyle(
                  color: value == selected
                    ? disabled == null || disabled == false
                        ? Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
                        : greyIconColor
                      : disabled == null || disabled == false
                        ? null
                        : greyIconColor,
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