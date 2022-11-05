import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DnsAddressesModal extends StatelessWidget {
  final List<String> dnsAddresses;

  const DnsAddressesModal({
    Key? key,
    required this.dnsAddresses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      content: SizedBox(
        height: dnsAddresses.length*56 < 500
          ? dnsAddresses.length*56 : 500,
        width: double.minPositive,
        child: ListView(
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.close)
        )
      ],
    );
  }
}