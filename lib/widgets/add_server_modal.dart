// ignore_for_file: use_build_context_synchronously

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_toggle.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/encode_base64.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/config/system_overlay_style.dart';

class AddServerModal extends StatefulWidget {
  final Server? server;

  const AddServerModal({
    Key? key,
    this.server,
  }) : super(key: key);

  @override
  State<AddServerModal> createState() => _AddServerModalState();
}

class _AddServerModalState extends State<AddServerModal> {
  final uuid = const Uuid();

  final TextEditingController nameController = TextEditingController();
  String? nameError;

  String connectionType = "http";

  final TextEditingController ipDomainController = TextEditingController();
  String? ipDomainError;

  final TextEditingController pathController = TextEditingController();
  String? pathError;

  final TextEditingController portController = TextEditingController();
  String? portError;

  final TextEditingController userController = TextEditingController();
  String? userError;

  final TextEditingController passwordController = TextEditingController();
  String? passwordError;

  bool defaultServer = false;

  bool homeAssistant = false;

  bool allDataValid = false;

  bool isConnecting = false;

  Widget sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20, 
        vertical: 30
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget textField({
    required String label,
    required TextEditingController controller,
    String? error,
    required IconData icon,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    bool? obscureText,
    String? hintText,
    String? helperText
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          errorText: error,
          hintText: hintText,
          helperText: helperText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            )
          ),
          labelText: label,
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  void checkDataValid() {
    if (
      nameController.text != '' &&
      ipDomainController.text != '' &&
      ipDomainError == null &&
      pathError == null && 
      portError == null && 
      userController.text != '' && 
      passwordController.text != ''
    ) {
      setState(() {
        allDataValid = true;
      });
    }
    else {
      setState(() {
        allDataValid = false;
      });
    }
  }


  void validatePort(String? value) {
    if (value != null && value != '') {
      if (int.tryParse(value) != null && int.parse(value) <= 65535) {
        setState(() {
          portError = null;
        });
      }
      else {
        setState(() {
          portError = AppLocalizations.of(context)!.invalidPort;
        });
      }
    }
    else {
      setState(() {
        portError = null;
      });
    }
    checkDataValid();
  }

  void validateSubroute(String? value) {
    if (value != null && value != '') {
      RegExp subrouteRegexp = RegExp(r'^\/\b([A-Za-z0-9_\-~/]*)[^\/|\.|\:]$');
      if (subrouteRegexp.hasMatch(value) == true) {
        setState(() {
          pathError = null;
        });
      }
      else {
        setState(() {
          pathError = AppLocalizations.of(context)!.invalidPath;
        });
      }
    }
    else {
      setState(() {
        pathError = null;
      });
    }
    checkDataValid();
  }

