import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/conversions.dart';

class ServersProvider with ChangeNotifier {
  Database? _dbInstance;

  List<Server> _serversList = [];
  Server? _selectedServer;
  final ServerStatus _serverStatus = ServerStatus(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  ); // serverStatus != null means server is connected
  List<String> _protectionsManagementProcess = []; // protections that are currenty being enabled or disabled

  final Clients _clients = Clients(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  final Filtering _filtering = Filtering(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  final DhcpModel _dhcp = DhcpModel(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  final RewriteRules _rewriteRules = RewriteRules(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  final DnsInfo _dnsInfo = DnsInfo(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  FilteringStatus? _filteringStatus;

  List<Server> get serversList {
    return _serversList;
  }

  Server? get selectedServer {
    return _selectedServer;
  }

  ServerStatus get serverStatus {
    return _serverStatus;
  }

  List<String> get protectionsManagementProcess {
    return _protectionsManagementProcess;
  }

  Clients get clients {
    return _clients;
  }

  FilteringStatus? get filteringStatus {
    return _filteringStatus;
  }

  Filtering get filtering {
    return _filtering;
  }

  DhcpModel get dhcp {
    return _dhcp;
  }

  RewriteRules get rewriteRules {
    return _rewriteRules;
  }

  DnsInfo get dnsInfo {
    return _dnsInfo;
  }

  void setDbInstance(Database db) {
    _dbInstance = db;
  }

  void addServer(Server server) {
    _serversList.add(server);
    notifyListeners();
  }

  void setSelectedServer(Server server) {
    _selectedServer = server;
    notifyListeners();
  }

  void setServerStatusData(ServerStatusData data) {
    _serverStatus.data = data;
    notifyListeners();
  }

  void setServerStatusLoad(int status) {
    _serverStatus.loadStatus = status;
    notifyListeners();
  }

  void setClientsLoadStatus(int status, bool notify) {
    _clients.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setClientsData(ClientsData data) {
    _clients.data = data;
    notifyListeners();
  }

  void setAllowedDisallowedClientsBlockedDomains(ClientsAllowedBlocked data) {
    _clients.data?.clientsAllowedBlocked = data;
    notifyListeners();
  }

  void setFilteringStatus(FilteringStatus status) {
    _filteringStatus = status;
    notifyListeners();
  }

  void setFilteringData(FilteringData data) {
    _filtering.data = data;
    notifyListeners();
  }

  void setFilteringLoadStatus(int loadStatus, bool notify) {
    _filtering.loadStatus = loadStatus;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setFilteringProtectionStatus(bool status) {
    _serverStatus.data!.filteringEnabled = status;
    _filtering.data!.enabled = status;
    notifyListeners();
  }

  void setFiltersUpdateFrequency(int frequency) {
    _filtering.data!.interval = frequency;
    notifyListeners();
  }

  void setBlockedServices(List<String> blockedServices) {
    _filtering.data!.blockedServices = blockedServices;
    notifyListeners();
  }

  void setDhcpData(DhcpData data) {
    _dhcp.data = data;
    notifyListeners();
  }

  void setDhcpLoadStatus(int status, bool notify) {
    _dhcp.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
  
  void setRewriteRulesData(List<RewriteRulesData> data) {
    _rewriteRules.data = data;
    notifyListeners();
  }

  void setRewriteRulesLoadStatus(int status, bool notify) {
    _rewriteRules.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
  
  void setDnsInfoData(DnsInfoData data) {
    _dnsInfo.data = data;
    notifyListeners();
  }

  void setDnsInfoLoadStatus(int status, bool notify) {
    _dnsInfo.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
 
  Future<dynamic> createServer(Server server) async {
    final saved = await saveServerIntoDb(server);
    if (saved == null) {
      if (server.defaultServer == true) {
        final defaultServer = await setDefaultServer(server);
        if (defaultServer == null) {
          _serversList.add(server);
          notifyListeners();
          return null;
        }
        else {
          return defaultServer;
        }
      }
      else {
        _serversList.add(server);
        notifyListeners();
        return null;
      }
    }
    else {
      return saved;
    }
  }

  Future<dynamic> setDefaultServer(Server server) async {
    final updated = await setDefaultServerDb(server.id);
    if (updated == null) {
      List<Server> newServers = _serversList.map((s) {
        if (s.id == server.id) {
          s.defaultServer = true;
          return s;
        }
        else {
          s.defaultServer = false;
          return s;
        }
      }).toList();
      _serversList = newServers;
      notifyListeners();
      return null;
    }
    else {
      return updated;
    }
  }

  Future<dynamic> editServer(Server server) async {
    final result = await editServerDb(server);
    if (result == null) {
      List<Server> newServers = _serversList.map((s) {
        if (s.id == server.id) {
          return server;
        }
        else {
          return s;
        }
      }).toList();
      _serversList = newServers;
      notifyListeners();
      return null;
    }
    else {
      return result;
    }
  }

  Future<bool> removeServer(Server server) async {
    final result = await removeFromDb(server.id);
    if (result == true) {
      _selectedServer = null;
      List<Server> newServers = _serversList.where((s) => s.id != server.id).toList();
      _serversList = newServers;
      notifyListeners();
      return true;
    }
    else {
      return false;
    }
  }

  Future<dynamic> updateBlocking(Server server, String block, bool newStatus) async {
    switch (block) {
      case 'general':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await updateGeneralProtection(server, newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'general').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.generalEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'filtering':
        _protectionsManagementProcess.add('filtering');
        notifyListeners();

        final result = await updateFiltering(server, newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'filtering').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.filteringEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          
          notifyListeners();
          return result['log'];
        }

      case 'safeSearch':
        _protectionsManagementProcess.add('safeSearch');
        notifyListeners();

        final result = await updateSafeSearch(server, newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'safeSearch').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.safeSearchEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'safeBrowsing':
        _protectionsManagementProcess.add('safeBrowsing');
        notifyListeners();

        final result = await updateSafeBrowsing(server, newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'safeBrowsing').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.safeBrowsingEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'parentalControl':
        _protectionsManagementProcess.add('parentalControl');
        notifyListeners();

        final result = await updateParentalControl(server, newStatus);

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'parentalControl').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.parentalControlEnabled = newStatus;
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      default:
        return false;
    }
  }

  Future<dynamic> saveServerIntoDb(Server server) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO servers (id, name, connectionMethod, domain, path, port, user, password, defaultServer, authToken, runningOnHa) VALUES ("${server.id}", "${server.name}", "${server.connectionMethod}", "${server.domain}", ${server.path != null ? "${server.path}" : null}, ${server.port}, "${server.user}", "${server.password}", 0, "${server.authToken}", ${convertFromBoolToInt(server.runningOnHa)})',
        );
        return null;
      });
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> editServerDb(Server server) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE servers SET name = "${server.name}", connectionMethod = "${server.connectionMethod}", domain = "${server.domain}", path = ${server.path != null ? "${server.path}" : null}, port = ${server.port}, user = "${server.user}", password = "${server.password}", authToken = "${server.authToken}", runningOnHa = ${convertFromBoolToInt(server.runningOnHa)} WHERE id = "${server.id}"',
        );
        return null;
      });
    } catch (e) {
      return e;
    }
  }

