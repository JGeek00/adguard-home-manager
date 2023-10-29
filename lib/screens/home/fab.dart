import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/home/management_modal.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void openManagementBottomSheet() {
      if (width > 700) {
        showDialog(
          context: context,
          builder: (context) => const ManagementModal(
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          isScrollControlled: true,
          useRootNavigator: true,
          builder: (context) => const ManagementModal(
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
        );
      }
    }

    return statusProvider.loadStatus == LoadStatus.loaded
      ? FloatingActionButton(
          onPressed: openManagementBottomSheet,
          child: const Icon(Icons.shield_rounded),
        )
      : const SizedBox();
  }
}