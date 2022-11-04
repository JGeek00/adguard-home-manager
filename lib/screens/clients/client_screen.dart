import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/services_modal.dart';
import 'package:adguard_home_manager/screens/clients/tags_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';

class ClientScreen extends StatefulWidget {
  final Client? client;
  final void Function(Client) onConfirm;
  final void Function(Client)? onDelete;

  const ClientScreen({
    Key? key,
    this.client,
    required this.onConfirm,
    this.onDelete,
  }) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Uuid uuid = const Uuid();
  bool editMode = true;

  TextEditingController nameController = TextEditingController();

  List<String> selectedTags = [];

  List<Map<dynamic, dynamic>> identifiersControllers = [
    {
      'id': 0,
      'controller': TextEditingController()
    }
  ];

  bool useGlobalSettingsFiltering = true;
  bool? enableFiltering;
  bool? enableSafeBrowsing;
  bool? enableParentalControl;
  bool? enableSafeSearch;

  bool useGlobalSettingsServices = true;
  List<String> blockedServices = [];

  List<Map<dynamic, dynamic>> upstreamServers = [];


  bool checkValidValues() {
    if (
      nameController.text != '' &&
      identifiersControllers.isNotEmpty && 
      identifiersControllers[0]['controller'].text != ''
    ) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  void initState() {
    if (widget.client != null) {
      editMode = false;

      nameController.text = widget.client!.name;
      selectedTags = widget.client!.tags;
      identifiersControllers = widget.client!.ids.map((e) => {
        'id': uuid.v4(),
        'controller': TextEditingController(text: e)
      }).toList();
      useGlobalSettingsFiltering = widget.client!.useGlobalSettings;
      enableFiltering = widget.client!.filteringEnabled;
      enableParentalControl = widget.client!.parentalEnabled;
      enableSafeBrowsing = widget.client!.safebrowsingEnabled;
      enableSafeSearch = widget.client!.safesearchEnabled;
      useGlobalSettingsServices = widget.client!.useGlobalBlockedServices;
      blockedServices = widget.client!.blockedServices;
      upstreamServers = widget.client!.upstreams.map((e) => {
        'id': uuid.v4(),
        'controller': TextEditingController(text: e)
      }).toList();
    }
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    void createClient() {
      final Client client = Client(
        name: nameController.text, 
        ids: List<String>.from(identifiersControllers.map((e) => e['controller'].text)), 
        useGlobalSettings: useGlobalSettingsFiltering, 
        filteringEnabled: enableFiltering ?? false, 
        parentalEnabled: enableParentalControl ?? false, 
        safebrowsingEnabled: enableSafeBrowsing ?? false, 
        safesearchEnabled: enableSafeSearch ?? false, 
        useGlobalBlockedServices: useGlobalSettingsServices, 
        blockedServices: blockedServices, 
        upstreams: List<String>.from(upstreamServers.map((e) => e['controller'].text)), 
        tags: selectedTags
      );
      widget.onConfirm(client);
    }

    Widget sectionLabel(String label) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Theme.of(context).primaryColor
          ),
        ),
      );
    }

    void enableDisableGlobalSettingsFiltering() {
      if (useGlobalSettingsFiltering == true) {
        setState(() {
          useGlobalSettingsFiltering = false;

          enableFiltering = false;
          enableSafeBrowsing = false;
          enableParentalControl = false;
          enableSafeSearch = false;
        });
      }
      else if (useGlobalSettingsFiltering == false) {
        setState(() {
          useGlobalSettingsFiltering = true;
          
          enableFiltering = null;
          enableSafeBrowsing = null;
          enableParentalControl = null;
          enableSafeSearch = null;
        });
      }
    }

    void openTagsModal() {
      showDialog(
        context: context, 
        builder: (context) => TagsModal(
          selectedTags: selectedTags,
          tags: serversProvider.clients.data!.supportedTags,
          onConfirm: (selected) => setState(() => selectedTags = selected),
        )
      );
    }

    void openServicesModal() {
      showDialog(
        context: context, 
        builder: (context) => ServicesModal(
          blockedServices: blockedServices,
          onConfirm: (values) => setState(() => blockedServices = values),
        )
      );
    }

    void updateServicesGlobalSettings(bool value) {
      if (value == true) {
        setState(() {
          blockedServices = [];
          useGlobalSettingsServices = true;
        });
      }
      else if (value == false) {
        setState(() {
          useGlobalSettingsServices = false;
        });
      }
    }

    void openDeleteClientScreen() {
      showDialog(
        context: context, 
        builder: (ctx) => RemoveClientModal(
          onConfirm: () {
            Navigator.pop(context);
            widget.onDelete!(widget.client!);
          }
        )
      );
    }

    Widget settignsTile({
      required String label,
      required bool? value,
      void Function(bool)? onChange
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onChange != null
            ?  value != null ? () => onChange(!value) : null
            : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15
                  ),
                ),
                useGlobalSettingsFiltering == false
                  ? Switch(
                      value: value!, 
                      onChanged: onChange,
                      activeColor: Theme.of(context).primaryColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Global",
                        style: TextStyle(
                          color: Theme.of(context).listTileTheme.iconColor,
                        ),
                      ),
                    )
              ],
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close)
        ),
        title: Text(
          widget.client != null 
            ? AppLocalizations.of(context)!.client
            : AppLocalizations.of(context)!.addClient
        ),
        actions: [
          if (widget.client == null || (widget.client != null && editMode == true)) IconButton(
            onPressed: checkValidValues() == true
              ? () {
                  createClient();
                  Navigator.pop(context);
                }
              : null, 
            icon: Icon(
              widget.client != null && editMode == true
                ? Icons.save_rounded
                : Icons.check_rounded
            ),
            tooltip: widget.client != null && editMode == true
              ? AppLocalizations.of(context)!.save
              : AppLocalizations.of(context)!.confirm,
          ),
          if (widget.client != null && editMode == false) IconButton(
            onPressed: () => setState(() => editMode = true), 
            icon: const Icon(Icons.edit_rounded),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          if (widget.client != null) IconButton(
            onPressed: openDeleteClientScreen, 
            icon: const Icon(Icons.delete_rounded),
            tooltip: AppLocalizations.of(context)!.delete,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              enabled: widget.client != null ? false : true,
              controller: nameController,
              onChanged: (_) => checkValidValues(),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.badge_rounded),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                labelText: AppLocalizations.of(context)!.name,
              ),
            ),
          ),
          sectionLabel(AppLocalizations.of(context)!.tags),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: editMode == true ? () => openTagsModal() : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.label_rounded,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectTags,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          selectedTags.isNotEmpty
                            ? "${selectedTags.length} ${AppLocalizations.of(context)!.tagsSelected}"
                            : AppLocalizations.of(context)!.noTagsSelected,
                          style: TextStyle(
                            color: Theme.of(context).listTileTheme.iconColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionLabel(AppLocalizations.of(context)!.identifiers),
              if (editMode == true) Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () => setState(() => identifiersControllers.add({
                    'id': uuid.v4(),
                    'controller': TextEditingController()
                  })),
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
          if (identifiersControllers.isNotEmpty) ...identifiersControllers.map((controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: editMode,
                      controller: controller['controller'],
                      onChanged: (_) => checkValidValues(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.tag),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        helperText: AppLocalizations.of(context)!.identifierHelper,
                        labelText: AppLocalizations.of(context)!.identifier,
                      ),
                    ),
                  ),
                  if (editMode == true) ...[
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: IconButton(
                        onPressed: () => setState(
                          () => identifiersControllers = identifiersControllers.where((e) => e['id'] != controller['id']).toList()
                        ), 
                        icon: const Icon(Icons.remove_circle_outline_outlined)
                      ),
                    )
                  ]
                ],
              ),
            ),
          )).toList(),
          if (identifiersControllers.isEmpty) Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              AppLocalizations.of(context)!.noIdentifiers,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
          ),
          sectionLabel(AppLocalizations.of(context)!.settings),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: editMode 
                  ? () => enableDisableGlobalSettingsFiltering()
                  : null,
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.useGlobalSettings,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: useGlobalSettingsFiltering, 
                        onChanged: editMode == true
                          ? (value) => enableDisableGlobalSettingsFiltering()
                          : null,
                        activeColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          settignsTile(
            label: AppLocalizations.of(context)!.enableFiltering,
            value: enableFiltering, 
            onChange: editMode == true
              ? (value) => setState(() => enableFiltering = value)
              : null
          ),
          settignsTile(
            label: AppLocalizations.of(context)!.enableSafeBrowsing,
            value: enableSafeBrowsing, 
            onChange: editMode == true
              ? (value) => setState(() => enableSafeBrowsing = value)
              : null
          ),
          settignsTile(
            label: AppLocalizations.of(context)!.enableParentalControl,
            value: enableParentalControl, 
            onChange: editMode == true
              ? (value) => setState(() => enableParentalControl = value)
              : null
          ),
          settignsTile(
            label: AppLocalizations.of(context)!.enableSafeSearch,
            value: enableSafeSearch, 
            onChange: editMode == true
              ? (value) => setState(() => enableSafeSearch = value)
              : null
          ),
          sectionLabel(AppLocalizations.of(context)!.blockedServices),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: editMode == true
                  ? () => updateServicesGlobalSettings(!useGlobalSettingsServices)
                  : null,
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.useGlobalSettings,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: useGlobalSettingsServices, 
                        onChanged: editMode == true
                          ? (value) => updateServicesGlobalSettings(value)
                          : null,
                        activeColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: editMode == true
                ? useGlobalSettingsServices == false
                  ? openServicesModal
                  : null
                : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.public,
                      color: useGlobalSettingsServices == false
                        ? null
                        : Colors.grey,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectBlockedServices,
                          style: TextStyle(
                            fontSize: 16,
                            color: useGlobalSettingsServices == false
                              ? null
                              : Theme.of(context).listTileTheme.iconColor,
                          ),
                        ),
                        if (useGlobalSettingsServices == false) ...[
                          const SizedBox(height: 5),
                          Text(
                            blockedServices.isNotEmpty
                              ? "${blockedServices.length} ${AppLocalizations.of(context)!.servicesBlocked}"
                              :  AppLocalizations.of(context)!.noBlockedServicesSelected,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.iconColor,
                            ),
                          )
                        ]
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionLabel(AppLocalizations.of(context)!.upstreamServers),
              if (editMode == true) Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () => setState(() => upstreamServers.add({
                    'id': uuid.v4(),
                    'controller': TextEditingController()
                  })),
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
          if (upstreamServers.isNotEmpty) ...upstreamServers.map((controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: editMode == true
                      ? MediaQuery.of(context).size.width - 108
                      : MediaQuery.of(context).size.width - 40,
                    child: TextFormField(
                      enabled: editMode,
                      controller: controller['controller'],
                      onChanged: (_) => checkValidValues(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.dns_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        labelText: AppLocalizations.of(context)!.serverAddress,
                      ),
                    ),
                  ),
                  if (editMode == true) ...[
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => setState(
                        () => upstreamServers = upstreamServers.where((e) => e['id'] != controller['id']).toList()
                      ), 
                      icon: const Icon(Icons.remove_circle_outline_outlined)
                    )
                  ]
                ],
              ),
            ),
          )).toList(),
          if (upstreamServers.isEmpty) Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.noUpstreamServers,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.willBeUsedGeneralServers,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}