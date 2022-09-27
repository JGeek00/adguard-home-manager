import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int)? onChange;
  final Color backgroundColor;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    this.onChange,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: value == groupValue 
              ? Theme.of(context).primaryColor
              : Theme.of(context).brightness == Brightness.dark
                ? const Color.fromRGBO(184, 184, 184, 1)
                : const Color.fromRGBO(104, 104, 104, 1)
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: backgroundColor
          ),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: value == groupValue 
              ? Theme.of(context).primaryColor
              : backgroundColor
          ),
        ),
      ],
    );
  }
}