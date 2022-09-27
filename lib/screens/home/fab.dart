import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/home/management_modal.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void openManagementBottomSheet() {
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => const ManagementModal(),
        backgroundColor: Colors.transparent,
      );
    }

    return FloatingActionButton(
      onPressed: openManagementBottomSheet,
      child: const Icon(Icons.shield_rounded),
    );
  }
}