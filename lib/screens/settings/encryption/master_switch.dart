import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EncryptionMasterSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool) onChange;

  const EncryptionMasterSwitch({
    super.key,
    required this.value,
    required this.onChange
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
          onTap: () => onChange(!value),
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.enableEncryption,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        AppLocalizations.of(context)!.enableEncryptionTypes,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).listTileTheme.textColor
                        ),
                      )
                    ],
                  ),
                ),
                Switch(
                  value: value, 
                  onChanged: (value) => onChange(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}