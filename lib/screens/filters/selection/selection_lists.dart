import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class SelectionList extends StatelessWidget {
  final List<Filter> lists;
  final List<Filter> selectedLists;
  final void Function(Filter) onSelect;
  final void Function() selectAll;
  final void Function() unselectAll;

  const SelectionList({
    Key? key,
    required this.lists,
    required this.selectedLists,
    required this.onSelect,
    required this.selectAll,
    required this.unselectAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lists.length+1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            margin: const EdgeInsets.all(16),
            child: CheckboxListTile(
              title: Text(
                AppLocalizations.of(context)!.selectAll,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              value: lists.length == selectedLists.length,
              onChanged: (value) {
                if (value == true) {
                  selectAll();
                }
                else {
                  unselectAll();
                }
              },
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          );
        }
        return _CheckboxTile(
          list: lists[index-1],
          onSelect: onSelect,
          isSelected: selectedLists.contains(lists[index-1]),
        ); 
      }
    );
  }
}

class SelectionSliverList extends StatelessWidget {
  final List<Filter> lists;
  final List<Filter> selectedLists;
  final void Function(Filter) onSelect;
  final void Function() selectAll;
  final void Function() unselectAll;

  const SelectionSliverList({
    Key? key,
    required this.lists,
    required this.selectedLists,
    required this.onSelect,
    required this.selectAll,
    required this.unselectAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              if (lists.isNotEmpty) SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      return Card(
                        margin: const EdgeInsets.all(16),
                        child: CheckboxListTile(
                          title: Text(AppLocalizations.of(context)!.selectAll),
                          value: lists.length == selectedLists.length,
                          onChanged: (value) {
                            if (value == true) {
                              selectAll();
                            }
                            else {
                              unselectAll();
                            }
                          },
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      );
                    }
                    return _Tile(
                      list: lists[index-1],
                      onSelect: onSelect,
                      isSelected: selectedLists.contains(lists[index-1]),
                    ); 
                  },
                  childCount: lists.length+1
                ),
              ),
              if (lists.isEmpty) SliverFillRemaining(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noItems,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  )
                )
              )
            ],
          );
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Filter list;
  final void Function(Filter) onSelect;
  final bool isSelected;

  const _Tile({
    required this.list,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ListTile(
      title: Text(
        list.name,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.url,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                list.enabled == true 
                  ? Icons.check_rounded
                  : Icons.close_rounded,
                size: 16,
                color: list.enabled == true
                  ? appConfigProvider.useThemeColorForStatus == true
                    ? Theme.of(context).colorScheme.primary
                    : Colors.green
                  : appConfigProvider.useThemeColorForStatus == true
                    ? Colors.grey
                    : Colors.red
              ),
              const SizedBox(width: 4),
              Text(
                list.enabled == true 
                  ? AppLocalizations.of(context)!.enabled
                  : AppLocalizations.of(context)!.disabled,
                style: TextStyle(
                  fontSize: 12,
                  color: list.enabled == true
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red
                ),
              )
            ],
          )
        ],
      ),
      isThreeLine: true,
      tileColor: isSelected == true
        ? Theme.of(context).colorScheme.primaryContainer
        : null,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8, 
        horizontal: 16
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
      selectedColor: Theme.of(context).colorScheme.onSurface,
      onTap: () => onSelect(list),
    );
  }
}

class _CheckboxTile extends StatelessWidget {
  final Filter list;
  final void Function(Filter) onSelect;
  final bool isSelected;

  const _CheckboxTile({
    Key? key,
    required this.list,
    required this.onSelect,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ListTile(
      leading: Checkbox(
        value: isSelected,
        onChanged: (_) => onSelect(list),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
      ),
      title: Text(
        list.name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.url,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                list.enabled == true 
                  ? Icons.check_rounded
                  : Icons.close_rounded,
                size: 16,
                color: list.enabled == true
                  ? appConfigProvider.useThemeColorForStatus == true
                    ? Theme.of(context).colorScheme.primary
                    : Colors.green
                  : appConfigProvider.useThemeColorForStatus == true
                    ? Colors.grey
                    : Colors.red
              ),
              const SizedBox(width: 4),
              Text(
                list.enabled == true 
                  ? AppLocalizations.of(context)!.enabled
                  : AppLocalizations.of(context)!.disabled,
                style: TextStyle(
                  fontSize: 12,
                  color: list.enabled == true
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red
                ),
              )
            ],
          )
        ],
      ),
      isThreeLine: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8, 
        horizontal: 16
      ),
      onTap: () => onSelect(list),
    );
  }
}