  void validateAddress(String? value) {
    if (value != null && value != '') {
      RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
      RegExp domain = RegExp(r'^([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
      if (ipAddress.hasMatch(value) == true || domain.hasMatch(value) == true) {
        setState(() {
          ipDomainError = null;
        });
      }
      else {
        setState(() {
          ipDomainError = AppLocalizations.of(context)!.invalidIpDomain;
        });
      }
    }
    else {
      setState(() {
        ipDomainError = AppLocalizations.of(context)!.ipDomainNotEmpty;
      });
    }
    checkDataValid();
  }

  void validateUser(String? value) {
    if (value != null && value != '') {
      setState(() {
        userError = null;
      });
    }
    else {
      setState(() {
        userError = AppLocalizations.of(context)!.userNotEmpty;
      });
    }
    checkDataValid();
  }

  void validatePassword(String? value) {
    if (value != null && value != '') {
      setState(() {
        passwordError = null;
      });
    }
    else {
      setState(() {
        passwordError = AppLocalizations.of(context)!.passwordNotEmpty;
      });
    }
    checkDataValid();
  }

  @override
  void initState() {
    if (widget.server != null) {
      nameController.text = widget.server!.name;
      connectionType = widget.server!.connectionMethod;
      ipDomainController.text = widget.server!.domain;
      pathController.text = widget.server!.path ?? '';
      portController.text = widget.server!.port != null ? widget.server!.port.toString() : "";
      userController.text = widget.server!.user;
      passwordController.text = widget.server!.password;
      defaultServer = widget.server!.defaultServer;
      homeAssistant = widget.server!.runningOnHa;
    }
    checkDataValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);

    final mediaQuery = MediaQuery.of(context);

    void connect() async {
      Server serverObj = Server(
        id: uuid.v4(),
        name: nameController.text, 
        connectionMethod: connectionType, 
        domain: ipDomainController.text, 
        port: int.parse(portController.text),
        user: userController.text, 
        password: passwordController.text, 
        defaultServer: defaultServer,
        authToken: homeAssistant == true 
          ? encodeBase64UserPass(userController.text, passwordController.text)
          : '',
        runningOnHa: homeAssistant
      );
      setState(() => isConnecting = true);

      final result = homeAssistant == true 
        ? await loginHA(serverObj)
        : await login(serverObj);

      setState(() => isConnecting = false);

      if (result['result'] == 'success') {
        serverObj.authToken = encodeBase64UserPass(serverObj.user, serverObj.password);
        final serverCreated = await serversProvider.createServer(serverObj);
        if (serverCreated == true) {
          serversProvider.setServerStatusLoad(0);
          final serverStatus = await getServerStatus(serverObj);
          if (serverStatus['result'] == 'success') {
            serversProvider.setServerStatusData(serverStatus['data']);
            serversProvider.setServerStatusLoad(1);
          }
          else {
            appConfigProvider.addLog(serverStatus['log']);
            serversProvider.setServerStatusLoad(2);
          }
          Navigator.pop(context);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.connectionNotCreated),
              backgroundColor: Colors.red,
            )
          );
        }
      }
      else if (result['result'] == 'invalid_username_password') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.invalidUsernamePassword),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'many_attempts') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.tooManyAttempts),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'no_connection') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cantReachServer),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'ssl_error') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.sslError),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'server_error') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.serverError),
            backgroundColor: Colors.red,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.unknownError),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void edit() async {
      final Server serverObj = Server(
        id: widget.server!.id,
        name: nameController.text, 
        connectionMethod: connectionType, 
        domain: ipDomainController.text, 
        port: int.parse(portController.text),
        user: userController.text, 
        password: passwordController.text, 
        defaultServer: defaultServer,
        authToken: homeAssistant == true 
          ? encodeBase64UserPass(userController.text, passwordController.text)
          : '',
        runningOnHa: homeAssistant
      );
      
      final result = homeAssistant == true 
        ? await loginHA(serverObj)
        : await login(serverObj);

      if (result['result'] == 'success') {
        serverObj.authToken = encodeBase64UserPass(serverObj.user, serverObj.password);
        final serverSaved = await serversProvider.editServer(serverObj);
        if (serverSaved == true) {
          Navigator.pop(context);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.connectionNotUpdated),
              backgroundColor: Colors.red,
            )
          );
        }
      }
      else if (result['result'] == 'invalid_username_password') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.invalidUsernamePassword),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'many_attempts') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.tooManyAttempts),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'no_connection') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cantReachServer),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'ssl_error') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.sslError),
            backgroundColor: Colors.red,
          )
        );
      }
      else if (result['result'] == 'server_error') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.serverError),
            backgroundColor: Colors.red,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.unknownError),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
           appBar: AppBar(
            systemOverlayStyle: systemUiOverlayStyleConfig(context),
            title: Text(AppLocalizations.of(context)!.createConnection),
            elevation: 5,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  tooltip: widget.server == null 
                    ? AppLocalizations.of(context)!.connect
                    : AppLocalizations.of(context)!.save,
                  onPressed: allDataValid == true 
                    ? widget.server == null 
                      ? () => connect()
                      : () => edit()
                    : null,
                  icon: Icon(
                    widget.server == null
                      ? Icons.login_rounded
                      : Icons.save_rounded
                  )
                ),
              ),
            ],
            toolbarHeight: 70,
          ),
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Theme.of(context).primaryColor
                  )
                ),
                child: Text(
                  "$connectionType://${ipDomainController.text}${pathController.text}${portController.text != '' ? ':${portController.text}' : ""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              sectionLabel(AppLocalizations.of(context)!.general),
              textField(
                label: AppLocalizations.of(context)!.name, 
                controller: nameController, 
                icon: Icons.badge_rounded,
                error: nameError,
                onChanged: (value) => value == ''
                  ? setState(() => nameError = AppLocalizations.of(context)!.nameNotEmpty)
                  : setState(() => nameError = null)
              ),
              sectionLabel(AppLocalizations.of(context)!.connection),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRadioToggle(
                    groupSelected: connectionType, 
                    value: 'http', 
                    label: 'HTTP', 
                    onTap: (value) => setState(() => connectionType = value)
                  ),
                  CustomRadioToggle(
                    groupSelected: connectionType, 
                    value: 'https', 
                    label: 'HTTPS', 
                    onTap: (value) => setState(() => connectionType = value)
                  ),
                ],
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.ipDomain, 
                controller: ipDomainController, 
                icon: Icons.link_rounded,
                error: ipDomainError,
                keyboardType: TextInputType.url,
                onChanged: validateAddress
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.path, 
                controller: pathController, 
                icon: Icons.route_rounded,
                error: pathError,
                onChanged: validateSubroute,
                hintText: AppLocalizations.of(context)!.examplePath,
                helperText: AppLocalizations.of(context)!.helperPath,
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.port, 
                controller: portController, 
                icon: Icons.numbers_rounded,
                error: portError,
                keyboardType: TextInputType.number,
                onChanged: validatePort
              ),
              sectionLabel(AppLocalizations.of(context)!.authentication),
              textField(
                label: AppLocalizations.of(context)!.username, 
                controller: userController, 
                icon: Icons.person_rounded,
                onChanged: validateUser,
                error: userError
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.password, 
                controller: passwordController, 
                icon: Icons.lock_rounded,
                keyboardType: TextInputType.visiblePassword,
                onChanged: validatePassword,
                error: passwordError,
                obscureText: true
              ),
              sectionLabel(AppLocalizations.of(context)!.other),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.server == null
                    ? () => setState(() => defaultServer = !defaultServer)
                    : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.defaultServer,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Switch(
                          value: defaultServer, 
                          onChanged: widget.server == null 
                            ? (value) => setState(() => defaultServer = value)
                            : null,
                          activeColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => homeAssistant = !homeAssistant),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.runningHomeAssistant,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Switch(
                          value: homeAssistant, 
                          onChanged: (value) => setState(() => homeAssistant = value),
                          activeColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: isConnecting == true ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: IgnorePointer(
            ignoring: isConnecting == true ? false : true,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height,
                color: const Color.fromRGBO(0, 0, 0, 0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.connecting,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 26
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}