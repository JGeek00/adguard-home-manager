import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/upstream_servers_section.dart';
import 'package:adguard_home_manager/screens/clients/client/identifiers_section.dart';
import 'package:adguard_home_manager/screens/clients/client/blocked_services_section.dart';
import 'package:adguard_home_manager/screens/clients/client/tags_section.dart';
import 'package:adguard_home_manager/screens/clients/client/settings_tile.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/safe_search.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';

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

  List<Map<dynamic, dynamic>> upstreamServers = [];

  bool version = false;

  @override
  void initState() {
    version = serverVersionIsAhead(
      currentVersion: Provider.of<StatusProvider>(context, listen: false).serverStatus!.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    );

    if (widget.client != null) {
      validValues = true;

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
      if (version == true) {
        safeSearch = widget.client!.safeSearch;
      }
      else {
        enableSafeSearch = widget.client!.safesearchEnabled ?? false;
      }
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
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);

    void createClient() {
      final Client client = Client(
        name: nameController.text, 
        ids: List<String>.from(identifiersControllers.map((e) => e['controller'].text)), 
        useGlobalSettings: useGlobalSettingsFiltering, 
        filteringEnabled: enableFiltering ?? false, 
        parentalEnabled: enableParentalControl ?? false, 
        safebrowsingEnabled: enableSafeBrowsing ?? false, 
        safesearchEnabled: version == false ? enableSafeSearch : null, 
        safeSearch: version == true ? safeSearch : null, 
        useGlobalBlockedServices: useGlobalSettingsServices, 
        blockedServices: blockedServices, 
        upstreams: List<String>.from(upstreamServers.map((e) => e['controller'].text)), 
        tags: selectedTags
      );
      widget.onConfirm(client);
    }

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

    Widget content(bool withPaddingTop) {
      return ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          if (withPaddingTop == true) const SizedBox(height: 24),
          if (withPaddingTop == false) const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              enabled: widget.client != null ? false : true,
              controller: nameController,
              onChanged: (_) => setState(() {
                validValues = checkValidValues(
                  identifiersControllers: identifiersControllers,
                  nameController: nameController
                );
              }),
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
          SectionLabel(
            label: AppLocalizations.of(context)!.tags,
            padding: const EdgeInsets.all(24),
          ),
          TagsSection(
            selectedTags: selectedTags, 
            onTagsSelected: (tags) => setState(() => selectedTags = tags)
          ),
          IdentifiersSection(
            identifiersControllers: identifiersControllers,
            onUpdateIdentifiersControllers: (c) => setState(() {
              identifiersControllers = c;
              validValues = checkValidValues(
                nameController: nameController, 
                identifiersControllers: identifiersControllers
              );
            }),
            onCheckValidValues: () => setState(() {
              validValues = checkValidValues(
                identifiersControllers: identifiersControllers,
                nameController: nameController
              );
            }),
          ),
          SectionLabel(
            label: AppLocalizations.of(context)!.settings,
            padding: const  EdgeInsets.only(
              left: 24, right: 24, top: 12, bottom: 24
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: () => enableDisableGlobalSettingsFiltering(),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Switch(
                        value: useGlobalSettingsFiltering, 
                        onChanged: (value) => enableDisableGlobalSettingsFiltering()
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SettingsTile(
            label: AppLocalizations.of(context)!.enableFiltering,
            value: enableFiltering, 
            onChange: (value) => setState(() => enableFiltering = value),
            useGlobalSettingsFiltering: useGlobalSettingsFiltering,
          ),
          SettingsTile(
            label: AppLocalizations.of(context)!.enableSafeBrowsing,
            value: enableSafeBrowsing, 
            onChange: (value) => setState(() => enableSafeBrowsing = value),
            useGlobalSettingsFiltering: useGlobalSettingsFiltering,
          ),
          SettingsTile(
            label: AppLocalizations.of(context)!.enableParentalControl,
            value: enableParentalControl, 
            onChange: (value) => setState(() => enableParentalControl = value),
            useGlobalSettingsFiltering: useGlobalSettingsFiltering,
          ),
          if (
            serverVersionIsAhead(
              currentVersion: statusProvider.serverStatus!.serverVersion, 
              referenceVersion: 'v0.107.28',
              referenceVersionBeta: 'v0.108.0-b.33'
            ) == true
          ) CustomListTile(
            title: AppLocalizations.of(context)!.safeSearch,
            padding: const  EdgeInsets.symmetric(
              horizontal: 42,
              vertical: 16
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.chevron_right_rounded,
                color: useGlobalSettingsFiltering == true
                  ? Colors.grey
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: useGlobalSettingsFiltering == false
              ? () => openSafeSearchModal(
                  context: context,
                  blockedServices: blockedServices,
                  defaultSafeSearch: defaultSafeSearch,
                  safeSearch: safeSearch,
                  onUpdateSafeSearch: (s) => setState(() => safeSearch = s)
                )
              : null,
          ),
          if (
            serverVersionIsAhead(
              currentVersion: statusProvider.serverStatus!.serverVersion, 
              referenceVersion: 'v0.107.28',
              referenceVersionBeta: 'v0.108.0-b.33'
            ) == false
          ) SettingsTile(
            label: AppLocalizations.of(context)!.enableSafeSearch,
            value: enableSafeSearch, 
            onChange: (value) => setState(() => enableSafeSearch = value),
            useGlobalSettingsFiltering: useGlobalSettingsFiltering,
          ),
          SectionLabel(
            label: AppLocalizations.of(context)!.blockedServices,
            padding: const EdgeInsets.all(24),
          ),
          BlockedServicesSection(
            useGlobalSettingsServices: useGlobalSettingsServices, 
            blockedServices: blockedServices, 
            onUpdatedBlockedServices: (s) => setState(() => blockedServices = s),
            onUpdateServicesGlobalSettings: (v) => setState(() => useGlobalSettingsServices = v),
          ),
          UpstreamServersSection(
            upstreamServers: upstreamServers, 
            onCheckValidValues: () => setState(() {
              validValues = checkValidValues(
                identifiersControllers: identifiersControllers,
                nameController: nameController
              );
            }),
            onUpdateUpstreamServers: (v) => setState(() => upstreamServers = v)
          ),
          const SizedBox(height: 20)
        ],
      );
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
          body: content(true)
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
                child: content(false)
              )
            ],
          ),
        ),
      );
    }
  }
}