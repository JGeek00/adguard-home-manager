import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/client_form.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';

import 'package:adguard_home_manager/models/safe_search.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';

class ControllerListItem {
  final String id;
  final TextEditingController controller;

  const ControllerListItem({
    required this.id,
    required this.controller
  });
}

class ClientScreen extends StatefulWidget {
  final Client? client;
  final void Function(Client) onConfirm;
  final void Function(Client)? onDelete;
  final bool fullScreen;

  const ClientScreen({
    Key? key,
    this.client,
    required this.onConfirm,
    this.onDelete,
    required this.fullScreen
  }) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Uuid uuid = const Uuid();
  
  bool validValues = false;

  TextEditingController nameController = TextEditingController();

  List<String> selectedTags = [];

  List<ControllerListItem> identifiersControllers = [
    ControllerListItem(id: "0", controller: TextEditingController())
  ];

  bool useGlobalSettingsFiltering = true;
  bool? enableFiltering;
  bool? enableSafeBrowsing;
  bool? enableParentalControl;
  bool? enableSafeSearch;
  SafeSearch? safeSearch;

  final SafeSearch defaultSafeSearch = SafeSearch(
    enabled: false,
    bing: false,
    duckduckgo: false,
    google: false,
    pixabay: false,
    yandex: false,
    youtube: false
  );

  bool useGlobalSettingsServices = true;
  List<String> blockedServices = [];

  List<ControllerListItem> upstreamServers = [];

  void enableDisableGlobalSettingsFiltering() {
    if (useGlobalSettingsFiltering == true) {
      setState(() {
        useGlobalSettingsFiltering = false;
          
        enableFiltering = false;
        enableSafeBrowsing = false;
        enableParentalControl = false;
        enableSafeSearch = false;
        safeSearch = defaultSafeSearch;
      });
    }
    else if (useGlobalSettingsFiltering == false) {
      setState(() {
        useGlobalSettingsFiltering = true;
         
        enableFiltering = null;
        enableSafeBrowsing = null;
        enableParentalControl = null;
        enableSafeSearch = null;
        safeSearch = null;
      });
    }
  }

