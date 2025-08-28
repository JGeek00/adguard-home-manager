import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/providers/app_config_provider.dart';

Map<String, dynamic> getFilteredStatus(BuildContext context, AppConfigProvider appConfigProvider, String filterKey, bool isRow) {
  switch (filterKey) {
    case 'NotFilteredNotFound':
      return {
        'filtered': false,
        'label': isRow == true
          ? AppLocalizations.of(context)!.processedRow
          : AppLocalizations.of(context)!.processed,
        'color': appConfigProvider.useThemeColorForStatus == true
            ? Theme.of(context).colorScheme.primary
            : Colors.green,
        'icon': Icons.verified_user_rounded,
      };

    case 'NotFilteredWhiteList':
      return {
        'filtered': false,
        'label': isRow == true
          ? AppLocalizations.of(context)!.processedWhitelistRow
          : AppLocalizations.of(context)!.processedWhitelist,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Theme.of(context).colorScheme.primary
          : Colors.green,
        'icon': Icons.verified_user_rounded,
      };

    case 'NotFilteredError':
      return {
        'filtered': false,
        'label': isRow == true 
          ? AppLocalizations.of(context)!.processedErrorRow
          : AppLocalizations.of(context)!.processedError,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Theme.of(context).colorScheme.primary
          : Colors.green,
        'icon': Icons.verified_user_rounded,
      };

    case 'FilteredBlackList':
      return {
        'filtered': true,
        'label': isRow == true
          ? AppLocalizations.of(context)!.blockedBlacklistRow
          : AppLocalizations.of(context)!.blockedBlacklist,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'FilteredSafeBrowsing':
      return {
        'filtered': true,
        'label': isRow == true
          ? AppLocalizations.of(context)!.blockedSafeBrowsingRow
          : AppLocalizations.of(context)!.blockedSafeBrowsing,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'FilteredParental':
      return {
        'filtered': true,
        'label': isRow == true
          ? AppLocalizations.of(context)!.blockedParentalRow
          : AppLocalizations.of(context)!.blockedParental,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'FilteredInvalid':
      return {
        'filtered': true,
        'label': isRow == true
          ? AppLocalizations.of(context)!.blockedInvalidRow
          : AppLocalizations.of(context)!.blockedInvalid,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'FilteredSafeSearch':
      return {
        'filtered': true,
        'label': isRow == true 
          ? AppLocalizations.of(context)!.blockedSafeSearchRow
          : AppLocalizations.of(context)!.blockedSafeSearch,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'FilteredBlockedService':
      return {
        'filtered': true,
        'label': isRow == true
          ? AppLocalizations.of(context)!.blockedServiceRow
          : AppLocalizations.of(context)!.blockedService,
        'color': appConfigProvider.useThemeColorForStatus == true
          ? Colors.grey
          : Colors.red,
        'icon': Icons.gpp_bad_rounded,
      };

    case 'Rewrite':
    case 'RewriteEtcHosts':
    case 'RewriteRule':
      return {
        'filtered': true,
        'label': AppLocalizations.of(context)!.rewrite,
        'color': Colors.blue,
        'icon': Icons.shield_rounded,
      };

    default:
      return {'filtered': null, 'label': 'Unknown'};
  }
}

bool isDomainBlocked(String filterKey) {
  switch (filterKey) {
    case 'NotFilteredNotFound':
      return false;

    case 'NotFilteredWhiteList':
      return false;

    case 'NotFilteredError':
      return false;

    case 'FilteredBlackList':
      return true;

    case 'FilteredSafeBrowsing':
      return true;

    case 'FilteredParental':
      return true;

    case 'FilteredInvalid':
      return true;

    case 'FilteredSafeSearch':
      return true;

    case 'FilteredBlockedService':
      return true;

    case 'Rewrite':
    case 'RewriteEtcHosts':
    case 'RewriteRule':
      return false;

    default:
      return false;
  }
}