import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Status extends StatelessWidget {
  final bool valid;
  final String label;

  const Status({
    Key? key,
    required this.valid,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: valid == true
                ? appConfigProvider.useThemeColorForStatus == true
                  ? Theme.of(context).colorScheme.primary
                  : Colors.green
                : appConfigProvider.useThemeColorForStatus == true
                  ? Colors.grey
                  : Colors.red
            ),
          ),
          const SizedBox(width: 20),
          Flexible(child: Text(label))
        ],
      ),
    );
  }
}