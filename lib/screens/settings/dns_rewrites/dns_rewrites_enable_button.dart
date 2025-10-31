import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';

class DnsRewriteEnableButton extends StatelessWidget {
  final bool enabled;
  final void Function(bool) setEnabled;

  const DnsRewriteEnableButton({
    super.key,
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
          onTap: () => setEnabled(!enabled),
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
                      AppLocalizations.of(context)!.enableDnsRewriteRules,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                    
                  ],
                ),
                Switch(
                  value: enabled, 
                  onChanged: setEnabled,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}