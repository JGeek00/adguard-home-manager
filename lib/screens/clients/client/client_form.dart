import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/blocked_services_section.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';
import 'package:adguard_home_manager/screens/clients/client/identifiers_section.dart';
import 'package:adguard_home_manager/screens/clients/client/settings_tile.dart';
import 'package:adguard_home_manager/screens/clients/client/tags_section.dart';
import 'package:adguard_home_manager/screens/clients/client/upstream_servers_section.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/safe_search.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class ClientForm extends StatelessWidget {
  final bool isFullScreen;
  final Client? client;
  final TextEditingController nameController;
  final void Function(bool) updateValidValues;
  final List<ControllerListItem> identifiersControllers;
  final List<String> selectedTags;
  final bool useGlobalSettingsFiltering;
  final bool? enableFiltering;
  final bool? enableSafeBrowsing;
  final bool? enableParentalControl;
  final bool? enableSafeSearch;
  final SafeSearch? safeSearch;
  final SafeSearch defaultSafeSearch;
  final bool useGlobalSettingsServices;
  final List<String> blockedServices;
  final void Function(List<String>) updateBlockedServices;
  final List<ControllerListItem> upstreamServers;
  final void Function(List<ControllerListItem>) updateUpstreamServers;
  final void Function(List<String>) updateSelectedTags;
  final void Function(List<ControllerListItem>) updateIdentifiersControllers;
  final void Function() enableDisableGlobalSettingsFiltering;
  final void Function(bool) updateEnableFiltering;
  final void Function(bool) updateEnableSafeBrowsing;
  final void Function(bool) updateEnableParentalControl;
  final void Function(bool) updateEnableSafeSearch;
  final void Function(SafeSearch) updateSafeSearch;
  final void Function(bool) updateUseGlobalSettingsServices;

  const ClientForm({
    Key? key,
    required this.isFullScreen,
    required this.client,
    required this.nameController,
    required this.updateValidValues,
    required this.identifiersControllers,
    required this.selectedTags,
    required this.useGlobalSettingsFiltering,
    required this.enableFiltering,
    required this.enableParentalControl,
    required this.enableSafeBrowsing,
    required this.enableSafeSearch,
    required this.safeSearch,
    required this.blockedServices,
    required this.updateBlockedServices,
    required this.upstreamServers,
    required this.updateUpstreamServers,
    required this.defaultSafeSearch,
    required this.useGlobalSettingsServices,
    required this.updateSelectedTags,
    required this.updateIdentifiersControllers,
    required this.enableDisableGlobalSettingsFiltering,
    required this.updateEnableFiltering,
    required this.updateEnableParentalControl,
    required this.updateEnableSafeBrowsing,
    required this.updateEnableSafeSearch,
    required this.updateSafeSearch,
    required this.updateUseGlobalSettingsServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    return ListView(
      padding: const EdgeInsets.only(top: 0),
      children: [
        if (isFullScreen == true) const SizedBox(height: 24),
        if (isFullScreen == false) const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            enabled: client != null ? false : true,
            controller: nameController,
            onChanged: (_) => updateValidValues(
              checkValidValues(
                identifiersControllers: identifiersControllers,
                nameController: nameController
              )
            ),
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
          onTagsSelected: updateSelectedTags
        ),
        IdentifiersSection(
          identifiersControllers: identifiersControllers,
          onUpdateIdentifiersControllers: (c) {
            updateIdentifiersControllers(c);
            updateValidValues(
              checkValidValues(
                nameController: nameController, 
                identifiersControllers: identifiersControllers
              )
            );
          },
          onCheckValidValues: () => updateValidValues(
            checkValidValues(
              identifiersControllers: identifiersControllers,
              nameController: nameController
            )
          ),
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
              onTap: enableDisableGlobalSettingsFiltering,
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
          onChange: (value) => updateEnableFiltering(value),
          useGlobalSettingsFiltering: useGlobalSettingsFiltering,
        ),
        SettingsTile(
          label: AppLocalizations.of(context)!.enableSafeBrowsing,
          value: enableSafeBrowsing, 
          onChange: (value) => updateEnableSafeBrowsing(value),
          useGlobalSettingsFiltering: useGlobalSettingsFiltering,
        ),
        SettingsTile(
          label: AppLocalizations.of(context)!.enableParentalControl,
          value: enableParentalControl, 
          onChange: (value) => updateEnableParentalControl(value),
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
                onUpdateSafeSearch: updateSafeSearch
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
          onChange: (value) => updateEnableSafeSearch(value),
          useGlobalSettingsFiltering: useGlobalSettingsFiltering,
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.blockedServices,
          padding: const EdgeInsets.all(24),
        ),
        BlockedServicesSection(
          useGlobalSettingsServices: useGlobalSettingsServices, 
          blockedServices: blockedServices, 
          onUpdatedBlockedServices: updateBlockedServices,
          onUpdateServicesGlobalSettings: updateUseGlobalSettingsServices,
        ),
        UpstreamServersSection(
          upstreamServers: upstreamServers, 
          onCheckValidValues: () => updateValidValues(
            checkValidValues(
              identifiersControllers: identifiersControllers,
              nameController: nameController
            )
          ),
          onUpdateUpstreamServers: updateUpstreamServers
        ),
        SizedBox(height: Platform.isIOS ? 48 : 24)
      ],
    );
  }
}