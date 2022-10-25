// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/screens/settings/encryption/config_error_modal.dart';
import 'package:adguard_home_manager/screens/settings/encryption/custom_text_field.dart';
import 'package:adguard_home_manager/screens/settings/encryption/master_switch.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption_functions.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
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
  int loadStatus = 0;

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

  bool localValidationValid = false;
  String? validDataError;
  int dataValidApi = 0;

  void fetchData({bool? showRefreshIndicator}) async {
    setState(() => loadStatus = 0);

    final result = await getEncryptionSettings(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        await checkValidDataApi(data: result['data'].toJson());

        setState(() {
          enabled = result['data'].enabled;
          domainNameController.text = result['data'].serverName ?? '';
          redirectHttps = result['data'].forceHttps;
          httpsPortController.text = result['data'].portHttps != null ? result['data'].portHttps.toString() : '';
          tlsPortController.text = result['data'].portDnsOverTls != null ? result['data'].portDnsOverTls.toString() : '';
          dnsOverQuicPortController.text = result['data'].portDnsOverQuic != null ? result['data'].portDnsOverQuic.toString() : '';
          if (result['data'].certificateChain != '' && result['data'].certificatePath == '') {
            certificateOption = 1;
            certificateContentController.text = result['data'].certificateChain;
          }
          else if (result['data'].certificateChain == '' && result['data'].certificatePath != '') {
            certificateOption = 0;
            certificatePathController.text = result['data'].certificatePath;
          }
          if (result['data'].privateKey != '' && result['data'].privateKeyPath == '') {
            privateKeyOption = 1;
            pastePrivateKeyController.text = result['data'].privateKey;
          }
          else if (result['data'].privateKey == '' && result['data'].privateKeyPath != '') {
            privateKeyOption = 0;
            privateKeyPathController.text = result['data'].privateKeyPath;
          }
          usePreviouslySavedKey = result['data'].privateKeySaved;

          loadStatus = 1;
        });
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        setState(() => loadStatus = 2);
      }
    }
  }

  Future checkValidDataApi({Map<String, dynamic>? data}) async {
    setState(() => dataValidApi = 0);

    final result = await checkEncryptionSettings(server: widget.serversProvider.selectedServer!, data: data ?? {
      "enabled": enabled,
      "server_name": domainNameController.text,
      "force_https": redirectHttps,
      "port_https": httpsPortController.text != '' ? int.parse(httpsPortController.text) : null,
      "port_dns_over_tls": tlsPortController.text != '' ? int.parse(tlsPortController.text) : null,
      "port_dns_over_quic": dnsOverQuicPortController.text != '' ? int.parse(dnsOverQuicPortController.text) : null,
      "certificate_chain": certificateContentController.text.replaceAll('\n', ''),
      "private_key": pastePrivateKeyController.text.replaceAll('\n', ''),
      "private_key_saved": usePreviouslySavedKey,
      "certificate_path": certificatePathController.text,
      "private_key_path": privateKeyPathController.text,
    });

    if (result['result'] == 'success') {
      setState(() {
        if (result['data']['warning_validation'] != null && result['data']['warning_validation'] != '') {
          dataValidApi = 2;
          validDataError = result['data']['warning_validation'];
        }
        else {
          dataValidApi = 1;
          validDataError = null;
        }
      });
    }
    else {
      if (result['log'].resBody != null) {
        setState(() => validDataError = result['log'].resBody);
      }
      setState(() => dataValidApi = 2);
    }
  }

  void checkDataValid() {
    if (
      domainNameController.text != '' && 
      domainError == null && 
      httpsPortController.text != '' && 
      httpsPortError == null &&
      tlsPortController.text != '' &&
      tlsPortError == null &&
      dnsOverQuicPortController.text != '' &&
      dnsOverQuicPortError == null &&
      ((
        certificateOption == 0 && 
        certificatePathController.text != '' && 
        certificatePathError == null
      ) || (
        certificateOption == 1 && 
        certificateContentController.text != '' &&
        certificateContentError == null
      )) && 
      ((
        privateKeyOption == 0 && 
        privateKeyPathController.text != '' &&
        privateKeyPathError == null
      ) || (
        privateKeyOption == 1 &&
        pastePrivateKeyController.text != '' &&
        pastePrivateKeyError == null
      ))
    ) {
      setState(() => localValidationValid = true);
      checkValidDataApi();
    }
    else {
      setState(() => localValidationValid = false);
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

    void saveData() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await saveEncryptionSettings(server: serversProvider.selectedServer!, data: {
        "enabled": enabled,
        "server_name": domainNameController.text,
        "force_https": redirectHttps,
        "port_https": int.parse(httpsPortController.text),
        "port_dns_over_tls": int.parse(tlsPortController.text),
        "port_dns_over_quic": int.parse(dnsOverQuicPortController.text),
        "certificate_chain": certificateContentController.text,
        "private_key": pastePrivateKeyController.text,
        "private_key_saved": usePreviouslySavedKey,
        "certificate_path": certificatePathController.text,
        "private_key_path": privateKeyPathController.text,
      });

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigSaved, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigNotSaved, 
          color: Colors.red
        );
      }
    }

    Widget generateBody() {
      switch (loadStatus) {
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
              EncryptionMasterSwitch(
                value: enabled, 
                onChange: (value) {
                  setState(() => enabled = value);
                  checkDataValid();
                }
              ),
              SectionLabel(label: AppLocalizations.of(context)!.serverConfiguration),
              EncryptionTextField(
                enabled: enabled, 
                controller: domainNameController, 
                icon: Icons.link_rounded, 
                onChanged: (value) {
                  setState(() => domainError = validateDomain(context, value));
                  checkDataValid();
                },
                errorText: domainError,
                label: AppLocalizations.of(context)!.domainName,
                helperText: AppLocalizations.of(context)!.domainNameDescription,
              ),
              const SizedBox(height: 10),
              CustomSwitchListTile(
                value: redirectHttps, 
                onChanged: (value) {
                  setState(() => redirectHttps = value);
                  checkDataValid();
                }, 
                title: AppLocalizations.of(context)!.redirectHttps,
                disabled: !enabled,
              ),
              const SizedBox(height: 10),
              EncryptionTextField(
                enabled: enabled, 
                controller: httpsPortController, 
                icon: Icons.numbers_rounded, 
                onChanged: (value) {
                  setState(() => httpsPortError = validatePort(context, value));
                  checkDataValid();
                },
                errorText: httpsPortError,
                label: AppLocalizations.of(context)!.httpsPort,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              EncryptionTextField(
                enabled: enabled, 
                controller: tlsPortController, 
                icon: Icons.numbers_rounded, 
                onChanged: (value) {
                  setState(() => tlsPortError = validatePort(context, value));
                  checkDataValid();
                },
                errorText: tlsPortError,
                label: AppLocalizations.of(context)!.tlsPort,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              EncryptionTextField(
                enabled: enabled, 
                controller: dnsOverQuicPortController, 
                icon: Icons.numbers_rounded, 
                onChanged: (value) {
                  setState(() => dnsOverQuicPortError = validatePort(context, value));
                  checkDataValid();
                },
                errorText: dnsOverQuicPortError,
                label: AppLocalizations.of(context)!.dnsOverQuicPort,
                keyboardType: TextInputType.number,
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
                onChanged: enabled == true
                  ? (value) {
                      setState(() => certificateOption = int.parse(value.toString()));
                      checkDataValid();
                    }
                  : null,
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
                onChanged: enabled == true
                  ? (value) {
                      setState(() => certificateOption = int.parse(value.toString()));
                      checkDataValid();
                    }
                  : null,
                title: Text(
                  AppLocalizations.of(context)!.pasteCertificateContent,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (certificateOption == 0) EncryptionTextField(
                enabled: enabled, 
                controller: certificatePathController, 
                icon: Icons.description_rounded, 
                onChanged: (value) {
                  setState(() => certificatePathError = validatePath(context, value));
                  checkDataValid();
                },
                label: AppLocalizations.of(context)!.certificatePath,
                errorText: certificatePathError,
              ),
              if (certificateOption == 1) EncryptionTextField(
                enabled: enabled, 
                controller: certificateContentController, 
                icon: Icons.description_rounded, 
                onChanged: (value) {
                  setState(() => certificateContentError = validateCertificate(context, value));
                  checkDataValid();
                }, 
                label: AppLocalizations.of(context)!.certificateContent,
                helperText: AppLocalizations.of(context)!.enterOnlyCertificate,
                errorText: certificateContentError,
                multiline: true,
                keyboardType: TextInputType.multiline,
              ),
              SectionLabel(label: AppLocalizations.of(context)!.privateKey),
              RadioListTile(
                value: 0, 
                groupValue: privateKeyOption,
                onChanged: enabled == true
                  ? (value) {
                      setState(() => privateKeyOption = int.parse(value.toString()));
                      checkDataValid();
                    }
                  : null,
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
                onChanged: enabled == true
                  ? (value) {
                      setState(() => privateKeyOption = int.parse(value.toString()));
                      checkDataValid();
                    }
                  : null,
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
              if (privateKeyOption == 0) EncryptionTextField(
                enabled: enabled, 
                controller: privateKeyPathController, 
                icon: Icons.description_rounded, 
                onChanged: (value) {
                  setState(() => privateKeyPathError = validatePath(context, value));
                  checkDataValid();
                },
                label: AppLocalizations.of(context)!.privateKeyPath,
                errorText: privateKeyPathError,
              ),
              if (privateKeyOption == 1) EncryptionTextField(
                enabled: enabled == true
                  ? !usePreviouslySavedKey
                  : false,
                controller: pastePrivateKeyController, 
                icon: Icons.description_rounded, 
                onChanged: (value) {
                  setState(() => pastePrivateKeyError = validatePrivateKey(context, value));
                  checkDataValid();
                },
                label: AppLocalizations.of(context)!.pastePrivateKey,
                helperText: AppLocalizations.of(context)!.enterOnlyPrivateKey,
                errorText: pastePrivateKeyError,
                keyboardType: TextInputType.multiline,
                multiline: true,
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
        actions: [
          IconButton(
            onPressed: dataValidApi == 2 && validDataError != null
              ? () => {
                showDialog(
                  context: context, 
                  builder: (context) => EncryptionErrorModal(error: validDataError!)
                )
              } : null, 
            icon: generateStatus(localValidationValid, dataValidApi),
            tooltip: generateStatusString(context, localValidationValid, dataValidApi)
          ),
          IconButton(
            onPressed: localValidationValid == true && dataValidApi == 1
              ? () => saveData()
              : null, 
            icon: const Icon(Icons.save),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: generateBody(),
    );
  }
}