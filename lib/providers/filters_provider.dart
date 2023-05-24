import 'package:flutter/material.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class FiltersProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? serversProvider) {
    if (serversProvider != null) {
      _serversProvider = serversProvider;
    }
  }
}