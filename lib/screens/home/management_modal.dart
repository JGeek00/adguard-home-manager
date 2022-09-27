import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class ManagementModal extends StatelessWidget {
  const ManagementModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    Widget mainSwitch() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: () => {},
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
                    onChanged: (value) => {},
                    activeColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget smallSwitch(String label, bool value, Function(bool) onChange) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Switch(
                  value: value, 
                  onChanged: onChange,
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
                  Icons.shield,
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
                false, 
                (p0) => null
              ),
              smallSwitch(
                AppLocalizations.of(context)!.safeBrowsing,
                false, 
                (p0) => null
              ),
              smallSwitch(
                AppLocalizations.of(context)!.parentalFiltering,
                false, 
                (p0) => null
              ),
              smallSwitch(
                AppLocalizations.of(context)!.safeSearch,
                false, 
                (p0) => null
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