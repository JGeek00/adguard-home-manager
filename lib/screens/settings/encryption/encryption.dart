// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/screens/settings/encryption/config_error_modal.dart';
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

  bool validData = false;
  String? validDataError;
  int dataValidApi = 0;

  void fetchData({bool? showRefreshIndicator}) async {
    widget.serversProvider.setEncryptionSettingsLoadStatus(0, showRefreshIndicator ?? false);

    final result = await getEncryptionSettings(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      await checkValidDataApi();

      if (result['result'] == 'success') {
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
        });

        widget.serversProvider.setEncryptionSettings(result['data']);
        widget.serversProvider.setEncryptionSettingsLoadStatus(1, true);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setEncryptionSettingsLoadStatus(2, true);
      }
    }
  }

  void validateDomain(String domain) {
    RegExp regExp = RegExp(r'^([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
    if (regExp.hasMatch(domain)) {
      setState(() => domainError = null);
      checkValidDataApi();
    }
    else {
      setState(() => domainError = AppLocalizations.of(context)!.domainNotValid);
    }
    checkDataValid();
  }

  void validatePort(String value, String portType) {
    if (int.tryParse(value) != null && int.parse(value) <= 65535) {
      setState(() {
        switch (portType) {
          case 'https':
            setState(() => httpsPortError = null);
            break;
            
          case 'tls':
            setState(() => tlsPortError = null);
            break;

          case 'quic':
            setState(() => dnsOverQuicPortError = null);
            break;

          default:
            break;
        }
      });
      checkValidDataApi();
    }
    else {
      setState(() {
        switch (portType) {
          case 'https':
            setState(() => httpsPortError = AppLocalizations.of(context)!.invalidPort);
            break;
            
          case 'tls':
            setState(() => tlsPortError = AppLocalizations.of(context)!.invalidPort);
            break;

          case 'quic':
            setState(() => dnsOverQuicPortError = AppLocalizations.of(context)!.invalidPort);
            break;

          default:
            break;
        }
      });
    }
    checkDataValid();
  }

  void validateCertificate(String cert) {
    final regExp = RegExp(r'(-{3,}(\bBEGIN CERTIFICATE\b))|(-{3,}-{3,}(\END CERTIFICATE\b)-{3,})', multiLine: true);
    if (regExp.hasMatch(cert.replaceAll('\n', ''))) {
      setState(() => certificateContentError = AppLocalizations.of(context)!.invalidCertificate);
    }
    else {
      setState(() => certificateContentError = null);
    }
    checkDataValid();
    checkValidDataApi();
  }

  void validatePrivateKey(String cert) {
    final regExp = RegExp(r'(-{3,}(\bBEGIN\b).*(PRIVATE KEY\b))|(-{3,}-{3,}(\bEND\b).*(PRIVATE KEY\b)-{3,})', multiLine: true);
    if (regExp.hasMatch(cert.replaceAll('\n', ''))) {
      setState(() => pastePrivateKeyError = AppLocalizations.of(context)!.invalidPrivateKey);
    }
    else {
      setState(() => pastePrivateKeyError = null);
    }
    checkValidDataApi();
  }

  void validatePath(String cert, String item) {
    final regExp = RegExp(r'^(\/{0,1}(?!\/))[A-Za-z0-9\/\-_]+(\.([a-zA-Z]+))?$');
    if (regExp.hasMatch(cert)) {
      if (item == 'cert') {
        setState(() => certificatePathError = null);
      }
      else if (item == 'private_key') {
        setState(() => privateKeyPathError = null);
      }
      checkValidDataApi();
    }
    else {
      if (item == 'cert') {
        setState(() => certificatePathError = AppLocalizations.of(context)!.invalidPath);
      }
      else if (item == 'private_key') {
        setState(() => privateKeyPathError = AppLocalizations.of(context)!.invalidPath);
      }
    }
    checkDataValid();
  }

  Future checkValidDataApi() async {
    setState(() => dataValidApi = 0);

    final result = await checkEncryptionSettings(server: widget.serversProvider.selectedServer!, data: {
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
      setState(() => validData = true);
      checkValidDataApi();
    }
    else {
      setState(() => validData = false);
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

    Widget generateStatus() {
      if (dataValidApi == 0) {
        return const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          )
        );
      }
      else if (dataValidApi == 1) {
        return const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
        );
      }
      else if (dataValidApi == 2) {
        return const Icon(
          Icons.cancel_rounded,
          color: Colors.red,
        );
      }
      else {
        return const SizedBox();
      }
    }

    String generateStatusString() {
      if (dataValidApi == 0) {
        return AppLocalizations.of(context)!.validatingData;
      }
      else if (dataValidApi == 1) {
        return AppLocalizations.of(context)!.dataValid;
      }
      else if (dataValidApi == 2) {
        return AppLocalizations.of(context)!.dataNotValid;
      }
      else {
        return "";
      }
    }

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
                    onTap: () {
                      setState(() => enabled = !enabled);
                      checkDataValid();
                      checkValidDataApi();
                    },
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
                            onChanged: (value) {
                              setState(() => enabled = value);
                              checkDataValid();
                              checkValidDataApi();
                            },
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
                  enabled: enabled,
                  controller: domainNameController,
                  onChanged: validateDomain,
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
                    helperStyle: TextStyle(
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                    helperMaxLines: 10
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomSwitchListTile(
                value: redirectHttps, 
                onChanged: (value) {
                  setState(() => redirectHttps = value);
                  checkDataValid();
                  checkValidDataApi();
                }, 
                title: AppLocalizations.of(context)!.redirectHttps,
                disabled: !enabled,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  enabled: enabled,
                  controller: httpsPortController,
                  onChanged: (value) => validatePort(value, 'https'),
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
                  enabled: enabled,
                  controller: tlsPortController,
                  onChanged: (value) => validatePort(value, 'tls'),
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
                  enabled: enabled,
                  controller: dnsOverQuicPortController,
                  onChanged: (value) => validatePort(value, 'quic'),
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
                onChanged: enabled == true
                  ? (value) {
                      setState(() => certificateOption = int.parse(value.toString()));
                      checkDataValid();
                      checkValidDataApi();
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
                      checkValidDataApi();
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
              if (certificateOption == 0) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  enabled: enabled,
                  controller: certificatePathController,
                  onChanged: (value) => validatePath(value, 'cert'),
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
                  enabled: enabled,
                  controller: certificateContentController,
                  onChanged: validateCertificate,
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
                onChanged: enabled == true
                  ? (value) {
                      setState(() => privateKeyOption = int.parse(value.toString()));
                      checkDataValid();
                      checkValidDataApi();
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
                      checkValidDataApi();
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
              if (privateKeyOption == 0) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  enabled: enabled,
                  controller: privateKeyPathController,
                  onChanged: (value) => validatePath(value, 'private_key'),
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
                  enabled: enabled == true
                    ? !usePreviouslySavedKey
                    : false,
                  controller: pastePrivateKeyController,
                  onChanged: validatePrivateKey,
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
        actions: [
          IconButton(
            onPressed: validData == true && dataValidApi == 2 && validDataError != null
              ? () => {
                showDialog(
                  context: context, 
                  builder: (context) => EncryptionErrorModal(error: validDataError!)
                )
              } : null, 
            icon: generateStatus(),
            tooltip: generateStatusString()
          ),
          IconButton(
            onPressed: dataValidApi == 1
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