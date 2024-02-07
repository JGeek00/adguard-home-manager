import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart' as reorderable_list;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';

class _ItemData {
  final HomeTopItems title;
  final Key key;

  const _ItemData({
    required this.title, 
    required this.key
  });
}

enum DraggingMode {
  iOS,
  android,
}

class ReorderableTopItemsHome extends StatefulWidget {
  final List<HomeTopItems> persistHomeTopItems;
  final void Function(List<HomeTopItems> value) setPersistHomeTopItems;

  const ReorderableTopItemsHome({
    super.key,
    required this.persistHomeTopItems,
    required this.setPersistHomeTopItems,
  });

  @override
  State<ReorderableTopItemsHome> createState() => _ReorderableTopItemsHomeState();
}

class _ReorderableTopItemsHomeState extends State<ReorderableTopItemsHome> {
  List<HomeTopItems> homeTopItemsList = [];
  List<_ItemData> renderItems = [];

  int _indexOfKey(Key key) {
    return renderItems.indexWhere((_ItemData d) => d.key == key);
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
    widget.setPersistHomeTopItems(homeTopItemsList);
  }

  List<HomeTopItems> reorderEnumItems(int oldIndex, int newIndex) {
    final List<HomeTopItems> list = [...homeTopItemsList];
    final HomeTopItems item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    return list;
  }

  @override
  void initState() {
    homeTopItemsList = widget.persistHomeTopItems;
    renderItems = widget.persistHomeTopItems.asMap().entries.map(
      (e) => _ItemData(
        key: ValueKey(e.key),
        title: e.value, 
      )
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    final draggingMode = Platform.isAndroid
      ? DraggingMode.android
      : DraggingMode.iOS;

    return SafeArea(
      top: false,
      bottom: true,
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),      
            SliverList.list(
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
                if (homeTopItemsList.isEmpty) Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.noElementsReorderMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (homeTopItemsList.isNotEmpty) reorderable_list.ReorderableList(
                  onReorder: _reorderCallback,
                  onReorderDone: _reorderDone,
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 0),
                    itemBuilder: (context, index) => reorderable_list.ReorderableItem(
                      key: renderItems[index].key,
                      childBuilder: (context, state) {
                        if (draggingMode == DraggingMode.android) {
                          return reorderable_list.DelayedReorderableListener(
                            child: _ReorderableTile(
                              draggingMode: draggingMode,
                              isFirst: index == 0,
                              isLast: index == renderItems.length - 1,
                              state: state,
                              tileWidget: _TopItemTile(tile: renderItems[index].title), 
                            ),
                          );
                        }
                        else {
                          return _ReorderableTile(
                            draggingMode: draggingMode,
                            isFirst: index == 0,
                            isLast: index == renderItems.length - 1,
                            state: state,
                            tileWidget: _TopItemTile(tile: renderItems[index].title), 
                          );
                        }
                      },
                    ),
                    itemCount: renderItems.length,
                  )
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}

class _TopItemTile extends StatelessWidget {
  final HomeTopItems tile;

  const _TopItemTile({
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    switch (tile) {
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

      case HomeTopItems.topUpstreams:
        return CustomListTile(
          title: AppLocalizations.of(context)!.topUpstreams,
          icon: Icons.upload_file_rounded,
           padding: const EdgeInsets.all(16)
        );

      case HomeTopItems.avgUpstreamResponseTime:
        return CustomListTile(
          title: AppLocalizations.of(context)!.averageUpstreamResponseTime,
          icon: Icons.timer_rounded,
           padding: const EdgeInsets.all(16)
        );

      default:
        return const SizedBox();
    }
  }
}

class _ReorderableTile extends StatelessWidget {
  final Widget tileWidget;
  final bool isFirst;
  final bool isLast;
  final reorderable_list.ReorderableItemState state;
  final DraggingMode draggingMode;

  const _ReorderableTile({
    required this.tileWidget,
    required this.isFirst,
    required this.isLast,
    required this.state,
    required this.draggingMode
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration getDecoration() {
      if (
        state == reorderable_list.ReorderableItemState.dragProxy ||
        state == reorderable_list.ReorderableItemState.dragProxyFinished
      ) {
        return BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.7)
        );
      } 
      else {
        bool placeholder = state == reorderable_list.ReorderableItemState.placeholder;
        return BoxDecoration(
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
    }
    
    return Container(
      decoration: getDecoration(),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          opacity: state == reorderable_list.ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: tileWidget
                ),
                if (draggingMode == DraggingMode.iOS) reorderable_list.ReorderableListener(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Icon(
                        Icons.reorder,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}