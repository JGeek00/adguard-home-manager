// ignore_for_file: use_build_context_synchronously
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/add_server/form_text_field.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';

import 'package:adguard_home_manager/services/auth.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/server.dart';

class AddServerModal extends StatefulWidget {
  final Server? server;
  final bool fullScreen;
  final void Function(String version) onUnsupportedVersion;

  const AddServerModal({
    super.key,
    this.server,
    required this.fullScreen,
    required this.onUnsupportedVersion
  });

  @override
  State<AddServerModal> createState() => _AddServerModalState();
}

class _AddServerModalState extends State<AddServerModal> {
  final uuid = const Uuid();

  final TextEditingController nameController = TextEditingController();
  String? nameError;

  final TextEditingController apiKeyController = TextEditingController();
  String? apiKeyError;

  bool defaultServer = false;
  bool isConnecting = false;

  @override
  void initState() {
    if (widget.server != null) {
      nameController.text = widget.server!.name;
      apiKeyController.text = widget.server!.authToken ?? "";
      defaultServer = widget.server!.defaultServer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);

    void cancelConnecting() {
      if (mounted) {
        setState(() => isConnecting = false);
      }
      else {
        isConnecting = false;
      }
    }

    bool checkDataValid() {
      if (nameController.text == '') {
        setState(() => nameError = AppLocalizations.of(context)!.nameNotEmpty);
        return false;
      }
      if (apiKeyController.text == '') {
        setState(() => apiKeyError = "API Key cannot be empty"); // TODO: localize
        return false;
      }
      return true;
    }

    String getErrorMessage(AuthStatus status) {
      if (status == AuthStatus.invalidCredentials) return AppLocalizations.of(context)!.invalidUsernamePassword;
      if (status == AuthStatus.manyAttepts) return AppLocalizations.of(context)!.tooManyAttempts;
      if (status == AuthStatus.socketException || status == AuthStatus.timeoutException) return AppLocalizations.of(context)!.cantReachServer;
      if (status == AuthStatus.serverError) return AppLocalizations.of(context)!.serverError;
      if (status == AuthStatus.handshakeException) return AppLocalizations.of(context)!.sslError;
      return AppLocalizations.of(context)!.unknownError;
    }

    void connect() async {
      if (!checkDataValid()) return;

      setState(() => isConnecting = true);

      final result = await ServerAuth.validateApiKey(apiKeyController.text);

      if (result != AuthStatus.success) {
        cancelConnecting();
        if (mounted) {
          showSnackbar(
            appConfigProvider: appConfigProvider, 
            label: getErrorMessage(result), 
            color: Colors.red
          );
        }
        return;
      }

      Server serverObj = Server(
        id: uuid.v4(),
        name: nameController.text,
        connectionMethod: 'https',
        domain: 'api.adguard-dns.io',
        port: 443,
        user: null,
        password: null,
        path: '/oapi/v1',
        defaultServer: defaultServer,
        authToken: apiKeyController.text,
        runningOnHa: false
      );

      final serverCreated = await serversProvider.createServer(serverObj);

      if (!context.mounted) return;

      if (serverCreated != null) {
        setState(() => isConnecting = false);
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.connectionNotCreated, 
          color: Colors.red
        );
        return;
      }

      // Success
      setState(() => isConnecting = false);
      Navigator.pop(context);
    }

    void edit() async {
      if (!checkDataValid()) return;

      setState(() => isConnecting = true);

      final result = await ServerAuth.validateApiKey(apiKeyController.text);

       if (result != AuthStatus.success) {
        cancelConnecting();
        if (mounted) {
          showSnackbar(
            appConfigProvider: appConfigProvider, 
            label: getErrorMessage(result), 
            color: Colors.red
          );
        }
        return;
      }

      final Server serverObj = Server(
        id: widget.server!.id,
        name: nameController.text,
        connectionMethod: 'https',
        domain: 'api.adguard-dns.io',
        port: 443,
        user: null,
        password: null,
        path: '/oapi/v1',
        defaultServer: defaultServer,
        authToken: apiKeyController.text,
        runningOnHa: false
      );

      final serverSaved = await serversProvider.editServer(serverObj);

      if (!mounted) return;
    
      if (serverSaved != null) {
        setState(() => isConnecting = false);
        appConfigProvider.addLog(
          AppLog(
            type: 'save_connection_db', 
            dateTime: DateTime.now(),
            message: serverSaved.toString()
          )
        );
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.connectionNotCreated, 
          color: Colors.red
        );
        return;
      }

      setState(() => isConnecting = false);
      Navigator.pop(context);
    }

    Widget actions() {
      return Row(
        children: [
          IconButton(
            tooltip: widget.server == null 
              ? AppLocalizations.of(context)!.connect
              : AppLocalizations.of(context)!.save,
            onPressed: isConnecting == false
              ? widget.server == null 
                ? () => connect()
                : () => edit()
              : null,
            icon: isConnecting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator()
                )
              : Icon(
                widget.server == null
                  ? Icons.login_rounded
                  : Icons.save_rounded
            )
          ),
        ],
      );
    }

    List<Widget> form() {
      return [
        SectionLabel(
          label: AppLocalizations.of(context)!.general,
          padding: const EdgeInsets.all(24),
        ),
        FormTextField(
          label: AppLocalizations.of(context)!.name, 
          controller: nameController, 
          icon: Icons.badge_rounded,
          error: nameError,
          onChanged: (value) {
            if (value != '') {
              setState(() => nameError = null);
            }
          },
          isConnecting: isConnecting,
        ),
        const SizedBox(height: 20),
        FormTextField(
          label: "API Key", // TODO: Localize
          controller: apiKeyController,
          icon: Icons.key_rounded,
          error: apiKeyError,
          keyboardType: TextInputType.visiblePassword,
          // obscureText: true, // Maybe not obscure for API key or yes? Usually yes.
          onChanged: (value) {
            if (value != '') {
              setState(() => apiKeyError = null);
            }
          },
          isConnecting: isConnecting,
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.other,
          padding: const EdgeInsets.only(
            top: 32,
            left: 24,
            bottom: 12
          ),
        ),
        CustomSwitchListTile(
          value: defaultServer, 
          onChanged:  (value) => setState(() => defaultServer = value),
          title: AppLocalizations.of(context)!.defaultServer,
          disabled: widget.server != null || isConnecting,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 4
          ),
        ),
        const SizedBox(height: 20),
      ];
    }

    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(
              onPressed: () => Navigator.pop(context),
            ),
            title: widget.server == null
              ? Text(AppLocalizations.of(context)!.createConnection)
              : Text(AppLocalizations.of(context)!.editConnection),
            actions: [
              actions(),
              const SizedBox(width: 8)
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: form()
            ),
          ),
        ),
      );
    }
    else {  
      return Dialog(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded)
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.server == null
                            ? AppLocalizations.of(context)!.createConnection
                            : AppLocalizations.of(context)!.editConnection,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                    actions()
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: form()
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
