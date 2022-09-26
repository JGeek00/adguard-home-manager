import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_toggle.dart';

import 'package:adguard_home_manager/config/system_overlay_style.dart';

class AddServerModal extends StatefulWidget {
  const AddServerModal({Key? key}) : super(key: key);

  @override
  State<AddServerModal> createState() => _AddServerModalState();
}

class _AddServerModalState extends State<AddServerModal> {
  final TextEditingController nameController = TextEditingController();

  String connectionType = "http";

  final TextEditingController ipDomainController = TextEditingController();
  String? ipDomainError;

  final TextEditingController pathController = TextEditingController();
  String? pathError;

  final TextEditingController portController = TextEditingController();
  String? portError;

  final TextEditingController userController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool defaultServer = false;

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
    TextInputType? keyboardType
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          errorText: error,
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

  @override
  Widget build(BuildContext context) {
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
                  tooltip: AppLocalizations.of(context)!.connect,
                  onPressed: () => {},
                  icon: const Icon(Icons.login_rounded)
                ),
              ),
            ],
            toolbarHeight: 70,
          ),
          body: ListView(
            children: [
              sectionLabel(AppLocalizations.of(context)!.general),
              textField(
                label: AppLocalizations.of(context)!.name, 
                controller: nameController, 
                icon: Icons.badge_rounded
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
                keyboardType: TextInputType.url
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.path, 
                controller: pathController, 
                icon: Icons.route_rounded,
                error: pathError
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.port, 
                controller: portController, 
                icon: Icons.numbers_rounded,
                error: portError,
                keyboardType: TextInputType.number
              ),
              sectionLabel(AppLocalizations.of(context)!.authentication),
              textField(
                label: AppLocalizations.of(context)!.username, 
                controller: userController, 
                icon: Icons.person_rounded,
              ),
              const SizedBox(height: 20),
              textField(
                label: AppLocalizations.of(context)!.password, 
                controller: passwordController, 
                icon: Icons.lock_rounded,
                keyboardType: TextInputType.visiblePassword
              ),
              sectionLabel(AppLocalizations.of(context)!.other),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => defaultServer = !defaultServer),
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
                          onChanged: (value) => setState(() => defaultServer = value),
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
        )
      ],
    );
  }
}