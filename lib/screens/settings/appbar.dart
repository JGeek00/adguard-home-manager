import 'package:flutter/material.dart';

class SettingsAppBar extends StatelessWidget with PreferredSizeWidget {
  const SettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/icon1024-white-center.png',
            width: 60,
          ),
          const SizedBox(width: 20),
          const Text(
            "AdGuard Home Manager",
            style: TextStyle(
              fontSize: 22
            ),
          )
        ],
      )
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(80);
}