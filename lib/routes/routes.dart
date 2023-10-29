import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:adguard_home_manager/screens/home/home.dart';
import 'package:adguard_home_manager/screens/clients/clients.dart';
import 'package:adguard_home_manager/screens/connect/connect.dart';
import 'package:adguard_home_manager/screens/filters/filters.dart';
import 'package:adguard_home_manager/screens/logs/logs.dart';
import 'package:adguard_home_manager/screens/settings/settings.dart';
import 'package:adguard_home_manager/widgets/layout.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/routes/router_globals.dart';
import 'package:adguard_home_manager/constants/routes_names.dart';

Page<dynamic> routePage({
  required  BuildContext context, 
  required Widget child
}) {
  if (isDesktop(MediaQuery.of(context).size.width)) {
    return NoTransitionPage(child: child);
  }
  else {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}

final List<RouteBase> routes = [
  GoRoute(
    path: "/",
    redirect: (context, state) => RoutesNames.home,
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => Layout(
      navigationShell: navigationShell
    ),
    branches: [
      StatefulShellBranch(
        navigatorKey: homeNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: homeNavigatorKey,
            path: RoutesNames.home,
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Home()
            )
          ),
        ]
      ),
      StatefulShellBranch(
        navigatorKey: clientsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: clientsNavigatorKey,
            path: RoutesNames.clients,
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Clients()
            )
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: logsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: logsNavigatorKey,
            path: RoutesNames.logs,
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Logs()
            )
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: filtersNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: filtersNavigatorKey,
            path: RoutesNames.filters, 
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Filters()
            )
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: settingsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: settingsNavigatorKey,
            path: RoutesNames.settings,
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Settings()
            )
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: connectNavigatorKey,
        routes: [
          GoRoute(
            path: RoutesNames.connect, 
            pageBuilder: (context, state) => routePage(
              context: context, 
              child: const Connect()
            )
          )
        ]
      ),
    ]
  )
];