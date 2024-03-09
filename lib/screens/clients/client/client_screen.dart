import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/client_form.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';

import 'package:adguard_home_manager/models/safe_search.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';

class ClientInitialData {
  final String name;
  final String ip;

  const ClientInitialData({
    required this.name,
    required this.ip,
  });
}  

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
  final ClientInitialData? initialData;

  const ClientScreen({
    super.key,
    this.client,
    required this.onConfirm,
    this.onDelete,
    required this.fullScreen,
    this.initialData,
  });

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final _scrollController = ScrollController();

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

  bool _ignoreClientQueryLog = false;
  bool _ignoreClientStatistics = false;

  bool _enableDnsCache = false;
  final _dnsCacheField = TextEditingController();
  String? _dnsCacheError;
  
  BlockedServicesSchedule _blockedServicesSchedule = BlockedServicesSchedule();

  // VALIDATIONS
  bool _nameValid = true;
  bool _identifiersValid = true;
  bool _dnsCacheValid = true;

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
      _ignoreClientQueryLog = widget.client!.ignoreQuerylog ?? false;
      _ignoreClientStatistics = widget.client!.ignoreStatistics ?? false;
      _enableDnsCache = widget.client!.upstreamsCacheEnabled ?? false;
      _dnsCacheField.text = widget.client!.upstreamsCacheSize != null
        ? widget.client!.upstreamsCacheSize.toString()
        : "";
      if (widget.client!.blockedServicesSchedule != null) {
        _blockedServicesSchedule = widget.client!.blockedServicesSchedule!;
      }
    }
    if (widget.initialData != null) {
      nameController.text = widget.initialData!.name;
      identifiersControllers[0] = ControllerListItem(
        id: uuid.v4(), 
        controller: TextEditingController(text: widget.initialData!.ip)
      );
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
        tags: selectedTags,
        ignoreQuerylog: _ignoreClientQueryLog,
        ignoreStatistics: _ignoreClientStatistics,
        upstreamsCacheEnabled: _enableDnsCache,
        upstreamsCacheSize: _dnsCacheField.text != ""
          ? int.parse(_dnsCacheField.text)
          : null,
        blockedServicesSchedule: _blockedServicesSchedule
      );
      widget.onConfirm(client);
    }

    void validateValues() {
      _nameValid = nameController.text != '';
      _identifiersValid = identifiersControllers.isNotEmpty && identifiersControllers[0].controller.text != '';
      _dnsCacheValid = (_dnsCacheField.text == "" || _dnsCacheField.text != "" && RegExp(r'^\d+$').hasMatch(_dnsCacheField.text));
      if (_nameValid && _identifiersValid && _dnsCacheValid) {
        createClient();
        Navigator.pop(context);
      }
      else {
        _scrollController.animateTo(
          0, 
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500)
        );
        setState(() => {});
      }
    }

    List<Widget> actions() {
      return [
        IconButton(
          onPressed: validateValues,
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
      return Material(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar.large(
                pinned: true,
                floating: true,
                centerTitle: false,
                forceElevated: innerBoxIsScrolled,
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
              )
            )
          ], 
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) => CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverList.list(
                    children: [
                      if (!_nameValid || !_identifiersValid || !_dnsCacheValid) _Errors(
                        nameValid: _nameValid, 
                        identifiersValid: _identifiersValid, 
                        dnsCacheValid: _dnsCacheValid
                      ),
                      ClientForm(
                        isFullScreen: true,
                        client: widget.client, 
                        nameController: nameController,
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
                        ignoreClientQueryLog: _ignoreClientQueryLog,
                        ignoreClientStatistics: _ignoreClientStatistics,
                        updateIgnoreClientQueryLog: (v) => setState(() => _ignoreClientQueryLog = v),
                        updateIgnoreClientStatistics: (v) => setState(() => _ignoreClientStatistics = v),
                        enableDnsCache: _enableDnsCache,
                        updateEnableDnsCache: (v) => setState(() => _enableDnsCache = v),
                        dnsCacheField: _dnsCacheField,
                        dnsCacheError: _dnsCacheError,
                        updateDnsCacheError: (v) => setState(() => _dnsCacheError = v),
                        blockedServicesSchedule: _blockedServicesSchedule,
                        setBlockedServicesSchedule: (v) => setState(() => _blockedServicesSchedule = v),
                      ),
                    ],
                  )
                ],
              ),
            )
          )
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
                child: ListView(
                  controller: _scrollController,
                  children: [
                    if (!_nameValid || !_identifiersValid || !_dnsCacheValid) _Errors(
                      nameValid: _nameValid, 
                      identifiersValid: _identifiersValid, 
                      dnsCacheValid: _dnsCacheValid
                    ),
                    ClientForm(
                      isFullScreen: false,
                      client: widget.client, 
                      nameController: nameController,
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
                      ignoreClientQueryLog: _ignoreClientQueryLog,
                      ignoreClientStatistics: _ignoreClientStatistics,
                      updateIgnoreClientQueryLog: (v) => setState(() => _ignoreClientQueryLog = v),
                      updateIgnoreClientStatistics: (v) => setState(() => _ignoreClientStatistics = v),
                      enableDnsCache: _enableDnsCache,
                      updateEnableDnsCache: (v) => setState(() => _enableDnsCache = v),
                      dnsCacheField: _dnsCacheField,
                      dnsCacheError: _dnsCacheError,
                      updateDnsCacheError: (v) => setState(() => _dnsCacheError = v), 
                      blockedServicesSchedule: _blockedServicesSchedule,
                      setBlockedServicesSchedule: (v) => setState(() => _blockedServicesSchedule = v),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class _Errors extends StatelessWidget {
  final bool nameValid;
  final bool identifiersValid;
  final bool dnsCacheValid;

  const _Errors({
    required this.nameValid,
    required this.identifiersValid,
    required this.dnsCacheValid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.red.withOpacity(0.2),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.errors,
              style: const TextStyle(
                fontSize: 18
              ),
            ),
            const SizedBox(height: 8),
            if (!nameValid) Text(
              "● ${AppLocalizations.of(context)!.nameInvalid}",
              style: const TextStyle(
                fontSize: 14
              ),
            ),
            if (!identifiersValid) Text(
              "● ${AppLocalizations.of(context)!.oneIdentifierRequired}",
              style: const TextStyle(
                fontSize: 14
              ),
            ),
            if (!dnsCacheValid) Text(
              "● ${AppLocalizations.of(context)!.dnsCacheNumber}",
              style: const TextStyle(
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}