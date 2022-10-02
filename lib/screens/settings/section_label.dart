import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({
    Key? key,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).primaryColor
            ),
          ),
        ),
      ],
    );
  }
}