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
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Home());
              }
              else {
                return const MaterialPage(child: Home());
              }
            },
          ),
        ]
      ),
      StatefulShellBranch(
        navigatorKey: clientsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: clientsNavigatorKey,
            path: RoutesNames.clients,
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Clients());
              }
              else {
                return const MaterialPage(child: Clients());
              }
            },
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: logsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: logsNavigatorKey,
            path: RoutesNames.logs,
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Logs());
              }
              else {
                return const MaterialPage(child: Logs());
              }
            },
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: filtersNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: filtersNavigatorKey,
            path: RoutesNames.filters, 
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Filters());
              }
              else {
                return const MaterialPage(child: Filters());
              }
            },
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: settingsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: settingsNavigatorKey,
            path: RoutesNames.settings,
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Settings());
              }
              else {
                return const MaterialPage(child: Settings());
              }
            },
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: connectNavigatorKey,
        routes: [
          GoRoute(
            path: RoutesNames.connect, 
            pageBuilder: (context, state) {
              if (isDesktop(MediaQuery.of(context).size.width)) {
                return const NoTransitionPage(child: Connect());
              }
              else {
                return const MaterialPage(child: Connect());
              }
            },
          )
        ]
      ),
    ]
  )
];