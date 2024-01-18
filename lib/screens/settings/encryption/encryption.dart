// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/encryption/status.dart';
import 'package:adguard_home_manager/screens/settings/encryption/reset_settings_modal.dart';
import 'package:adguard_home_manager/screens/settings/encryption/custom_text_field.dart';
import 'package:adguard_home_manager/screens/settings/encryption/master_switch.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption_functions.dart';
import 'package:adguard_home_manager/screens/settings/encryption/error_message.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/encryption.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/base64.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class EncryptionSettings extends StatefulWidget {
  const EncryptionSettings({super.key});


  @override
  State<EncryptionSettings> createState() => _EncryptionSettingsState();
}

class _EncryptionSettingsState extends State<EncryptionSettings> {
  LoadStatus loadStatus = LoadStatus.loading;

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

  EncryptionValidation? certKeyValid;
  String? encryptionResultMessage;

  bool formEdited = false;

  void fetchData({bool? showRefreshIndicator}) async {
    setState(() => loadStatus = LoadStatus.loading);

    final result = await Provider.of<ServersProvider>(context, listen: false).apiClient2!.getEncryptionSettings();
    if (!mounted) return;
    
    if (result.successful == true) {
      final data = result.content as EncryptionData;
      
      await checkValidDataApi(data: data.toJson());
      if (!mounted) return;

      setState(() {
        enabled = data.enabled;
        domainNameController.text = data.serverName ?? '';
        redirectHttps = data.forceHttps ?? false;
        httpsPortController.text = data.portHttps != null ? data.portHttps.toString() : '';
        tlsPortController.text = data.portDnsOverTls != null ? data.portDnsOverTls.toString() : '';
        dnsOverQuicPortController.text = data.portDnsOverQuic != null ? data.portDnsOverQuic.toString() : '';
        if (data.certificateChain != '') {
          certificateOption = 1;
          certificateContentController.text = decodeBase64(data.certificateChain);
        }
        else {
          certificateOption = 0;
          certificatePathController.text = data.certificatePath;
        }
        if (data.privateKey != '' || data.privateKeySaved == true) {
          privateKeyOption = 1;
        }
        else {
          privateKeyOption = 0;
          privateKeyPathController.text = data.privateKeyPath;
        }
        usePreviouslySavedKey = data.privateKeySaved;
        loadStatus = LoadStatus.loaded;
      });
    }
    else {
      setState(() => loadStatus = LoadStatus.error);
    }
  }

  Future checkValidDataApi({Map<String, dynamic>? data}) async {
    setState(() => certKeyValidApi = 0);

    final result = await Provider.of<ServersProvider>(context, listen: false).apiClient2!.checkEncryptionSettings(
      data: data ?? {
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
      }
    );

    if (!mounted) return;
    if (result.successful == true) {
      final data = result.content as EncryptionValidationResult;
      if (data.isObject == true) {
        final object = data.encryptionValidation!;
        setState(() {
          if (object.warningValidation != null && object.warningValidation != '') {
            certKeyValidApi = 2;
            validDataError = object.warningValidation;
          }
          else {
            certKeyValidApi = 1;
            validDataError = null;
          }
          certKeyValid = object;
        });
      }
      else {
        setState(() {
          encryptionResultMessage = data.message;
          certKeyValidApi = 2;
        });
      }
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
      dnsOverQuicPortError == null 
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
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.savingConfig);

      final result = await serversProvider.apiClient2!.saveEncryptionSettings(
        data: {
          "enabled": enabled,
          "server_name": domainNameController.text,
          "force_https": redirectHttps,
          "port_https": int.tryParse(httpsPortController.text),
          "port_dns_over_tls": int.tryParse(tlsPortController.text),
          "port_dns_over_quic": int.tryParse(dnsOverQuicPortController.text),
          "certificate_chain": encodeBase64(certificateContentController.text),
          "private_key": encodeBase64(pastePrivateKeyController.text),
          "private_key_saved": usePreviouslySavedKey,
          "certificate_path": certificatePathController.text,
          "private_key_path": privateKeyPathController.text,
        }
      );

      processModal.close();

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigSaved, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.encryptionConfigNotSaved, 
          color: Colors.red
        );

