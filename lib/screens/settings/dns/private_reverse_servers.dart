// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class PrivateReverseDnsServersScreen extends StatefulWidget {
  final ServersProvider serversProvider;

  const PrivateReverseDnsServersScreen({
    Key? key,
    required this.serversProvider,
  }) : super(key: key);

  @override
  State<PrivateReverseDnsServersScreen> createState() => _PrivateReverseDnsServersScreenState();
}

class _PrivateReverseDnsServersScreenState extends State<PrivateReverseDnsServersScreen> {
  List<String> defaultReverseResolvers = [];
  bool editReverseResolvers = false;
  List<Map<String, dynamic>> reverseResolversControllers = [
    {
      'controller': TextEditingController(),
      'error': null
    }
  ];
  bool usePrivateReverseDnsResolvers = false;
  bool enableReverseResolve = false;

  bool validValues = false;

  void validateAddress(Map<String, dynamic> item ,String value) {
    RegExp ipAddress = RegExp(r'(?:^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}$)|(?:^(?:(?:[a-fA-F\d]{1,4}:){7}(?:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){6}(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|:[a-fA-F\d]{1,4}|:)|(?:[a-fA-F\d]{1,4}:){5}(?::(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,2}|:)|(?:[a-fA-F\d]{1,4}:){4}(?:(?::[a-fA-F\d]{1,4}){0,1}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,3}|:)|(?:[a-fA-F\d]{1,4}:){3}(?:(?::[a-fA-F\d]{1,4}){0,2}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,4}|:)|(?:[a-fA-F\d]{1,4}:){2}(?:(?::[a-fA-F\d]{1,4}){0,3}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,5}|:)|(?:[a-fA-F\d]{1,4}:){1}(?:(?::[a-fA-F\d]{1,4}){0,4}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,6}|:)|(?::(?:(?::[a-fA-F\d]{1,4}){0,5}:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)(?:\\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)){3}|(?::[a-fA-F\d]{1,4}){1,7}|:)))(?:%[0-9a-zA-Z]{1,})?$)');
    RegExp domain = RegExp(r'^((http|https|tls|udp|tcp|quic|sdns):\/\/)?([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
    if (ipAddress.hasMatch(value) == true || domain.hasMatch(value) == true) {
      setState(() => item['error'] = null);
    }
    else {
      setState(() => item['error'] = AppLocalizations.of(context)!.invalidIpDomain);
    }

    checkDataValid();
  }

  void checkDataValid() {
    if (
      (
        editReverseResolvers == true &&
        reverseResolversControllers.every((element) => element['controller'].text != '') &&
        reverseResolversControllers.every((element) => element['error'] == null)
      ) == true
    ) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  @override
  void initState() {
    for (var item in widget.serversProvider.dnsInfo.data!.defaultLocalPtrUpstreams) {
      defaultReverseResolvers.add(item);
    }
    for (var item in widget.serversProvider.dnsInfo.data!.localPtrUpstreams) {
      final controller = TextEditingController();
      controller.text = item;
      reverseResolversControllers = [{
        'controller': controller,
        'error': null
      }];
    }
    if (widget.serversProvider.dnsInfo.data!.localPtrUpstreams.isNotEmpty) {
      editReverseResolvers = true;
    }
    usePrivateReverseDnsResolvers = widget.serversProvider.dnsInfo.data!.usePrivatePtrResolvers;
    enableReverseResolve = widget.serversProvider.dnsInfo.data!.resolveClients;
    validValues = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void saveData() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await setDnsConfig(server: serversProvider.selectedServer!, data: editReverseResolvers == true
        ? {
          "local_ptr_upstreams": List<String>.from(reverseResolversControllers.map((e) => e['controller'].text)),
          "use_private_ptr_resolvers": usePrivateReverseDnsResolvers,
          "resolve_clients": enableReverseResolve
        } : {
          "use_private_ptr_resolvers": usePrivateReverseDnsResolvers,
          "resolve_clients": enableReverseResolve
        });

      processModal.close();

      if (result['result'] == 'success') {
        DnsInfoData data = serversProvider.dnsInfo.data!;
        if (editReverseResolvers == true) {
          data.localPtrUpstreams = List<String>.from(reverseResolversControllers.map((e) => e['controller'].text));
        }
        data.usePrivatePtrResolvers = usePrivateReverseDnsResolvers;
        data.resolveClients = enableReverseResolve;
        serversProvider.setDnsInfoData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigSaved, 
          color: Colors.green
        );
      }
      else if (result['log'] != null && result['log'].statusCode == '400') {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.someValueNotValid, 
          color: Colors.red
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsConfigNotSaved, 
          color: Colors.red
        );
      } 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privateReverseDnsServers),
        actions: [
          IconButton(
            onPressed: validValues == true
              ? () => saveData()
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
              left: 24, right: 24, bottom: 10
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.privateReverseDnsServersDescription,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    )
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
                    onPressed: () {
                      setState(() => editReverseResolvers = true);
                      checkDataValid();
                    }, 
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
                      controller: c['controller'],
                      onChanged: (value) => validateAddress(c, value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.dns_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: c['error'],
                        labelText: AppLocalizations.of(context)!.serverAddress,
                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => reverseResolversControllers = reverseResolversControllers.where((con) => con != c).toList());
                      checkDataValid();
                    }, 
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
                    onPressed: () {
                      setState(() => reverseResolversControllers.add({
                        'controller': TextEditingController(),
                        'error': null
                      }));
                      checkDataValid();
                    }, 
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