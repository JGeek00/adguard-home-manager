import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';

class BlockedServicesSection extends StatelessWidget {
  final bool useGlobalSettingsServices;
  final List<String> blockedServices;
  final void Function(List<String>) onUpdatedBlockedServices;
  final void Function(bool) onUpdateServicesGlobalSettings;

  const BlockedServicesSection({
    super.key,
    required this.useGlobalSettingsServices,
    required this.blockedServices,
    required this.onUpdatedBlockedServices,
    required this.onUpdateServicesGlobalSettings
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              onTap: () => onUpdateServicesGlobalSettings(!useGlobalSettingsServices),
              borderRadius: BorderRadius.circular(28),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.useGlobalSettings,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ),
                    Switch(
                      value: useGlobalSettingsServices, 
                      onChanged: (value) => onUpdateServicesGlobalSettings(value),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: useGlobalSettingsServices == false
              ? () => openServicesModal(
                  context: context,
                  blockedServices: blockedServices,
                  onUpdateBlockedServices: onUpdatedBlockedServices
                )
              : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 32
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.public,
                    color: useGlobalSettingsServices == false
                      ? Theme.of(context).listTileTheme.iconColor
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectBlockedServices,
                          style: TextStyle(
                            fontSize: 16,
                            color: useGlobalSettingsServices == false
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                          ),
                        ),
                        if (useGlobalSettingsServices == false) ...[
                          const SizedBox(height: 5),
                          Text(
                            blockedServices.isNotEmpty
                              ? "${blockedServices.length} ${AppLocalizations.of(context)!.servicesBlocked}"
                              :  AppLocalizations.of(context)!.noBlockedServicesSelected,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.iconColor  
                            ),
                          )
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}