import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BootstrapDnsScreen extends StatefulWidget {
  const BootstrapDnsScreen({Key? key}) : super(key: key);

  @override
  State<BootstrapDnsScreen> createState() => _BootstrapDnsScreenState();
}

class _BootstrapDnsScreenState extends State<BootstrapDnsScreen> {
  List<TextEditingController> bootstrapControllers = [
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bootstrapDns),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Card(
            margin: const EdgeInsets.only(
              left: 24, right: 24, bottom: 20
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.info_rounded),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-132,
                    child: Text(AppLocalizations.of(context)!.bootstrapDnsServersInfo)
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (bootstrapControllers.isEmpty) Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noBootstrapDns,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          ...bootstrapControllers.map((c) => Padding(
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
                      labelText: AppLocalizations.of(context)!.dnsServer,
                    )
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => bootstrapControllers = bootstrapControllers.where((con) => con != c).toList()), 
                  icon: const Icon(Icons.remove_circle_outline)
                )
              ],
            ),
          )).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => bootstrapControllers.add(TextEditingController())), 
                icon: const Icon(Icons.add), 
                label: Text(AppLocalizations.of(context)!.addItem)
              ),
            ],
          ),
        ],
      ),
    );
  }
}