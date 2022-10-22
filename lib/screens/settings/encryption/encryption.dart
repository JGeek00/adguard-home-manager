import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class EncryptionSettings extends StatelessWidget {
  const EncryptionSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return EncryptionSettingsWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}

class EncryptionSettingsWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const EncryptionSettingsWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<EncryptionSettingsWidget> createState() => _EncryptionSettingsWidgetState();
}

class _EncryptionSettingsWidgetState extends State<EncryptionSettingsWidget> {
  bool enabled = false;

  final TextEditingController domainNameController = TextEditingController();
  String? domainError;

  bool redirectHttps = false;

  final TextEditingController httpsPortController = TextEditingController();
  String? httpsPortError;

  final TextEditingController tlsPortController = TextEditingController();
  String? tlsPortError;

  final TextEditingController dnsOverQuicPortController = TextEditingController();
  String? dnsOverQuicPortError;

  int certificateOption = 0;

  final TextEditingController certificatePathController = TextEditingController();
  String? certificatePathError;

  final TextEditingController certificateContentController = TextEditingController();
  String? certificateContentError;

  int privateKeyOption = 0;

  bool usePreviouslySavedKey = false;

  final TextEditingController privateKeyPathController = TextEditingController();
  String? privateKeyPathError;

  final TextEditingController pastePrivateKeyController = TextEditingController();
  String? pastePrivateKeyError;


  void fetchData({bool? showRefreshIndicator}) async {
    widget.serversProvider.setEncryptionSettingsLoadStatus(0, showRefreshIndicator ?? false);

    final result = await getEncryptionSettings(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setEncryptionSettings(result['data']);
        widget.serversProvider.setEncryptionSettingsLoadStatus(1, true);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setEncryptionSettingsLoadStatus(2, true);
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    Widget generateBody() {
      switch (widget.serversProvider.encryptionSettings.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingEncryptionSettings,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          );

        case 1:
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 12, 
                  right: 12
                ),
                child: Material(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    onTap: () => setState(() => enabled = !enabled),
                    borderRadius: BorderRadius.circular(28),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.enableEncryption,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  AppLocalizations.of(context)!.enableEncryptionTypes,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).listTileTheme.iconColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Switch(
                            value: enabled, 
                            onChanged: (value) => setState(() => enabled = value),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SectionLabel(label: AppLocalizations.of(context)!.serverConfiguration),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: domainNameController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.link_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: domainError,
                    labelText: AppLocalizations.of(context)!.domainName,
                    helperText: AppLocalizations.of(context)!.domainNameDescription,
                    helperMaxLines: 10
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomSwitchListTile(
                value: redirectHttps, 
                onChanged: (value) => setState(() => redirectHttps = value), 
                title: AppLocalizations.of(context)!.redirectHttps,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: httpsPortController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: httpsPortError,
                    labelText: AppLocalizations.of(context)!.httpsPort,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: tlsPortController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: tlsPortError,
                    labelText: AppLocalizations.of(context)!.tlsPort,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: dnsOverQuicPortController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: dnsOverQuicPortError,
                    labelText: AppLocalizations.of(context)!.dnsOverQuicPort,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SectionLabel(label: AppLocalizations.of(context)!.certificates),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.info_rounded),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(AppLocalizations.of(context)!.certificatesDescription)
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RadioListTile(
                value: 0, 
                groupValue: certificateOption,
                onChanged: (value) => setState(() => certificateOption = value!),
                title: Text(
                  AppLocalizations.of(context)!.certificateFilePath,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              RadioListTile(
                value: 1, 
                groupValue: certificateOption,
                onChanged: (value) => setState(() => certificateOption = value!),
                title: Text(
                  AppLocalizations.of(context)!.pasteCertificateContent,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (certificateOption == 0) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: certificatePathController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: certificatePathError,
                    labelText: AppLocalizations.of(context)!.certificatePath,
                  ),
                ),
              ),
              if (certificateOption == 1) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: certificateContentController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: certificateContentError,
                    labelText: AppLocalizations.of(context)!.certificateContent,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              SectionLabel(label: AppLocalizations.of(context)!.privateKey),
              RadioListTile(
                value: 0, 
                groupValue: privateKeyOption,
                onChanged: (value) => setState(() => privateKeyOption = value!),
                title: Text(
                  AppLocalizations.of(context)!.privateKeyFile,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              RadioListTile(
                value: 1, 
                groupValue: privateKeyOption,
                onChanged: (value) => setState(() => privateKeyOption = value!),
                title: Text(
                  AppLocalizations.of(context)!.pastePrivateKey,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              if (privateKeyOption == 0) const SizedBox(height: 10),
              if (privateKeyOption == 1) ...[
                CustomSwitchListTile(
                  value: usePreviouslySavedKey, 
                  onChanged: (value) => setState(() => usePreviouslySavedKey = value), 
                  title: AppLocalizations.of(context)!.usePreviousKey,
                ),
                const SizedBox(height: 10)
              ],
              if (privateKeyOption == 0) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: privateKeyPathController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: privateKeyPathError,
                    labelText: AppLocalizations.of(context)!.privateKeyPath,
                  ),
                ),
              ),
              if (privateKeyOption == 1) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  enabled: !usePreviouslySavedKey,
                  controller: pastePrivateKeyController,
                  // onChanged:
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    errorText: pastePrivateKeyError,
                    labelText: AppLocalizations.of(context)!.pastePrivateKey,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );

        case 2:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.encryptionSettingsNotLoaded,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.encryptionSettings),
      ),
      body: generateBody(),
    );
  }
}