import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpInterfaceItem extends StatelessWidget {
  final NetworkInterface networkInterface;
  final void Function(NetworkInterface) onSelect;

  const DhcpInterfaceItem({
    super.key,
    required this.networkInterface,
    required this.onSelect
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onSelect(networkInterface);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                networkInterface.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              Row(
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.hardwareAddress}: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  ),
                  Text(
                    networkInterface.hardwareAddress,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              if (networkInterface.flags.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flags: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Flexible(
                      child: Text(
                        networkInterface.flags.join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
              if (networkInterface.gatewayIp != null && networkInterface.gatewayIp != '') ...[
                Row(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.gatewayIp}: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Text(
                      networkInterface.gatewayIp!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
              if (networkInterface.ipv4Addresses.isNotEmpty) ...[
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${AppLocalizations.of(context)!.ipv4addresses}: ${networkInterface.ipv4Addresses.join(', ')}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
              ],
              if (networkInterface.ipv6Addresses.isNotEmpty) ...[
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${AppLocalizations.of(context)!.ipv6addresses}: ${networkInterface.ipv6Addresses.join(', ')}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      ),
                    )
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}