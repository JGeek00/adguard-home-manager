import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/clients/client/blocked_services_section.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';
import 'package:adguard_home_manager/screens/clients/client/identifiers_section.dart';
import 'package:adguard_home_manager/screens/clients/client/settings_tile.dart';
import 'package:adguard_home_manager/screens/clients/client/tags_section.dart';
import 'package:adguard_home_manager/screens/clients/client/upstream_servers_section.dart';
import 'package:adguard_home_manager/screens/clients/client/blocking_schedule.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/safe_search.dart';

class ClientForm extends StatelessWidget {
  final bool isFullScreen;
  final Client? client;
  final TextEditingController nameController;
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
  final bool ignoreClientQueryLog;
  final void Function(bool) updateIgnoreClientQueryLog;
  final bool ignoreClientStatistics;
  final void Function(bool) updateIgnoreClientStatistics;
  final bool enableDnsCache;
  final void Function(bool) updateEnableDnsCache;
  final TextEditingController dnsCacheField;
  final String? dnsCacheError;
  final void Function(String?) updateDnsCacheError;
  final BlockedServicesSchedule blockedServicesSchedule;
  final void Function(BlockedServicesSchedule) setBlockedServicesSchedule;

  const ClientForm({
    super.key,
    required this.isFullScreen,
    required this.client,
    required this.nameController,
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
    required this.ignoreClientQueryLog,
    required this.ignoreClientStatistics,
    required this.updateIgnoreClientQueryLog,
    required this.updateIgnoreClientStatistics,
    required this.enableDnsCache,
    required this.updateEnableDnsCache,
    required this.dnsCacheField,
    required this.dnsCacheError,
    required this.updateDnsCacheError,
    required this.blockedServicesSchedule,
    required this.setBlockedServicesSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            enabled: client != null ? false : true,
            controller: nameController,
            onChanged: (_) => {},
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        TagsSection(
          selectedTags: selectedTags, 
          onTagsSelected: updateSelectedTags
        ),
        IdentifiersSection(
          identifiersControllers: identifiersControllers,
          onUpdateIdentifiersControllers: (c) {
            updateIdentifiersControllers(c);
          },
          onCheckValidValues: () => {}
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.settings,
          padding: const  EdgeInsets.only(
            left: 16, right: 16, top: 12, bottom: 24
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              onTap: enableDisableGlobalSettingsFiltering,
              borderRadius: BorderRadius.circular(28),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.useGlobalSettings,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
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
        const SizedBox(height: 8),
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
        CustomListTile(
          title: AppLocalizations.of(context)!.safeSearch,
          padding: const  EdgeInsets.symmetric(
            horizontal: 34,
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
        SectionLabel(
          label: AppLocalizations.of(context)!.queryLogsAndStatistics,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        CustomSwitchListTile(
          title: AppLocalizations.of(context)!.ignoreClientQueryLog,
          value: ignoreClientQueryLog,
          onChanged: updateIgnoreClientQueryLog,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6
          ),
        ),
        CustomSwitchListTile(
          title: AppLocalizations.of(context)!.ignoreClientStatistics,
          value: ignoreClientStatistics,
          onChanged: updateIgnoreClientStatistics,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6
          ),
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.blockedServices,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        BlockedServicesSection(
          useGlobalSettingsServices: useGlobalSettingsServices, 
          blockedServices: blockedServices, 
          onUpdatedBlockedServices: updateBlockedServices,
          onUpdateServicesGlobalSettings: updateUseGlobalSettingsServices,
        ),
        UpstreamServersSection(
          upstreamServers: upstreamServers, 
          onCheckValidValues: () => {},
          onUpdateUpstreamServers: updateUpstreamServers
        ),
        SectionLabel(
          label: AppLocalizations.of(context)!.upstreamDnsCacheConfiguration,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        CustomSwitchListTile(
          title: AppLocalizations.of(context)!.enableDnsCachingClient,
          value: enableDnsCache,
          onChanged: updateEnableDnsCache,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextFormField(
            controller: dnsCacheField,
            onChanged: (v) => updateDnsCacheError(!validateNumber(v) ? AppLocalizations.of(context)!.invalidValue : null),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.storage_rounded),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                )
              ),
              labelText: AppLocalizations.of(context)!.dnsCacheSize,
              errorText: dnsCacheError
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        BlockingSchedule(
          blockedServicesSchedule: blockedServicesSchedule,
          setBlockedServicesSchedule: setBlockedServicesSchedule,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}