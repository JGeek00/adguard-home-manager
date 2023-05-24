import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class ClientsProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? serversProvider) {
    if (serversProvider != null) {
      _serversProvider = serversProvider;
    }
  }

  LoadStatus _loadStatus = LoadStatus.loading;
  Clients? _clients;
  String? _searchTermClients;
  List<AutoClient> _filteredActiveClients = [];
  List<Client> _filteredAddedClients = [];

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  Clients? get clients {
    return _clients;
  }

  String? get searchTermClients {
    return _searchTermClients;
  }

  List<AutoClient> get filteredActiveClients {
    return _filteredActiveClients;
  }

  List<Client> get filteredAddedClients {
    return _filteredAddedClients;
  }

  void setClientsLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setClientsData(Clients data) {
    _clients = data;
    if (_searchTermClients != null && _searchTermClients != '') {
      _filteredActiveClients = _clients!.autoClients.where(
        (client) => client.ip.contains(_searchTermClients!.toLowerCase()) || (client.name != null ? client.name!.contains(_searchTermClients!.toLowerCase()) : false)
      ).toList();
      _filteredAddedClients = _clients!.clients.where(
        (client) {
          isContained(String value) => value.contains(value.toLowerCase());
          return client.ids.any(isContained);
        }
      ).toList();
    }
    else {
      _filteredActiveClients = data.autoClients;
      _filteredAddedClients = data.clients;
    }
    notifyListeners();
  }

  void setSearchTermClients(String? value) {
    _searchTermClients = value;
    if (value != null && value != '') {
      if (_clients != null) {
        _filteredActiveClients = _clients!.autoClients.where(
          (client) => client.ip.contains(value.toLowerCase()) || (client.name != null ? client.name!.contains(value.toLowerCase()) : false)
        ).toList();
        _filteredAddedClients = _clients!.clients.where(
          (client) {
            isContained(String value) => value.contains(value.toLowerCase());
            return client.ids.any(isContained);
          }
        ).toList();
      }
    }
    else {
      if (_clients != null) _filteredActiveClients = _clients!.autoClients;
      if (_clients != null) _filteredAddedClients = _clients!.clients;
    }
    notifyListeners();
  }

  void setAllowedDisallowedClientsBlockedDomains(ClientsAllowedBlocked data) {
    _clients?.clientsAllowedBlocked = data;
    notifyListeners();
  }
}