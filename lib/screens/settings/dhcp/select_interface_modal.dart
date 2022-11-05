import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class SelectInterfaceModal extends StatelessWidget {
  final List<NetworkInterface> interfaces;
  final ScrollController scrollController;
  final void Function(NetworkInterface) onSelect;

  const SelectInterfaceModal({
    Key? key,
    required this.interfaces,
    required this.scrollController,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28)
        )
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Icon(
                    Icons.settings_ethernet_rounded,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.selectInterface,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: interfaces.length,
                  itemBuilder: (context, index) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onSelect(interfaces[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              interfaces[index].name,
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
                                  interfaces[index].hardwareAddress,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            if (interfaces[index].flags.isNotEmpty) ...[
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
                                    interfaces[index].flags.join(', '),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                            if (interfaces[index].gatewayIp != '') ...[
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
                                    interfaces[index].gatewayIp,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                            if (interfaces[index].ipv4Addresses.isNotEmpty) ...[
                              Row(
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)!.ipv4addresses}: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                  Text(
                                    interfaces[index].ipv4Addresses.join(', '),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                            if (interfaces[index].ipv6Addresses.isNotEmpty) ...[
                              Row(
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)!.ipv4addresses}: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                  Text(
                                    interfaces[index].ipv6Addresses.join(', '),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.cancel)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}