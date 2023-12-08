import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpMainButton extends StatelessWidget {
  final NetworkInterface? selectedInterface;
  final bool enabled;
  final void Function(bool) setEnabled;

  const DhcpMainButton({
    super.key,
    required this.selectedInterface,
    required this.enabled,
    required this.setEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 16, 
        right: 16
      ),
      child: Material(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: selectedInterface != null
            ? () => setEnabled(!enabled)
            : null,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.enableDhcpServer,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                    if (selectedInterface != null) ...[
                      Text(
                        selectedInterface!.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).listTileTheme.textColor
                        ),
                      )
                    ]
                  ],
                ),
                Switch(
                  value: enabled, 
                  onChanged: selectedInterface != null
                    ? (value) => setEnabled(value)
                    : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}