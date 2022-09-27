// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class ManagementModal extends StatelessWidget {
  const ManagementModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    void updateBlocking(bool value, String filter) async {
      final result = await serversProvider.updateBlocking(
        serversProvider.selectedServer!,
        filter, 
        value
      );
      if (result == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.invalidUsernamePassword),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    Widget mainSwitch() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: serversProvider.protectionsManagementProcess.contains('general') == false
              ? () => updateBlocking(!serversProvider.serverStatus.data!.generalEnabled, 'general')
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
                  Text(
                    AppLocalizations.of(context)!.allProtections,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                    value: serversProvider.serverStatus.data!.generalEnabled, 
                    onChanged: serversProvider.protectionsManagementProcess.contains('general') == false
                      ? (value) => updateBlocking(value, 'general')
                      : null,
                    activeColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget smallSwitch(String label, IconData icon, bool value, Function(bool) onChange, bool disabled) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled == false
            ? () => onChange(!value)
            : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 24,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: value, 
                  onChanged: disabled == false
                    ? onChange
                    : null,
                  activeColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.maxFinite,
      height: 540,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28)
        )
      ),
      child: Column(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Icon(
                  Icons.shield_rounded,
                  size: 26,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  AppLocalizations.of(context)!.manageServer,
                  style: const TextStyle(
                    fontSize: 22
                  ),
                ),
              ),
              mainSwitch(),
              const SizedBox(height: 10),
              smallSwitch(
                AppLocalizations.of(context)!.ruleFiltering,
                Icons.filter_list_rounded,
                serversProvider.serverStatus.data!.filteringEnabled, 
                (value) => updateBlocking(value, 'filtering'),
                serversProvider.protectionsManagementProcess.contains('filtering')
              ),
              smallSwitch(
                AppLocalizations.of(context)!.safeBrowsing,
                Icons.vpn_lock_rounded,
                serversProvider.serverStatus.data!.safeBrowsingEnabled, 
                (value) => updateBlocking(value, 'safeBrowsing'),
                serversProvider.protectionsManagementProcess.contains('safeBrowsing')
              ),
              smallSwitch(
                AppLocalizations.of(context)!.parentalFiltering,
                Icons.block,
                serversProvider.serverStatus.data!.parentalControlEnabled, 
                (value) => updateBlocking(value, 'parentalControl'),
                serversProvider.protectionsManagementProcess.contains('parentalControl')
              ),
              smallSwitch(
                AppLocalizations.of(context)!.safeSearch,
                Icons.search_rounded,
                serversProvider.serverStatus.data!.safeSearchEnabled, 
                (value) => updateBlocking(value, 'safeSearch'),
                serversProvider.protectionsManagementProcess.contains('safeSearch')
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.close),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}