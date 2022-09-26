import 'package:flutter/material.dart';

class CustomRadioToggle extends StatelessWidget {
  final String groupSelected;
  final String value;
  final String label;
  final void Function(String) onTap;

  const CustomRadioToggle({
    Key? key,
    required this.groupSelected,
    required this.value,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(value),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5
          ),
          decoration: BoxDecoration(
            color: groupSelected == value 
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.05),
            border: Border.all(
              color: Theme.of(context).primaryColor
            ),
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            children: [
              if (groupSelected == value) ...[
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: groupSelected == value
                    ? Colors.white
                    : null
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}