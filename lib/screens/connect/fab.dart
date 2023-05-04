import 'package:adguard_home_manager/widgets/add_server_modal.dart';
import 'package:flutter/material.dart';

class FabConnect extends StatelessWidget {
  const FabConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    void openAddServerModal() async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        if (width > 700) {
          showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (context) => const AddServerModal(
              window: true,
            ),
          )
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => const AddServerModal(
              window: false,
            )
          ))
        }
      }));
    }

    return FloatingActionButton(
      onPressed: openAddServerModal,
      child: const Icon(Icons.add_rounded),
    );
  }
}