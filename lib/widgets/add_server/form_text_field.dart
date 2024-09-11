import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? error;
  final IconData icon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool? obscureText;
  final String? hintText;
  final String? helperText;
  final bool isConnecting;

  const FormTextField({
    super.key,
    required this.label,
    required this.controller,
    this.error,
    required this.icon,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
    this.hintText,
    this.helperText,
    required this.isConnecting
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        enabled: !isConnecting,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          errorText: error,
          hintText: hintText,
          helperText: helperText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            )
          ),
          labelText: label,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}