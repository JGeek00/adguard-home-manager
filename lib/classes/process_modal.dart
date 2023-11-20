import 'package:adguard_home_manager/config/globals.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/process_dialog.dart';

class ProcessModal {
  void open(String message) async {
    await Future.delayed(const Duration(seconds: 0), () => {
      showDialog(
        context: globalNavigatorKey.currentContext!, 
        builder: (ctx) {
          return ProcessDialog(
            message: message,
          );
        },
        barrierDismissible: false,
        useSafeArea: true,
      )
    });
  }

  void close() {
    Navigator.pop(globalNavigatorKey.currentContext!);
  }
}