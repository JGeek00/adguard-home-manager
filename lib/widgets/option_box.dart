import 'package:flutter/material.dart';

class OptionBox extends StatelessWidget {
  final Widget child;
  final dynamic optionsValue;
  final dynamic itemValue;
  final void Function(dynamic) onTap;

  const OptionBox({
    Key? key,
    required this.child,
    required this.optionsValue,
    required this.itemValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => onTap(itemValue),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: optionsValue == itemValue
                ? Theme.of(context).primaryColor
                : Colors.grey
            ),
            color: optionsValue == itemValue
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}