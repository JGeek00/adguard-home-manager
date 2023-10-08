import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpInterfaceItem extends StatelessWidget {
  final NetworkInterface networkInterface;
  final void Function(NetworkInterface) onSelect;

  const DhcpInterfaceItem({
    Key? key,
    required this.networkInterface,
    required this.onSelect
  }) : super(key: key);

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
                  children: [
                    Text(
                      "Flags: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Text(
                      networkInterface.flags.join(', '),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
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