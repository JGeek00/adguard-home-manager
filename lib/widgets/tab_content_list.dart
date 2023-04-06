import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class CustomTabContentList extends StatelessWidget {
  final Widget Function() loadingGenerator;
  final int itemsCount;
  final Widget Function(int index) contentWidget;
  final Widget noData;
  final Widget Function() errorGenerator;
  final LoadStatus loadStatus;
  final Future<void> Function() onRefresh;
  final double? refreshIndicatorOffset;
  final Widget? fab;
  final bool? fabVisible;

  const CustomTabContentList({
    Key? key,
    required this.loadingGenerator,
    required this.itemsCount,
    required this.contentWidget,
    required this.noData,
    required this.errorGenerator,
    required this.loadStatus,
    required this.onRefresh,
    this.refreshIndicatorOffset,
    this.fab,
    this.fabVisible
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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
        return Stack(
          children: [
            SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return RefreshIndicator(
                    onRefresh: onRefresh,
                    edgeOffset: refreshIndicatorOffset ?? 95,
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
            ),
            if (fab != null) AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: fabVisible != null && fabVisible == true ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: fab!
            ),
          ],
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