import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final int index;
  final int total;
  final Color color;
  final int numericValue;
  final int? selectedValue;
  final void Function(int) onChanged;

  const ColorItem({
    super.key,
    required this.index,
    required this.total,
    required this.color,
    required this.numericValue,
    required this.selectedValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index == 0
        ? const EdgeInsets.only(top: 10, right: 10, bottom: 10)
        : index == total-1
          ? const EdgeInsets.only(top: 10, bottom: 10, left: 10)
          : const EdgeInsets.all(10),
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