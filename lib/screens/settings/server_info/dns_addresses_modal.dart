import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';

class DnsAddressesModal extends StatelessWidget {
  final bool isDialog;
  final List<String> dnsAddresses;

  const DnsAddressesModal({
    super.key,
    required this.isDialog,
    required this.dnsAddresses,
  });

  @override
  Widget build(BuildContext context) {
    if (isDialog == true) {
      return AlertDialog(
        title: Column(
          children: [
            Icon(
              Icons.route_rounded,
              color: Theme.of(context).listTileTheme.iconColor
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.dnsAddresses,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface
              ),
            )
          ],
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Wrap(
              children: dnsAddresses.map((address) => ListTile(
                title: Text(
                  address,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).listTileTheme.textColor
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close)
          )
        ],
      );
    }
    else {
      return ListBottomSheet(
        icon: Icons.route_rounded,
        title: AppLocalizations.of(context)!.dnsAddresses,
        children: dnsAddresses.map((address) => CustomListTile(
          title: address,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        )).toList(),
      );
    }
  }
}