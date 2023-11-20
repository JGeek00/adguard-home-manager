// ignore_for_file: use_build_context_synchronously
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/add_server/unsupported_version_modal.dart';
import 'package:adguard_home_manager/widgets/add_server/form_text_field.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/widgets/add_server/add_server_functions.dart';

import 'package:adguard_home_manager/config/minimum_server_version.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/services/auth.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/api_client.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/base64.dart';
import 'package:adguard_home_manager/models/app_log.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/server.dart';

enum ConnectionType { http, https}

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

  ConnectionType connectionType = ConnectionType.http;

  final TextEditingController ipDomainController = TextEditingController();
  String? ipDomainError;

  final TextEditingController pathController = TextEditingController();
  String? pathError;

  final TextEditingController portController = TextEditingController();
  String? portError;

  final TextEditingController userController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool defaultServer = false;

  bool homeAssistant = false;

  bool allDataValid = false;

  bool isConnecting = false;

  @override
  void initState() {
    if (widget.server != null) {
      nameController.text = widget.server!.name;
      connectionType = widget.server!.connectionMethod == 'https' ? ConnectionType.https : ConnectionType.http;
      ipDomainController.text = widget.server!.domain;
      pathController.text = widget.server!.path ?? '';
      portController.text = widget.server!.port != null ? widget.server!.port.toString() : "";
      userController.text = widget.server!.user ?? "";
      passwordController.text = widget.server!.password ?? "";
      defaultServer = widget.server!.defaultServer;
      homeAssistant = widget.server!.runningOnHa;
    }
    setState(() => allDataValid = checkDataValid(
      ipDomainController: ipDomainController,
      nameController: nameController,
      ipDomainError: ipDomainError,
      pathError: pathError,
      portError: portError
    ));
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

    void validateData() {
      setState(() => allDataValid = checkDataValid(
        ipDomainController: ipDomainController,
        nameController: nameController,
        ipDomainError: ipDomainError,
        pathError: pathError,
        portError: portError
      ));
    }

    String getErrorMessage(AuthStatus status) {
      if (status == AuthStatus.invalidCredentials) return AppLocalizations.of(context)!.invalidUsernamePassword;
      if (status == AuthStatus.manyAttepts) return AppLocalizations.of(context)!.tooManyAttempts;
      if (status == AuthStatus.socketException || status == AuthStatus.timeoutException) return AppLocalizations.of(context)!.cantReachServer;
      if (status == AuthStatus.serverError) return AppLocalizations.of(context)!.serverError;
      return AppLocalizations.of(context)!.unknownError;
    }

    void connect() async {
      setState(() => isConnecting = true);

      Server serverObj = Server(
        id: uuid.v4(),
        name: nameController.text, 
        connectionMethod: connectionType.name, 
        domain: ipDomainController.text, 
        port: portController.text != '' ? int.parse(portController.text) : null,
        user: userController.text != "" ? userController.text : null, 
        password: passwordController.text != "" ? passwordController.text : null, 
        defaultServer: defaultServer,
        authToken: homeAssistant == true 
          ? encodeBase64UserPass(userController.text, passwordController.text)
          : null,
        runningOnHa: homeAssistant
      );

      final result = homeAssistant == true 
        ? await ServerAuth.loginHA(serverObj)
        : await ServerAuth.login(serverObj);

      // If something goes wrong with the connection
      if (result != AuthStatus.success) {
        cancelConnecting();
        if (mounted) {
          showSnacbkar(
            appConfigProvider: appConfigProvider, 
            label: getErrorMessage(result), 
            color: Colors.red
          );
        }
        return;
      }

      if (serverObj.user != null && serverObj.password != null) {
        serverObj.authToken = encodeBase64UserPass(serverObj.user!, serverObj.password!);
      }

      statusProvider.setServerStatusLoad(LoadStatus.loading);
      final ApiClientV2 apiClient2 = ApiClientV2(server: serverObj);
      final serverStatus = await apiClient2.getServerStatus();

      // If something goes wrong when fetching server status
      if (serverStatus.successful == false) {
        statusProvider.setServerStatusLoad(LoadStatus.error);
        Navigator.pop(context);
        return;
      }

      final status = serverStatus.content as ServerStatus;

      // Check if ths server version is compatible
      final validVersion = serverVersionIsAhead(
        currentVersion: status.serverVersion, 
        referenceVersion: MinimumServerVersion.stable,
        referenceVersionBeta: MinimumServerVersion.beta
      );
      if (validVersion == false) {
        showDialog(
          context: context, 
          builder: (ctx) => UnsupportedVersionModal(
            serverVersion: status.serverVersion,
            onClose: () => Navigator.pop(context)
          )
        );
        return;
      }

      final serverCreated = await serversProvider.createServer(serverObj);

      // If something goes wrong when saving the connection on the db
      if (serverCreated != null) {
        if (mounted) setState(() => isConnecting = false);
        if (mounted) {
          showSnacbkar(
            appConfigProvider: appConfigProvider, 
            label: AppLocalizations.of(context)!.connectionNotCreated, 
            color: Colors.red
          );
        }
        return;
      }

      // If everything is successful
      statusProvider.setServerStatusData(
        data: status
      );
      serversProvider.setApiClient2(apiClient2);
      statusProvider.setServerStatusLoad(LoadStatus.loaded);
      if (status.serverVersion.contains('a') || status.serverVersion.contains('b')) {
        Navigator.pop(context);
        widget.onUnsupportedVersion(status.serverVersion);
      }
      else {
        Navigator.pop(context);
      }
    }

    void edit() async {
      setState(() => isConnecting = true);
      
      final Server serverObj = Server(
        id: widget.server!.id,
        name: nameController.text, 
        connectionMethod: connectionType.name, 
        domain: ipDomainController.text, 
        port: portController.text != '' ? int.parse(portController.text) : null,
        user: userController.text != "" ? userController.text : null, 
        password: passwordController.text != "" ? passwordController.text : null, 
        defaultServer: defaultServer,
        authToken: homeAssistant == true 
          ? encodeBase64UserPass(userController.text, passwordController.text)
          : null,
        runningOnHa: homeAssistant
      );
      
      final result = homeAssistant == true 
        ? await ServerAuth.loginHA(serverObj)
        : await ServerAuth.login(serverObj);

      // If something goes wrong with the connection
      if (result != AuthStatus.success) {
        cancelConnecting();
        if (mounted) {
          showSnacbkar(
            appConfigProvider: appConfigProvider, 
            label: getErrorMessage(result), 
            color: Colors.red
          );
        }
        return;
      }
      
      if (serverObj.user != null && serverObj.password != null) {
        serverObj.authToken = encodeBase64UserPass(serverObj.user!, serverObj.password!);
      }

      final ApiClientV2 apiClient2 = ApiClientV2(server: serverObj);
      final version = await apiClient2.getServerVersion();
      if (version.successful == false) {
        if (mounted) setState(() => isConnecting = false);
        return;
      }

      // Check if ths server version is compatible
      final validVersion = serverVersionIsAhead(
        currentVersion: version.content, 
        referenceVersion: MinimumServerVersion.stable,
        referenceVersionBeta: MinimumServerVersion.beta
      );
      if (validVersion == false) {
        showDialog(
          context: context, 
          builder: (ctx) => UnsupportedVersionModal(
            serverVersion: version.content,
            onClose: () => Navigator.pop(context)
          )
        );
        return;
      }

      final serverSaved = await serversProvider.editServer(serverObj);
    
      // If something goes wrong when saving the connection on the db
      if (serverSaved != null) {
        if (mounted) setState(() => isConnecting = false);
        appConfigProvider.addLog(
          AppLog(
            type: 'save_connection_db', 
            dateTime: DateTime.now(),
            message: serverSaved.toString()
          )
        );
        if (mounted) {
          showSnacbkar(
            appConfigProvider: appConfigProvider, 
            label: AppLocalizations.of(context)!.connectionNotCreated, 
            color: Colors.red
          );
        }
        return;
      }

      // If everything is successful
      if (
        version.successful == true && 
        (version.content.contains('a') || version.content.contains('b'))  // alpha or beta
      ) {
        Navigator.pop(context);
        widget.onUnsupportedVersion(version.content);
      }
      else {
        Navigator.pop(context);
      }      
    }

    Widget actions() {
      return Row(
        children: [
          IconButton(
            onPressed: () => openUrl(Urls.connectionInstructions), 
            icon: const Icon(Icons.help_outline_outlined)
          ),
          IconButton(
            tooltip: widget.server == null 
              ? AppLocalizations.of(context)!.connect
              : AppLocalizations.of(context)!.save,
            onPressed: allDataValid == true && isConnecting == false
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary
            )
          ),
          child: Text(
            "${connectionType.name}://${ipDomainController.text}${portController.text != '' ? ':${portController.text}' : ""}${pathController.text}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
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
            else {
              setState(() => nameError = AppLocalizations.of(context)!.nameNotEmpty);
            } 
            validateData();
          },
          isConnecting: isConnecting,
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.connection,
          padding: const EdgeInsets.all(24),
        ),
        SegmentedButtonSlide(
          entries: const [
            SegmentedButtonSlideEntry(label: "HTTP"),
            SegmentedButtonSlideEntry(label: "HTTPS"),
          ], 
          selectedEntry: connectionType.index, 
          onChange: (v) => setState(() => connectionType = ConnectionType.values[v]), 
          colors: SegmentedButtonSlideColors(
            barColor: Theme.of(context).colorScheme.primary.withOpacity(0.2), 
            backgroundSelectedColor: Theme.of(context).colorScheme.primary, 
            foregroundSelectedColor: Theme.of(context).colorScheme.onPrimary, 
            foregroundUnselectedColor: Theme.of(context).colorScheme.onSurface, 
            hoverColor: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textOverflow: TextOverflow.ellipsis,
          fontSize: 14,
          height: 40,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
        ),
        if (connectionType == ConnectionType.https) Card(
          margin: const EdgeInsets.only(
            top: 16, left: 24, right: 24
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.info_rounded),
                const SizedBox(width: 16),
                Flexible(child: Text(AppLocalizations.of(context)!.sslWarning))
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        FormTextField(
          label: AppLocalizations.of(context)!.ipDomain, 
          controller: ipDomainController, 
          icon: Icons.link_rounded,
          error: ipDomainError,
          keyboardType: TextInputType.url,
          onChanged: (v) {
            setState(() => ipDomainError = validateAddress(context: context, value: v));
            validateData();
          },
          isConnecting: isConnecting,
        ),
        const SizedBox(height: 20),
        FormTextField(
          label: AppLocalizations.of(context)!.path, 
          controller: pathController, 
          icon: Icons.route_rounded,
          error: pathError,
          onChanged: (v) {
            setState(() => pathError = validateSubroute(context: context, value: v));
            validateData();
          },
          hintText: AppLocalizations.of(context)!.examplePath,
          helperText: AppLocalizations.of(context)!.helperPath,
          isConnecting: isConnecting,
        ),
        const SizedBox(height: 20),
        FormTextField(
          label: AppLocalizations.of(context)!.port, 
          controller: portController, 
          icon: Icons.numbers_rounded,
          error: portError,
          keyboardType: TextInputType.number,
          onChanged: (v) {
            setState(() => portError = validatePort(context: context, value: v));
            validateData();
          },
          isConnecting: isConnecting,
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.authentication,
          padding: const EdgeInsets.all(24),
        ),
        FormTextField(
          label: AppLocalizations.of(context)!.username, 
          controller: userController, 
          icon: Icons.person_rounded,
          isConnecting: isConnecting,
        ),
        const SizedBox(height: 20),
        FormTextField(
          label: AppLocalizations.of(context)!.password, 
          controller: passwordController, 
          icon: Icons.lock_rounded,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
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
        CustomSwitchListTile(
          value: homeAssistant, 
          onChanged:  (value) => setState(() => homeAssistant = value),
          title: AppLocalizations.of(context)!.runningHomeAssistant,
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
          body: ListView(
            children: form()
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