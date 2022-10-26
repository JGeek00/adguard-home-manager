import 'package:adguard_home_manager/widgets/add_server_modal.dart';
import 'package:flutter/material.dart';

class FabConnect extends StatelessWidget {
  const FabConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openAddServerModal() async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => const AddServerModal()
        ))
      }));
    }

    return FloatingActionButton(
      onPressed: openAddServerModal,
      child: Icon(
        Icons.add_rounded,
        color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      ),
    );
  }
}