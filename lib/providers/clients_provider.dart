import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/functions/maps_fns.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/constants/enums.dart';

enum AccessSettingsList { allowed, disallowed, domains }

class ClientsProvider with ChangeNotifier {
  ServersProvider? _serversProvider;
  StatusProvider? _statusProvider;

  update(ServersProvider? servers, StatusProvider? status) {
    _serversProvider = servers;
    _statusProvider = status;
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

  void setClientsData(Clients data, bool notify) {
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
    if (notify == true) notifyListeners();
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

  Future<bool> fetchClients({
    bool? updateLoading
  }) async {
    if (updateLoading == true) {
      _loadStatus = LoadStatus.loading;
    }
    final result = await _serversProvider!.apiClient!.getClients();
    if (result['result'] == 'success') {
      setClientsData(result['data'], false);
      _loadStatus = LoadStatus.loaded;
      notifyListeners();
      return true;
    }
    else {
      if (updateLoading == true) {
        _loadStatus = LoadStatus.error;
        notifyListeners();
      }
      return false;
    }
  }

  Future<bool> deleteClient(Client client) async {
    final result = await _serversProvider!.apiClient!.postDeleteClient(name: client.name);

    if (result['result'] == 'success') {
      Clients clientsData = clients!;
      clientsData.clients = clientsData.clients.where((c) => c.name != client.name).toList();
      setClientsData(clientsData, false);

      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> editClient(Client client) async {      
    final result = await _serversProvider!.apiClient!.postUpdateClient(
      data: {
        'name': client.name,
        'data':  serverVersionIsAhead(
          currentVersion: _statusProvider!.serverStatus!.serverVersion, 
          referenceVersion: 'v0.107.28',
          referenceVersionBeta: 'v0.108.0-b.33'
        ) == false
          ? removePropFromMap(client.toJson(), 'safesearch_enabled')
          : removePropFromMap(client.toJson(), 'safe_search')
      }
    );

    if (result['result'] == 'success') {
      Clients clientsData = clients!;
      clientsData.clients = clientsData.clients.map((e) {
        if (e.name == client.name) {
          return client;
        }
        else {
          return e;
        }
      }).toList();
      setClientsData(clientsData, false);

      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> addClient(Client client) async {
    final result = await _serversProvider!.apiClient!.postAddClient(
      data: serverVersionIsAhead(
        currentVersion: _statusProvider!.serverStatus!.serverVersion, 
        referenceVersion: 'v0.107.28',
        referenceVersionBeta: 'v0.108.0-b.33'
      ) == false
        ? removePropFromMap(client.toJson(), 'safesearch_enabled')
        : removePropFromMap(client.toJson(), 'safe_search')
    );

    if (result['result'] == 'success') {
      Clients clientsData = clients!;
      clientsData.clients.add(client);
      setClientsData(clientsData, false);

      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<Map<String, dynamic>> addClientList(String item, AccessSettingsList type) async {
    Map<String, List<String>> body = {
      "allowed_clients": clients!.clientsAllowedBlocked?.allowedClients ?? [],
      "disallowed_clients": clients!.clientsAllowedBlocked?.disallowedClients ?? [],
      "blocked_hosts": clients!.clientsAllowedBlocked?.blockedHosts ?? [],
    };

    if (type == AccessSettingsList.allowed) {
      body['allowed_clients']!.add(item);
    }
    else if (type == AccessSettingsList.disallowed) {
      body['disallowed_clients']!.add(item);
    }
    else if (type == AccessSettingsList.domains) {
      body['blocked_hosts']!.add(item);
    }

    final result = await _serversProvider!.apiClient!.requestAllowedBlockedClientsHosts(body);

    if (result['result'] == 'success') {
      _clients?.clientsAllowedBlocked = ClientsAllowedBlocked(
        allowedClients: body['allowed_clients'] ?? [], 
        disallowedClients: body['disallowed_clients'] ?? [], 
        blockedHosts: body['blocked_hosts'] ?? [], 
      );
      notifyListeners();
      return { 'success': true };
    }
    else if (result['result'] == 'error' && result['message'] == 'client_another_list') {
      notifyListeners();
      return {
        'success': false,
        'error': 'client_another_list'
      };
    }
    else {
      notifyListeners();
      return {
        'success': false,
        'error': null
      };
    }
  }

  Future<Map<String, dynamic>> removeClientList(String client, AccessSettingsList type) async {
    Map<String, List<String>> body = {
      "allowed_clients": clients!.clientsAllowedBlocked?.allowedClients ?? [],
      "disallowed_clients": clients!.clientsAllowedBlocked?.disallowedClients ?? [],
      "blocked_hosts": clients!.clientsAllowedBlocked?.blockedHosts ?? [],
    };

    if (type == AccessSettingsList.allowed) {
      body['allowed_clients'] = body['allowed_clients']!.where((c) => c != client).toList();
    }
    else if (type == AccessSettingsList.disallowed) {
      body['disallowed_clients'] = body['disallowed_clients']!.where((c) => c != client).toList();
    }
    else if (type == AccessSettingsList.domains) {
      body['blocked_hosts'] = body['blocked_hosts']!.where((c) => c != client).toList();
    }

    final result = await _serversProvider!.apiClient!.requestAllowedBlockedClientsHosts(body);

    if (result['result'] == 'success') {
      _clients?.clientsAllowedBlocked = ClientsAllowedBlocked(
        allowedClients: body['allowed_clients'] ?? [], 
        disallowedClients: body['disallowed_clients'] ?? [], 
        blockedHosts: body['blocked_hosts'] ?? [], 
      );
      notifyListeners();
      return { 'success': true };
    }
    else if (result['result'] == 'error' && result['message'] == 'client_another_list') {
      notifyListeners();
      return {
        'success': false,
        'error': 'client_another_list'
      };
    }
    else {
      notifyListeners();
      return {
        'success': false,
        'error': null
      };
    }
  }
}