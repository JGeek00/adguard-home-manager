// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/encryption/config_error_modal.dart';
import 'package:adguard_home_manager/screens/settings/encryption/status.dart';
import 'package:adguard_home_manager/screens/settings/encryption/custom_text_field.dart';
import 'package:adguard_home_manager/screens/settings/encryption/master_switch.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption_functions.dart';
import 'package:adguard_home_manager/screens/settings/encryption/error_message.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/base64.dart';
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

  bool existsPreviousKey = false;
  bool usePreviouslySavedKey = false;

  final TextEditingController privateKeyPathController = TextEditingController();
  String? privateKeyPathError;

  final TextEditingController pastePrivateKeyController = TextEditingController();
  String? pastePrivateKeyError;

  bool localValidationValid = false;
  String? validDataError;
  int certKeyValidApi = 0;

  Map<String, dynamic>? certKeyValid;

  bool formEdited = false;

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
          if (result['data'].certificateChain != '') {
            certificateOption = 1;
            certificateContentController.text = decodeBase64(result['data'].certificateChain);
          }
          else {
            certificateOption = 0;
            certificatePathController.text = result['data'].certificatePath;
          }
          if (result['data'].privateKey != '' || result['data'].privateKeySaved == true) {
            privateKeyOption = 1;
          }
          else {
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
    setState(() => certKeyValidApi = 0);

    final result = await checkEncryptionSettings(server: widget.serversProvider.selectedServer!, data: data ?? {
      "enabled": enabled,
      "server_name": domainNameController.text,
      "force_https": redirectHttps,
      "port_https": httpsPortController.text != '' ? int.parse(httpsPortController.text) : null,
      "port_dns_over_tls": tlsPortController.text != '' ? int.parse(tlsPortController.text) : null,
      "port_dns_over_quic": dnsOverQuicPortController.text != '' ? int.parse(dnsOverQuicPortController.text) : null,
      if (certificateOption == 1) "certificate_chain": encodeBase64(certificateContentController.text),
      if (privateKeyOption == 1 && usePreviouslySavedKey == false) "private_key": encodeBase64(pastePrivateKeyController.text),
      "private_key_saved": usePreviouslySavedKey,
      if (certificateOption == 0) "certificate_path": certificatePathController.text,
      if (privateKeyOption == 0) "private_key_path": privateKeyPathController.text,
    });

    if (result['result'] == 'success') {
      setState(() {
        if (result['data']['warning_validation'] != null && result['data']['warning_validation'] != '') {
          certKeyValidApi = 2;
          validDataError = result['data']['warning_validation'];
        }
        else {
          certKeyValidApi = 1;
          validDataError = null;
        }
        certKeyValid = result['data'];
      });
    }
    else {
      if (result['log'].resBody != null) {
        setState(() => validDataError = result['log'].resBody);
      }
      setState(() => certKeyValidApi = 2);
    }
  }

  bool checkcertKeyValid() {
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
      return true;
    }
    else {
      setState(() => localValidationValid = false);
      return false;
    }
  }

  void onEditValidate() {
    setState(() => formEdited = true);
    final res = checkcertKeyValid();
    if (res == true) {
      checkValidDataApi();
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

    final width = MediaQuery.of(context).size.width;

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
        "certificate_chain": encodeBase64(certificateContentController.text),
        "private_key": encodeBase64(pastePrivateKeyController.text),
        "private_key_saved": usePreviouslySavedKey,
        "certificate_path": certificatePathController.text,
        "private_key_path": privateKeyPathController.text,
      });

      processModal.close();

      if (result['result'] == 'success') {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigSaved, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigNotSaved, 
          color: Colors.red
        );

        if (result['log'].resBody != null) {
          showDialog(
            context: context, 
            builder: (context) => ErrorMessageEncryption(
              errorMessage: result['log'].resBody
            )
          );
        }
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  onEditValidate();
                }
              ),
              SectionLabel(
                label: AppLocalizations.of(context)!.serverConfiguration,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              ),
              EncryptionTextField(
                enabled: enabled, 
                controller: domainNameController, 
                icon: Icons.link_rounded, 
                onChanged: (value) {
                  setState(() => domainError = validateDomain(context, value));
                  onEditValidate();
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
                  onEditValidate();
                }, 
                title: AppLocalizations.of(context)!.redirectHttps,
                disabled: !enabled,
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  FractionallySizedBox(
                    widthFactor: width > 900 ? 0.33 : 1,
                    child: EncryptionTextField(
                      enabled: enabled, 
                      controller: httpsPortController, 
                      icon: Icons.numbers_rounded, 
                      onChanged: (value) {
                        setState(() => httpsPortError = validatePort(context, value));
                        onEditValidate();
                      },
                      errorText: httpsPortError,
                      label: AppLocalizations.of(context)!.httpsPort,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: width <= 900
                      ? const EdgeInsets.symmetric(vertical: 24)
                      : const EdgeInsets.all(0),
                    child: FractionallySizedBox(
                      widthFactor: width > 900 ? 0.33 : 1,
                      child: EncryptionTextField(
                        enabled: enabled, 
                        controller: tlsPortController, 
                        icon: Icons.numbers_rounded, 
                        onChanged: (value) {
                          setState(() => tlsPortError = validatePort(context, value));
                          onEditValidate();
                        },
                        errorText: tlsPortError,
                        label: AppLocalizations.of(context)!.tlsPort,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: width > 900 ? 0.33 : 1,
                    child: EncryptionTextField(
                      enabled: enabled, 
                      controller: dnsOverQuicPortController, 
                      icon: Icons.numbers_rounded, 
                      onChanged: (value) {
                        setState(() => dnsOverQuicPortError = validatePort(context, value));
                        onEditValidate();
                      },
                      errorText: dnsOverQuicPortError,
                      label: AppLocalizations.of(context)!.dnsOverQuicPort,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SectionLabel(
                label: AppLocalizations.of(context)!.certificates,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Theme.of(context).listTileTheme.iconColor,
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.certificatesDescription,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
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
                      onEditValidate();
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
                      onEditValidate();
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
                  onEditValidate();
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
                  onEditValidate();
                }, 
                label: AppLocalizations.of(context)!.certificateContent,
                errorText: certificateContentError,
                multiline: true,
                keyboardType: TextInputType.multiline,
              ),
              if (certKeyValid != null && (certificateContentController.text != '' || certificatePathController.text != '')) ...[
                const SizedBox(height: 20),
                if (certKeyValid!['valid_chain'] != null) ...[
                  Status(
                    valid: certKeyValid!['valid_chain'], 
                    label: certKeyValid!['valid_chain'] == true
                      ? AppLocalizations.of(context)!.validCertificateChain
                      : AppLocalizations.of(context)!.invalidCertificateChain,
                  ),
                  const SizedBox(height: 10),
                ],
                if (certKeyValid!['subject'] != null) ...[
                  Status(
                    valid: true, 
                    label: "${AppLocalizations.of(context)!.subject}: ${certKeyValid!['subject']}"
                  ),
                  const SizedBox(height: 10),
                ],
                if (certKeyValid!['issuer'] != null) ...[
                  Status(
                  valid: true, 
                  label: "${AppLocalizations.of(context)!.issuer}: ${certKeyValid!['issuer']}"
                ),
                  const SizedBox(height: 10),
                ],
                if (certKeyValid!['not_after'] != null) ...[
                  Status(
                    valid: true, 
                    label: "${AppLocalizations.of(context)!.expirationDate}: ${certKeyValid!['not_after']}"
                  ),
                  const SizedBox(height: 10),
                ],
                if (certKeyValid!['dns_names'] != null) ...[
                  Status(
                    valid: true, 
                    label: "${AppLocalizations.of(context)!.hostNames}: ${certKeyValid!['dns_names'].join(', ')}"
                  ),
                  const SizedBox(height: 10),
                ],
              ],
              SectionLabel(
                label: AppLocalizations.of(context)!.privateKey,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              ),
              RadioListTile(
                value: 0, 
                groupValue: privateKeyOption,
                onChanged: enabled == true
                  ? (value) {
                      setState(() => privateKeyOption = int.parse(value.toString()));
                      onEditValidate();
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
                      onEditValidate();
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
                  onEditValidate();
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
                  onEditValidate();
                },
                label: AppLocalizations.of(context)!.pastePrivateKey,
                errorText: pastePrivateKeyError,
                keyboardType: TextInputType.multiline,
                multiline: true,
              ),
              const SizedBox(height: 20),
              if (certKeyValid != null && (privateKeyPathController.text != '' || pastePrivateKeyController.text != '' || usePreviouslySavedKey == true)) ...[
                if (certKeyValid!['valid_key'] != null) ...[
                  Status(
                    valid: certKeyValid!['valid_key'], 
                    label: certKeyValid!['valid_key'] == true
                      ? AppLocalizations.of(context)!.validPrivateKey
                      : AppLocalizations.of(context)!.invalidPrivateKey,
                  ),
                  const SizedBox(height: 10)
                ],
                if (certKeyValid!['valid_pair'] != null && certKeyValid!['valid_pair'] == false) ...[
                  Status(
                    valid: false, 
                    label: AppLocalizations.of(context)!.keysNotMatch,
                  ),
                  const SizedBox(height: 10)
                ],
                if (certKeyValid!['key_type'] != null) ...[
                  Status(
                    valid: true, 
                    label: "${AppLocalizations.of(context)!.keyType}: ${certKeyValid!['key_type']}"
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 10)
              ]
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: certKeyValidApi == 2 && validDataError != null
              ? () => {
                showDialog(
                  context: context, 
                  builder: (context) => EncryptionErrorModal(error: validDataError!)
                )
              } : null, 
            icon: generateStatus(context, appConfigProvider, localValidationValid, certKeyValidApi, formEdited),
            tooltip: generateStatusString(context, localValidationValid, certKeyValidApi)
          ),
          IconButton(
            onPressed: saveData, 
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