  @override
  void initState() {
    if (widget.client != null) {
      validValues = true;

      nameController.text = widget.client!.name;
      selectedTags = widget.client!.tags;
      identifiersControllers = widget.client!.ids.map((e) => ControllerListItem(
        id: uuid.v4(), 
        controller: TextEditingController(text: e)
      )).toList();
      useGlobalSettingsFiltering = widget.client!.useGlobalSettings;
      enableFiltering = widget.client!.filteringEnabled;
      enableParentalControl = widget.client!.parentalEnabled;
      enableSafeBrowsing = widget.client!.safebrowsingEnabled;
      safeSearch = widget.client!.safeSearch;
      useGlobalSettingsServices = widget.client!.useGlobalBlockedServices;
      blockedServices = widget.client!.blockedServices;
      upstreamServers = widget.client!.upstreams.map((e) => ControllerListItem(
        id: uuid.v4(), 
        controller: TextEditingController(text: e)
      )).toList();
    }
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    void createClient() {
      final Client client = Client(
        name: nameController.text, 
        ids: List<String>.from(identifiersControllers.map((e) => e.controller.text)), 
        useGlobalSettings: useGlobalSettingsFiltering, 
        filteringEnabled: enableFiltering ?? false, 
        parentalEnabled: enableParentalControl ?? false, 
        safebrowsingEnabled: enableSafeBrowsing ?? false, 
        safeSearch: safeSearch,
        useGlobalBlockedServices: useGlobalSettingsServices, 
        blockedServices: blockedServices, 
        upstreams: List<String>.from(upstreamServers.map((e) => e.controller.text)), 
        tags: selectedTags
      );
      widget.onConfirm(client);
    }

    List<Widget> actions() {
      return [
        IconButton(
          onPressed: validValues == true
            ? () {
                createClient();
                Navigator.pop(context);
              }
            : null, 
          icon: const Icon(Icons.save_rounded),
          tooltip: AppLocalizations.of(context)!.save,
        ),
        if (widget.client != null) IconButton(
          onPressed: () => openDeleteClientScreen(
            context: context,
            onDelete: () => clientsProvider.deleteClient(widget.client!),
          ), 
          icon: const Icon(Icons.delete_rounded),
          tooltip: AppLocalizations.of(context)!.delete,
        ),
        const SizedBox(width: 10),
      ];
    }


    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Scaffold(
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
            actions: actions(),
          ),
          body: ClientForm(
            isFullScreen: true,
            client: widget.client, 
            nameController: nameController,
            updateValidValues: (v) => setState(() => validValues = v), 
            identifiersControllers: identifiersControllers, 
            selectedTags: selectedTags, 
            useGlobalSettingsFiltering: useGlobalSettingsFiltering, 
            enableFiltering: enableFiltering, 
            enableParentalControl: enableParentalControl, 
            enableSafeBrowsing: enableSafeBrowsing, 
            enableSafeSearch: enableSafeSearch, 
            safeSearch: safeSearch, 
            blockedServices: blockedServices, 
            updateBlockedServices: (v) => setState(() => blockedServices = v), 
            upstreamServers: upstreamServers, 
            updateUpstreamServers: (v) => setState(() => upstreamServers = v), 
            defaultSafeSearch: defaultSafeSearch, 
            useGlobalSettingsServices: useGlobalSettingsServices, 
            updateSelectedTags: (v) => setState(() => selectedTags = v),
            updateIdentifiersControllers: (v) => setState(() => identifiersControllers = v), 
            enableDisableGlobalSettingsFiltering: enableDisableGlobalSettingsFiltering, 
            updateEnableFiltering: (v) => setState(() => enableFiltering = v), 
            updateEnableParentalControl: (v) => setState(() => enableParentalControl = v), 
            updateEnableSafeBrowsing: (v) => setState(() => enableSafeBrowsing = v), 
            updateEnableSafeSearch: (v) => setState(() => enableSafeSearch = v), 
            updateSafeSearch: (v) => setState(() => safeSearch = v), 
            updateUseGlobalSettingsServices: (v) => setState(() => useGlobalSettingsServices = v), 
          ),
        ),
      );
    } 
    else {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CloseButton(onPressed: () => Navigator.pop(context)),
                        const SizedBox(width: 8),
                        Text(
                          widget.client != null 
                            ? AppLocalizations.of(context)!.client
                            : AppLocalizations.of(context)!.addClient,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: actions()
                    )
                  ],
                ),
              ),
              Flexible(
                child:  ClientForm(
                  isFullScreen: false,
                  client: widget.client, 
                  nameController: nameController,
                  updateValidValues: (v) => setState(() => validValues = v), 
                  identifiersControllers: identifiersControllers, 
                  selectedTags: selectedTags, 
                  useGlobalSettingsFiltering: useGlobalSettingsFiltering, 
                  enableFiltering: enableFiltering, 
                  enableParentalControl: enableParentalControl, 
                  enableSafeBrowsing: enableSafeBrowsing, 
                  enableSafeSearch: enableSafeSearch, 
                  safeSearch: safeSearch, 
                  blockedServices: blockedServices, 
                  updateBlockedServices: (v) => setState(() => blockedServices = v), 
                  upstreamServers: upstreamServers, 
                  updateUpstreamServers: (v) => setState(() => upstreamServers = v), 
                  defaultSafeSearch: defaultSafeSearch, 
                  useGlobalSettingsServices: useGlobalSettingsServices, 
                  updateSelectedTags: (v) => setState(() => selectedTags = v),
                  updateIdentifiersControllers: (v) => setState(() => identifiersControllers = v), 
                  enableDisableGlobalSettingsFiltering: enableDisableGlobalSettingsFiltering, 
                  updateEnableFiltering: (v) => setState(() => enableFiltering = v), 
                  updateEnableParentalControl: (v) => setState(() => enableParentalControl = v), 
                  updateEnableSafeBrowsing: (v) => setState(() => enableSafeBrowsing = v), 
                  updateEnableSafeSearch: (v) => setState(() => enableSafeSearch = v), 
                  updateSafeSearch: (v) => setState(() => safeSearch = v), 
                  updateUseGlobalSettingsServices: (v) => setState(() => useGlobalSettingsServices = v), 
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

