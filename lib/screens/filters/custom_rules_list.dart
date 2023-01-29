// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/fab.dart';
import 'package:adguard_home_manager/screens/filters/remove_custom_rule_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class CustomRulesList extends StatefulWidget {
  final int loadStatus;
  final ScrollController scrollController;
  final List<String> data;
  final void Function() fetchData;

  const CustomRulesList({
    Key? key,
    required this.loadStatus,
    required this.scrollController,
    required this.data,
    required this.fetchData
  }) : super(key: key);

  @override
  State<CustomRulesList> createState() => _CustomRulesListState();
}

class _CustomRulesListState extends State<CustomRulesList> {
  late bool isVisible;

  @override
  initState(){
    super.initState();
    
    isVisible = true;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void removeCustomRule(String rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.deletingRule);

      final List<String> newRules = serversProvider.filtering.data!.userRules.where((r) => r != rule).toList();

      final result = await setCustomRules(server: serversProvider.selectedServer!, rules: newRules);

      processModal.close();

      if (result['result'] == 'success') {
        FilteringData filteringData = serversProvider.filtering.data!;
        filteringData.userRules = newRules;
        serversProvider.setFilteringData(filteringData);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleRemovedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.ruleNotRemoved, 
          color: Colors.red
        );
      }
    }

    void openRemoveCustomRuleModal(String rule) {
      showDialog(
        context: context, 
        builder: (context) => RemoveCustomRule(
          onConfirm: () => removeCustomRule(rule),
        )
      );
    }

    bool checkIfComment(String value) {
      final regex = RegExp(r'^(!|#).*$');
      if (regex.hasMatch(value)) {
        return true;
      }
      else {
        return false;
      }
    }

    Widget? generateSubtitle(String rule) {
      final allowRegex = RegExp(r'^@@.*$');
      final blockRegex = RegExp(r'^\|\|.*$');
      final commentRegex = RegExp(r'^(#|!).*$');

      if (allowRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.allowed,
          style: const TextStyle(
            color: Colors.green
          ),
        );
      }
      else if (blockRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.blocked,
          style: const TextStyle(
            color: Colors.red
          ),
        );
      }
      else if (commentRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.comment,
          style: const TextStyle(
            color: Colors.grey
          ),
        );
      }
      else {
        return null;
      }
    }

    switch (widget.loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingFilters,
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            ],
          ),
        );

      case 1:
        return Stack(
          children: [
            if (widget.data.isNotEmpty) ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  widget.data[index],
                  style: TextStyle(
                    color: checkIfComment(widget.data[index]) == true
                      ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                      : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                subtitle: generateSubtitle(widget.data[index]),
                trailing: IconButton(
                  onPressed: () => openRemoveCustomRuleModal(widget.data[index]),
                  icon: const Icon(Icons.delete)
                ),
              )
            ),
            if (widget.data.isEmpty) SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-100,
                    child: Text(
                      AppLocalizations.of(context)!.noBlackLists,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: widget.fetchData, 
                    icon: const Icon(Icons.refresh_rounded), 
                    label: Text(AppLocalizations.of(context)!.refresh),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: const FiltersFab(
                type: 'custom_rule',
              )
            )
          ],
        );

      case 2:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.filtersNotLoaded,
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            ],
          ),
        );

      default:
        return const SizedBox();
    }

  }
}