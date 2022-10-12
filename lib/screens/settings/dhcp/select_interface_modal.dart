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
          const Padding(
            padding: EdgeInsets.only(top: 28),
            child: Icon(
              Icons.settings_ethernet_rounded,
              size: 26,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.selectInterface,
            style: const TextStyle(
              fontSize: 24
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
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
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          interfaces[index].name,
                          style: const TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.hardwareAddress}: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(interfaces[index].hardwareAddress),
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (interfaces[index].flags.isNotEmpty) ...[
                          Row(
                            children: [
                              const Text(
                                "Flags: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(interfaces[index].flags.join(', ')),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                        if (interfaces[index].gatewayIp != '') ...[
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.gatewayIp}: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(interfaces[index].gatewayIp),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                        if (interfaces[index].ipv4Addresses.isNotEmpty) ...[
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.ipv4addresses}: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(interfaces[index].ipv4Addresses.join(', ')),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                        if (interfaces[index].ipv6Addresses.isNotEmpty) ...[
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.ipv4addresses}: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(interfaces[index].ipv6Addresses.join(', ')),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              )
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