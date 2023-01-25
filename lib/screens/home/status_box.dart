import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class StatusBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;

  const StatusBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return AnimatedContainer(
      padding: const EdgeInsets.all(12),
      width: double.maxFinite,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isEnabled == true 
          ? appConfigProvider.useThemeColorForStatus == true
            ? Theme.of(context).colorScheme.primary
            : Colors.green
          : appConfigProvider.useThemeColorForStatus == true
            ? Colors.grey
            : Colors.red,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: appConfigProvider.useThemeColorForStatus == true
              ? Theme.of(context).colorScheme.primary.computeLuminance() > 0.5 ? Colors.black : Colors.white
              : Colors.grey.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: appConfigProvider.useThemeColorForStatus == true
                ? Theme.of(context).colorScheme.primary.computeLuminance() > 0.5 ? Colors.black : Colors.white
                : Colors.grey.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}