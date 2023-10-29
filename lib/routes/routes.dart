import 'package:go_router/go_router.dart';

import 'package:adguard_home_manager/screens/home/home.dart';
import 'package:adguard_home_manager/screens/clients/clients.dart';
import 'package:adguard_home_manager/screens/connect/connect.dart';
import 'package:adguard_home_manager/screens/filters/filters.dart';
import 'package:adguard_home_manager/screens/logs/logs.dart';
import 'package:adguard_home_manager/screens/settings/settings.dart';
import 'package:adguard_home_manager/widgets/layout.dart';

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
            builder: (context, state) => const Home(),
          ),
        ]
      ),
      StatefulShellBranch(
        navigatorKey: clientsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: clientsNavigatorKey,
            path: RoutesNames.clients,
            builder: (context, state) => const Clients(),
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: logsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: logsNavigatorKey,
            path: RoutesNames.logs,
            builder: (context, state) => const Logs(),
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: filtersNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: filtersNavigatorKey,
            path: RoutesNames.filters, 
            builder: (context, state) => const Filters(),
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: settingsNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: settingsNavigatorKey,
            path: RoutesNames.settings,
            builder: (context, state) => const Settings(),
          )
        ]
      ),
      StatefulShellBranch(
        navigatorKey: connectNavigatorKey,
        routes: [
          GoRoute(
            path: RoutesNames.connect, 
            builder: (context, state) => const Connect(),
          )
        ]
      ),
    ]
  )
];