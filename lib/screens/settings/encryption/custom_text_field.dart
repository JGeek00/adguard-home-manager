import 'package:flutter/material.dart';

class EncryptionTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final IconData icon;
  final void Function(String) onChanged;
  final String? errorText;
  final String label;
  final TextInputType? keyboardType;
  final bool? multiline;
  final String? helperText;

  const EncryptionTextField({
    Key? key,
    required this.enabled,
    required this.controller,
    required this.icon,
    required this.onChanged,
    this.errorText,
    required this.label,
    this.keyboardType,
    this.multiline,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: width > 900
        ? const EdgeInsets.symmetric(horizontal: 8)
        : const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 200
        ),
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10)
              )
            ),
            errorText: errorText,
            labelText: label,
            helperText: helperText,
            helperMaxLines: 10,
            helperStyle: TextStyle(
              color: Theme.of(context).listTileTheme.iconColor
            )
          ),
          keyboardType: TextInputType.multiline,
          maxLines: multiline == true ? null : 1,
        ),
      ),
    );
  }
}