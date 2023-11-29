import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/status_box.dart';

import 'package:adguard_home_manager/models/server_status.dart';

class ServerStatusWidget extends StatelessWidget {
  final ServerStatus serverStatus;

  const ServerStatusWidget({
    super.key,
    required this.serverStatus,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    double boxSize() {
      if (textScaleFactor < 1 || (textScaleFactor >= 1 && textScaleFactor < 1.15)) {
        return 65;
      }
      else if (textScaleFactor >= 1.15 && textScaleFactor < 1.3) {
        return 75;
      }
      else if (textScaleFactor >= 1.3 && textScaleFactor < 1.45) {
        return 80;
      }
      else if (textScaleFactor >= 1.45 && textScaleFactor < 1.6) {
        return 85;
      }
      else if (textScaleFactor >= 1.6 && textScaleFactor < 1.85) {
        return 100;
      }
      else if (textScaleFactor >= 1.85) {
        return 110;
      }
      else {
        return 65;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.serverStatus,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          const SizedBox(height: 16),
          GridView(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > 700 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: boxSize()
            ),
            children: [
              StatusBox(
                icon: Icons.filter_list_rounded, 
                label: AppLocalizations.of(context)!.ruleFilteringWidget, 
                isEnabled: serverStatus.filteringEnabled
              ),
              StatusBox(
                icon: Icons.vpn_lock_rounded, 
                label: AppLocalizations.of(context)!.safeBrowsingWidget, 
                isEnabled: serverStatus.safeBrowsingEnabled
              ),
              StatusBox(
                icon: Icons.block, 
                label: AppLocalizations.of(context)!.parentalFilteringWidget, 
                isEnabled: serverStatus.parentalControlEnabled
              ),
              StatusBox(
                icon: Icons.search_rounded, 
                label: AppLocalizations.of(context)!.safeSearchWidget, 
                isEnabled: serverStatus.safeSearchEnabled
              ),
            ],
          )
        ],
      ),
    );
  }
}