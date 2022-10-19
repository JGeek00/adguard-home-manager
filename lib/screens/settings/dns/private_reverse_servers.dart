import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

class PrivateReverseDnsServersScreen extends StatefulWidget {
  const PrivateReverseDnsServersScreen({Key? key}) : super(key: key);

  @override
  State<PrivateReverseDnsServersScreen> createState() => _PrivateReverseDnsServersScreenState();
}

class _PrivateReverseDnsServersScreenState extends State<PrivateReverseDnsServersScreen> {
  List<TextEditingController> privateControllers = [];

  List<String> defaultReverseResolvers = ["80.58.61.250", "80.58.61.251"];
  bool editReverseResolvers = false;
  List<TextEditingController> reverseResolversControllers = [
    TextEditingController()
  ];
  bool usePrivateReverseDnsResolvers = false;
  bool enableReverseResolve = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privateReverseDnsServers),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Card(
            margin: const EdgeInsets.only(
              left: 24, right: 24, bottom: 10
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.info_rounded),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-132,
                    child: Text(AppLocalizations.of(context)!.privateReverseDnsServersDescription)
                  )
                ],
              ),
            ),
          ),
          if (editReverseResolvers == false) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "${AppLocalizations.of(context)!.reverseDnsDefault}:\n\n${defaultReverseResolvers.map((item) => item).join(', ').toString().replaceAll(RegExp(r'\(|\)'), '')}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => editReverseResolvers = true), 
                    icon: const Icon(Icons.edit), 
                    label: Text(AppLocalizations.of(context)!.edit)
                  ),
                ],
              ),
            )
          ],
          if (editReverseResolvers == true) ...[
            const SizedBox(height: 20),
            ...reverseResolversControllers.map((c) => Padding(
            padding: const EdgeInsets.only(
                left: 24, right: 10, bottom: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-90,
                    child: TextFormField(
                      controller: c,
                      // onChanged: (_) => checkValidValues(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.dns_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        labelText: AppLocalizations.of(context)!.serverAddress,
                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => reverseResolversControllers = reverseResolversControllers.where((con) => con != c).toList()), 
                    icon: const Icon(Icons.remove_circle_outline)
                  )
                ],
              ),
            )),
            if (reverseResolversControllers.isEmpty) Padding(
              padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 20
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.noServerAddressesAdded,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => reverseResolversControllers.add(TextEditingController())), 
                    icon: const Icon(Icons.add), 
                    label: Text(AppLocalizations.of(context)!.addItem)
                  ),
                ],
              ),
            ),
          ],
          CustomSwitchListTile(
            value: usePrivateReverseDnsResolvers,
            onChanged: (value) => setState(() => usePrivateReverseDnsResolvers = value), 
            title: AppLocalizations.of(context)!.usePrivateReverseDnsResolvers,
            subtitle: AppLocalizations.of(context)!.usePrivateReverseDnsResolversDescription
          ),
          CustomSwitchListTile(
            value: enableReverseResolve,
            onChanged: (value) => setState(() => enableReverseResolve = value), 
            title: AppLocalizations.of(context)!.enableReverseResolving,
            subtitle: AppLocalizations.of(context)!.enableReverseResolvingDescription
          ),
        ],
      ),
    );
  }
}