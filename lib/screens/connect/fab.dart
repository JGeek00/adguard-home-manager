import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/add_server/add_server_functions.dart';

class FabConnect extends StatelessWidget {
  const FabConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    void openAddServerModal() async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        openServerFormModal(context: context, width: width)
      }));
    }

    return FloatingActionButton(
      onPressed: openAddServerModal,
      child: const Icon(Icons.add_rounded),
    );
  }
}