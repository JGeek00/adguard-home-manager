import 'package:flutter/material.dart';

class ProcessDialog extends StatelessWidget {
  final String message;

  const ProcessDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 30
          ),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 40),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }
}