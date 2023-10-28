import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/routes/router_globals.dart';
import 'package:adguard_home_manager/routes/routes.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/routes_names.dart';

final goRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  redirect: (context, state) {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    if (serversProvider.selectedServer == null) {
      return RoutesNames.connect;
    }
    return null;
  },
  initialLocation: RoutesNames.home,
  routes: routes,
);