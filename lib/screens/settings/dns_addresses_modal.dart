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
          const Icon(Icons.route_rounded),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.dnsAddresses)
        ],
      ),
      content: SizedBox(
        height: dnsAddresses.length*56 < 500
          ? dnsAddresses.length*56 : 500,
        width: double.minPositive,
        child: ListView(
          children: dnsAddresses.map((address) => ListTile(
            title: Text(address),
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