  Future<bool> removeFromDb(String id) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawDelete(
          'DELETE FROM servers WHERE id = "$id"',
        );
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> setDefaultServerDb(String id) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE servers SET defaultServer = 0 WHERE defaultServer = 1',
        );
        await txn.rawUpdate(
          'UPDATE servers SET defaultServer = 1 WHERE id = "$id"',
        );
        return null;
      });
    } catch (e) {
      return e;
    }
  }

  void saveFromDb(List<Map<String, dynamic>>? data) async {
    if (data != null) {
      for (var server in data) {
        final Server serverObj = Server(
          id: server['id'],
          name: server['name'],
          connectionMethod: server['connectionMethod'],
          domain: server['domain'],
          path: server['path'],
          port: server['port'],
          user: server['user'],
          password: server['password'],
          defaultServer: convertFromIntToBool(server['defaultServer'])!,
          authToken: server['authToken'],
          runningOnHa: convertFromIntToBool(server['runningOnHa'])!,
        );
        _serversList.add(serverObj);
        if (convertFromIntToBool(server['defaultServer']) == true) {
          _selectedServer = serverObj;
          _serverStatus.loadStatus = 0;
          final serverStatus = await getServerStatus(serverObj);
          if (serverStatus['result'] == 'success') {
            _serverStatus.data = serverStatus['data'];
            _serverStatus.loadStatus = 1;
          }
          else {
            _serverStatus.loadStatus = 2;
          }
        }
      }
    }
    notifyListeners();
  }
}