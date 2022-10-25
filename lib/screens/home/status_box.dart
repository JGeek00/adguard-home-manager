import 'package:flutter/material.dart';

class StatusBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;

  const StatusBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(12),
      width: double.maxFinite,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isEnabled == true 
          ? Colors.green
          : Colors.red,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}