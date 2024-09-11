import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChange;
  final Color backgroundColor;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChange,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: value == groupValue 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).brightness == Brightness.dark
                ? const Color.fromRGBO(184, 184, 184, 1)
                : const Color.fromRGBO(104, 104, 104, 1)
          ),
        ),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: backgroundColor
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 9.5,
          height: 9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: value == groupValue 
              ? Theme.of(context).colorScheme.primary
              : backgroundColor
          ),
        ),
      ],
    );
  }
}