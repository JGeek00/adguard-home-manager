import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/functions/desktop_mode.dart';

class DhcpNotAvailable extends StatelessWidget {
  const DhcpNotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dhcpSettings),
        centerTitle: false,
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.dhcpNotAvailable,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24
              ),
            ),
            const SizedBox(height: 20),
             Text(
              AppLocalizations.of(context)!.osServerInstalledIncompatible,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant
              ),
            ),
          ],
        ),
      ),
    );
  }
}