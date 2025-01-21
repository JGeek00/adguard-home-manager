// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/add_button.dart';
import 'package:adguard_home_manager/screens/filters/modals/custom_rules/sort_rules.dart';
import 'package:adguard_home_manager/widgets/tab_content_list.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';

class CustomRulesList extends StatefulWidget {
  final LoadStatus loadStatus;
  final ScrollController scrollController;
  final List<String> data;
  final void Function(String) onRemoveCustomRule;

  const CustomRulesList({
    super.key,
    required this.loadStatus,
    required this.scrollController,
    required this.data,
    required this.onRemoveCustomRule
  });

  @override
  State<CustomRulesList> createState() => _CustomRulesListState();
}

class _CustomRulesListState extends State<CustomRulesList> {
  late bool isVisible;

  CustomRulesSorting _sortingMethod = CustomRulesSorting.topBottom;

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
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final renderData = _sortingMethod == CustomRulesSorting.bottomTop ? widget.data.reversed.toList() : widget.data.toList();

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

    void showSortingMethodModal() {
      showDialog(
        context: context, 
        builder: (ctx) => SortCustomRulesModal(
          sortingMethod: _sortingMethod, 
          onSelect: (value) => setState(() => _sortingMethod = value),
        ),
      );
    }

    return CustomTabContentList(
      loadingGenerator: () => SizedBox(
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
      ), 
      itemsCount: renderData.length, 
      contentWidget: (index) => ListTile(
        title: Text(
          renderData[index],
          style: TextStyle(
            color: checkIfComment(widget.data[index]) == true
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
              : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.normal,
          ),
        ),
        subtitle: generateSubtitle(renderData[index]),
        trailing: IconButton(
          onPressed: () => widget.onRemoveCustomRule(renderData[index]),
          icon: const Icon(Icons.delete)
        ),
      ), 
      noData: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.noCustomFilters,
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
              onPressed: () async {
                final result = await filteringProvider.fetchFilters();
                if (result == false && context.mounted) {
                  showSnackbar(
                    appConfigProvider: appConfigProvider,
                    label: AppLocalizations.of(context)!.errorLoadFilters, 
                    color: Colors.red
                  );
                }
              }, 
              icon: const Icon(Icons.refresh_rounded), 
              label: Text(AppLocalizations.of(context)!.refresh),
            )
          ],
        ),
      ), 
      errorGenerator: () => SizedBox(
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
      ), 
      loadStatus: widget.loadStatus, 
      onRefresh: () async {
        final result = await filteringProvider.fetchFilters();
        if (result == false) {
          showSnackbar(
            appConfigProvider: appConfigProvider,
            label: AppLocalizations.of(context)!.errorLoadFilters, 
            color: Colors.red
          );
        }
      }, 
      fab: Column(
        children: [
          FloatingActionButton.small(
            onPressed: showSortingMethodModal,
            child: Icon(Icons.sort_rounded),
          ),
          const SizedBox(height: 16),
          AddFiltersButton(
            type: 'edit_custom_rule', 
            widget: (fn) => FloatingActionButton.small(
              onPressed: fn,
              child: const Icon(Icons.edit_rounded),
            ),
          ),
          const SizedBox(height: 16),
          AddFiltersButton(
            type: 'add_custom_rule',
            widget: (fn) => FloatingActionButton(
              onPressed: fn,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      heightFabHidden: -180,
      fabVisible: isVisible,
    );
  }
}