        if (result.content != null) {
          showDialog(
            context: context, 
            builder: (context) => ErrorMessageEncryption(
              errorMessage: result.content
            )
          );
        }
      }
    }

    void resetSettings() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.resettingConfig);

      final result = await serversProvider.apiClient2!.saveEncryptionSettings(
        data: {
          "enabled": false,
          "server_name": "",
          "force_https": false,
          "port_https": 443,
          "port_dns_over_tls": 853,
          "port_dns_over_quic": 853,
          "certificate_chain": "",
          "private_key": "",
          "private_key_saved": false,
          "certificate_path": "",
          "private_key_path": "",
        }
      );
      if (!mounted) return;

      processModal.close();

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.configurationResetSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.configurationResetError, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.encryptionSettings),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context, 
              builder: (ctx) => ResetSettingsModal(onConfirm: resetSettings)
            ), 
            icon: const Icon(Icons.restore_rounded),
            tooltip: AppLocalizations.of(context)!.resetSettings,
          ),
          IconButton(
            onPressed: localValidationValid ?
              () => saveData()
              : null, 
            icon: const Icon(Icons.save),
            tooltip: AppLocalizations.of(context)!.save,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            switch (loadStatus) {
              case LoadStatus.loading:
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
        
              case LoadStatus.loaded:
                return ListView(
                  children: [
                    if (certKeyValidApi == 2 && (validDataError != null || encryptionResultMessage != null)) Card(
                      margin: const EdgeInsets.all(16),
                      color: Colors.red.withOpacity(0.2),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_rounded,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(validDataError ?? encryptionResultMessage ?? AppLocalizations.of(context)!.unknownError)
                            )
                          ],
                        ),
                      ),
                    ),
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
                      if (certKeyValid!.validChain != null) ...[
                        Status(
                          valid: certKeyValid!.validChain ?? false, 
                          label: certKeyValid!.validChain == true
                            ? AppLocalizations.of(context)!.validCertificateChain
                            : AppLocalizations.of(context)!.invalidCertificateChain,
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (certKeyValid!.subject != null) ...[
                        Status(
                          valid: true, 
                          label: "${AppLocalizations.of(context)!.subject}: ${certKeyValid?.subject}"
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (certKeyValid!.issuer != null) ...[
                        Status(
                        valid: true, 
                        label: "${AppLocalizations.of(context)!.issuer}: ${certKeyValid?.issuer}"
                      ),
                        const SizedBox(height: 10),
                      ],
                      if (certKeyValid!.notAfter != null) ...[
                        Status(
                          valid: true, 
                          label: "${AppLocalizations.of(context)!.expirationDate}: ${certKeyValid?.notAfter}"
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (certKeyValid!.dnsNames != null) ...[
                        Status(
                          valid: true, 
                          label: "${AppLocalizations.of(context)!.hostNames}: ${certKeyValid?.dnsNames?.join(', ')}"
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
                      if (certKeyValid!.validKey != null) ...[
                        Status(
                          valid: certKeyValid!.validKey ?? false, 
                          label: certKeyValid!.validKey == true
                            ? AppLocalizations.of(context)!.validPrivateKey
                            : AppLocalizations.of(context)!.invalidPrivateKey,
                        ),
                        const SizedBox(height: 10)
                      ],
                      if (certKeyValid!.validPair != null && certKeyValid!.validPair == false) ...[
                        Status(
                          valid: false, 
                          label: AppLocalizations.of(context)!.keysNotMatch,
                        ),
                        const SizedBox(height: 10)
                      ],
                      if (certKeyValid!.keyType != null) ...[
                        Status(
                          valid: true, 
                          label: "${AppLocalizations.of(context)!.keyType}: ${certKeyValid!.keyType}"
                        ),
                        const SizedBox(height: 10),
                      ],
                      const SizedBox(height: 10)
                    ]
                  ],
                );
        
              case LoadStatus.error:
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
          },
        ),
      )
    );
  }
}