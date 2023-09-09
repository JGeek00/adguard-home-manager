import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart' as reorderable_list_library;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ItemData {
  final HomeTopItems title;
  final Key key;

  const ItemData({
    required this.title, 
    required this.key
  });
}

enum DraggingMode {
  iOS,
  android,
}

class ReorderableTopItemsHome extends StatefulWidget {
  const ReorderableTopItemsHome({Key? key}) : super(key: key);

  @override
  State<ReorderableTopItemsHome> createState() => _ReorderableTopItemsHomeState();
}

class _ReorderableTopItemsHomeState extends State<ReorderableTopItemsHome> {
  List<HomeTopItems> homeTopItemsList = [];
  List<HomeTopItems> persistHomeTopItemsList = [];
  List<ItemData> renderItems = [];

  int _indexOfKey(Key key) {
    return renderItems.indexWhere((ItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = renderItems[draggingIndex];

    final List<HomeTopItems> reorderedItems = reorderEnumItems(draggingIndex, newPositionIndex);

    setState(() {
      renderItems.removeAt(draggingIndex);
      renderItems.insert(newPositionIndex, draggedItem);
      homeTopItemsList = reorderedItems;
    });

    return true;
  }

  void _reorderDone(Key item) {
    renderItems[_indexOfKey(item)];
    setState(() => persistHomeTopItemsList = homeTopItemsList);
  }

  List<HomeTopItems> reorderEnumItems(int oldIndex, int newIndex) {
    final List<HomeTopItems> list = [...homeTopItemsList];
    final HomeTopItems item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    return list;
  }

  @override
  void initState() {
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    homeTopItemsList = appConfigProvider.homeTopItemsOrder;
    persistHomeTopItemsList = appConfigProvider.homeTopItemsOrder;
    renderItems = appConfigProvider.homeTopItemsOrder.asMap().entries.map(
      (e) => ItemData(
        key: ValueKey(e.key),
        title: e.value, 
      )
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    Widget tile(HomeTopItems title) {
      switch (title) {
        case HomeTopItems.queriedDomains:
          return CustomListTile(
            title: AppLocalizations.of(context)!.topQueriedDomains,
            icon: Icons.install_desktop_outlined,
            padding: const EdgeInsets.all(16)
          );

        case HomeTopItems.blockedDomains:
          return CustomListTile(
            title: AppLocalizations.of(context)!.topBlockedDomains,
            icon: Icons.block_rounded,
             padding: const EdgeInsets.all(16)
          );

        case HomeTopItems.recurrentClients:
          return CustomListTile(
            title: AppLocalizations.of(context)!.topClients,
            icon: Icons.smartphone_rounded,
             padding: const EdgeInsets.all(16)
          );

        default:
          return const SizedBox();
      }
    }

    Future<bool> onWillPopScope() async {
      if (!listEquals(appConfigProvider.homeTopItemsOrder, persistHomeTopItemsList)) {
        showDialog(
          context: context, 
          builder: (dialogContext) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.discardChanges),
            content: Text(AppLocalizations.of(context)!.discardChangesDescription),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.pop(context);
                    }, 
                    child: Text(AppLocalizations.of(context)!.confirm)
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext), 
                    child: Text(AppLocalizations.of(context)!.cancel)
                  ),
                ],
              )
            ],
          )
        );
        return false;
      }
      else {
        return true;
      }
    }

    return WillPopScope(
      onWillPop: onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.topItemsOrder),
          actions: [
            IconButton(
              onPressed: !listEquals(appConfigProvider.homeTopItemsOrder, persistHomeTopItemsList)
                ? () => appConfigProvider.setHomeTopItemsOrder(homeTopItemsList)
                : null, 
              icon: const Icon(Icons.save_rounded),
              tooltip: AppLocalizations.of(context)!.save,
            ),
            const SizedBox(width: 8)
          ],
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(AppLocalizations.of(context)!.topItemsReorderInfo)
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: reorderable_list_library.ReorderableList(
                onReorder: _reorderCallback,
                onReorderDone: _reorderDone,
                child: ListView.builder(
                  itemBuilder: (context, index) => reorderable_list_library.ReorderableItem(
                    key: renderItems[index].key,
                    childBuilder: (context, state) => Item(
                      tileWidget: tile(renderItems[index].title), 
                      isFirst: index == 0,
                      isLast: index == renderItems.length - 1,
                      state: state
                    ),
                  ),
                  itemCount: renderItems.length,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final Widget tileWidget;
  final bool isFirst;
  final bool isLast;
  final reorderable_list_library.ReorderableItemState state;

  const Item({
    Key? key,
    required this.tileWidget,
    required this.isFirst,
    required this.isLast,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    if (
      state == reorderable_list_library.ReorderableItemState.dragProxy ||
      state == reorderable_list_library.ReorderableItemState.dragProxyFinished
    ) {
      decoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.7)
      );
    } 
    else {
      bool placeholder = state == reorderable_list_library.ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        border: Border(
          top: isFirst && !placeholder ? BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
          ) : BorderSide.none,
          bottom: isLast && placeholder ? BorderSide.none : BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
          ),
        ),
      );
    }

    return reorderable_list_library.DelayedReorderableListener(
      child: Container(
        decoration: decoration,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            opacity: state == reorderable_list_library.ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: tileWidget
                  ),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}