// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard({
  required BuildContext context,
  required String value,
  required String successMessage
}) async {
  await Clipboard.setData(
    ClipboardData(text: value)
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(successMessage),
      backgroundColor: Colors.green,
    )
  );
}