import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final int numericValue;
  final int? selectedValue;
  final void Function(int) onChanged;

  const ColorItem({
    Key? key,
    required this.color,
    required this.numericValue,
    required this.selectedValue,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: () => onChanged(numericValue),
          borderRadius: BorderRadius.circular(50),
          overlayColor: const MaterialStatePropertyAll(Colors.grey),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50)
            ),
            child: AnimatedOpacity(
              opacity: numericValue == selectedValue ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Icon(
                Icons.check,
                size: 30,
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}