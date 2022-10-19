import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class BootstrapDnsScreen extends StatefulWidget {
  final ServersProvider serversProvider;

  const BootstrapDnsScreen({
    Key? key,
    required this.serversProvider,
  }) : super(key: key);

  @override
  State<BootstrapDnsScreen> createState() => _BootstrapDnsScreenState();
}

class _BootstrapDnsScreenState extends State<BootstrapDnsScreen> {
  List<Map<String, dynamic>> bootstrapControllers = [];

  bool validValues = false;

  void validateIp(Map<String, dynamic> field, String value) {
    RegExp ipAddress = RegExp(r'(?:^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}$)|(?:^(?:(?:[a-fA-F\d]{1,4}:){7}(?:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){6}(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){5}(?::(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,2}|:)|(?:[a-fA-F\d]{1,4}:){4}(?:(?::[a-fA-F\d]{1,4}){0,1}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,3}|:)|(?:[a-fA-F\d]{1,4}:){3}(?:(?::[a-fA-F\d]{1,4}){0,2}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,4}|:)|(?:[a-fA-F\d]{1,4}:){2}(?:(?::[a-fA-F\d]{1,4}){0,3}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,5}|:)|(?:[a-fA-F\d]{1,4}:){1}(?:(?::[a-fA-F\d]{1,4}){0,4}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,6}|:)|(?::(?:(?::[a-fA-F\d]{1,4}){0,5}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,7}|:)))(?:%[0-9a-zA-Z]{1,})?$)');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => field['error'] = null);
    }
    else {
      setState(() => field['error'] = AppLocalizations.of(context)!.invalidIp);
    }
    checkValidValues();
  }

  void checkValidValues() {
    if (
      bootstrapControllers.isNotEmpty &&
      bootstrapControllers.every((element) => element['controller'].text != '') &&
      bootstrapControllers.every((element) => element['error'] == null)
    ) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  @override
  void initState() {
    for (var item in widget.serversProvider.dnsInfo.data!.bootstrapDns) {
      final controller = TextEditingController();
      controller.text = item;
      bootstrapControllers.add({
        'controller': controller,
        'error': null
      });
    }
    validValues = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bootstrapDns),
        actions: [
          IconButton(
            onPressed: validValues == true
              ? () => {}
              : null, 
            icon: const Icon(Icons.save_rounded),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 10)
        ],
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
                    controller: c['controller'],
                    onChanged: (value) => validateIp(c, value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.dns_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      errorText: c['error'],
                      labelText: AppLocalizations.of(context)!.dnsServer,
                    )
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => bootstrapControllers = bootstrapControllers.where((con) => con != c).toList());
                    checkValidValues();
                  }, 
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
                onPressed: () {
                  setState(() => bootstrapControllers.add({
                    'controller': TextEditingController(),
                    'error': null
                  }));
                  checkValidValues();
                }, 
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