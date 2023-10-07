import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/screens/clients/client/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/client/safe_search_modal.dart';
import 'package:adguard_home_manager/screens/clients/client/services_modal.dart';
import 'package:adguard_home_manager/screens/clients/client/tags_modal.dart';

import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/models/safe_search.dart';

void openTagsModal({
  required BuildContext context,
  required List<String> selectedTags,
  required void Function(List<String>) onSelectedTags
}) {
  showDialog(
    context: context, 
    builder: (context) => TagsModal(
      selectedTags: selectedTags,
      tags: Provider.of<ClientsProvider>(context, listen: false).clients!.supportedTags,
      onConfirm: onSelectedTags,
    )
  );
}

void openServicesModal({
  required BuildContext context,
  required List<String> blockedServices,
  required void Function(List<String>) onUpdateBlockedServices
}) {
  showDialog(
    context: context, 
    builder: (context) => ServicesModal(
      blockedServices: blockedServices,
      onConfirm: onUpdateBlockedServices,
    )
  );
}

void openDeleteClientScreen({
  required BuildContext context,
  required void Function() onDelete
}) {
  showDialog(
    context: context, 
    builder: (ctx) => RemoveClientModal(
      onConfirm: () {
        Navigator.pop(context);
        onDelete();
      }
    )
  );
}

void openSafeSearchModal({
  required BuildContext context,
  required List<String> blockedServices,
  required void Function(SafeSearch) onUpdateSafeSearch,
  required SafeSearch? safeSearch,
  required SafeSearch defaultSafeSearch
}) {
  showDialog(
    context: context, 
    builder: (context) => SafeSearchModal(
      safeSearch: safeSearch ?? defaultSafeSearch, 
      disabled: false,
      onConfirm: onUpdateSafeSearch
    )
  );
}

bool checkValidValues({
  required TextEditingController nameController,
  required List<Map<dynamic, dynamic>> identifiersControllers
}) {
  if (
    nameController.text != '' &&
    identifiersControllers.isNotEmpty && 
    identifiersControllers[0]['controller']!.text != ''
  ) {
    return true;
  }
  else {
    return false;
  }
}
