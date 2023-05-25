import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/safe_search_modal.dart';
import 'package:adguard_home_manager/screens/clients/services_modal.dart';
import 'package:adguard_home_manager/screens/clients/tags_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/safe_search.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';

class ClientScreen extends StatefulWidget {
  final Client? client;
  final String serverVersion;
  final void Function(Client) onConfirm;
  final void Function(Client)? onDelete;
  final bool dialog;

  const ClientScreen({
    Key? key,
    this.client,
    required this.serverVersion,
    required this.onConfirm,
    this.onDelete,
    required this.dialog
  }) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Uuid uuid = const Uuid();
  bool editMode = true;

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


  void checkValidValues() {
    if (
      nameController.text != '' &&
      identifiersControllers.isNotEmpty && 
      identifiersControllers[0]['controller'].text != ''
    ) {
      setState(() => validValues = true);
    }
    else {
      setState(() => validValues = false);
    }
  }

  bool version = false;

  @override
  void initState() {
    version = serverVersionIsAhead(
      currentVersion: widget.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    );

    if (widget.client != null) {
      editMode = false;

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

    Widget sectionLabel({
      required String label, 
      EdgeInsets? padding
    }) {
      return Padding(
        padding: padding ?? const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary
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

    void openTagsModal() {
      showDialog(
        context: context, 
        builder: (context) => TagsModal(
          selectedTags: selectedTags,
          tags: clientsProvider.clients!.supportedTags,
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

    void openSafeSearchModal() {
      showDialog(
        context: context, 
        builder: (context) => SafeSearchModal(
          safeSearch: safeSearch ?? defaultSafeSearch, 
          disabled: !editMode,
          onConfirm: (s) => setState(() => safeSearch = s)
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
              horizontal: 42,
              vertical: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                useGlobalSettingsFiltering == false
                  ? Switch(
                      value: value!, 
                      onChanged: onChange,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12
                      ),
                      child: Text(
                        "Global",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    )
              ],
            ),
          ),
        ),
      );
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
          sectionLabel(label: AppLocalizations.of(context)!.tags),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: editMode == true ? () => openTagsModal() : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 24
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.label_rounded,
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectTags,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          selectedTags.isNotEmpty
                            ? "${selectedTags.length} ${AppLocalizations.of(context)!.tagsSelected}"
                            : AppLocalizations.of(context)!.noTagsSelected,
                          style: TextStyle(
                            color: Theme.of(context).listTileTheme.iconColor
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
              sectionLabel(
                label: AppLocalizations.of(context)!.identifiers,
                padding: const  EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 12
                )
              ),
              if (editMode == true) Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () => setState(() => identifiersControllers.add(
                    Map<String, Object>.from({
                      'id': uuid.v4(),
                      'controller': TextEditingController()
                    })
                  )),
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
          if (identifiersControllers.isNotEmpty) ...identifiersControllers.map((controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          )).toList(),
          if (identifiersControllers.isEmpty) Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              AppLocalizations.of(context)!.noIdentifiers,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          sectionLabel(
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Switch(
                        value: useGlobalSettingsFiltering, 
                        onChanged: editMode == true
                          ? (value) => enableDisableGlobalSettingsFiltering()
                          : null,
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
              ? () => openSafeSearchModal()
              : null,
          ),
          if (
            serverVersionIsAhead(
              currentVersion: statusProvider.serverStatus!.serverVersion, 
              referenceVersion: 'v0.107.28',
              referenceVersionBeta: 'v0.108.0-b.33'
            ) == false
          ) settignsTile(
            label: AppLocalizations.of(context)!.enableSafeSearch,
            value: enableSafeSearch, 
            onChange: editMode == true
              ? (value) => setState(() => enableSafeSearch = value)
              : null
          ),
          sectionLabel(label: AppLocalizations.of(context)!.blockedServices),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Switch(
                        value: useGlobalSettingsServices, 
                        onChanged: editMode == true
                          ? (value) => updateServicesGlobalSettings(value)
                          : null,
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
                  vertical: 8, horizontal: 24
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.public,
                      color: useGlobalSettingsServices == false
                        ? Theme.of(context).listTileTheme.iconColor
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectBlockedServices,
                          style: TextStyle(
                            fontSize: 16,
                            color: useGlobalSettingsServices == false
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                          ),
                        ),
                        if (useGlobalSettingsServices == false) ...[
                          const SizedBox(height: 5),
                          Text(
                            blockedServices.isNotEmpty
                              ? "${blockedServices.length} ${AppLocalizations.of(context)!.servicesBlocked}"
                              :  AppLocalizations.of(context)!.noBlockedServicesSelected,
                            style: TextStyle(
                              color: Theme.of(context).listTileTheme.iconColor  
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
              sectionLabel(label: AppLocalizations.of(context)!.upstreamServers),
              if (editMode == true) Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () => setState(() => upstreamServers.add(
                    Map<String, Object>.from({
                      'id': uuid.v4(),
                      'controller': TextEditingController()
                    })
                  )),
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
                  Expanded(
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
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.noUpstreamServers,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.willBeUsedGeneralServers,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }

    if (widget.dialog == true) {
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
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded)
                        ),
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
                      children: [
                        if (widget.client == null || (widget.client != null && editMode == true)) IconButton(
                          onPressed: validValues == true
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
    else {
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
              onPressed: validValues == true
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
        body: content(true)
      );
    }
  }
}