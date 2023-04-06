import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';

class CustomTabContentList extends StatelessWidget {
  final Widget Function() loadingGenerator;
  final int itemsCount;
  final Widget Function(int index) contentWidget;
  final Widget noData;
  final Widget Function() errorGenerator;
  final LoadStatus loadStatus;
  final Future<void> Function() onRefresh;

  const CustomTabContentList({
    Key? key,
    required this.loadingGenerator,
    required this.itemsCount,
    required this.contentWidget,
    required this.noData,
    required this.errorGenerator,
    required this.loadStatus,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (loadStatus) {
      case LoadStatus.loading:
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: loadingGenerator()
                  ),
                )
              ],
            ),
          )
        );
        
        
      case LoadStatus.loaded:
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return RefreshIndicator(
                onRefresh: onRefresh,
                edgeOffset: 95,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    if (itemsCount > 0) SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => contentWidget(index),
                        childCount: itemsCount
                      ),
                    ),
                    if (itemsCount == 0) SliverFillRemaining(
                      child: noData,
                    )
                  ],
                ),
              );
            },
          ),
        );

      case LoadStatus.error: 
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 95,
                      left: 16,
                      right: 16
                    ),
                    child: errorGenerator()
                  ),
                )
              ],
            ),
          )
        );
       
      default:
        return const SizedBox();
    }
  }
}