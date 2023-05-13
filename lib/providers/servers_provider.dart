import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/server_status.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/models/update_available.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/time_server_disabled.dart';
import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/services/db/queries.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/constants/enums.dart';

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
    loadStatus: LoadStatus.loading,
    data: null
  );
  String? _searchTermClients;
  List<AutoClient> _filteredActiveClients = [];
  List<Client> _filteredAddedClients = [];

  final Filtering _filtering = Filtering(
    loadStatus: LoadStatus.loading,
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

  final BlockedServices _blockedServicesList = BlockedServices(
    loadStatus: 0,
    services: null
  );

  final UpdateAvailable _updateAvailable = UpdateAvailable(
    loadStatus: LoadStatus.loading,
    data: null,
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

  String? get searchTermClients {
    return _searchTermClients;
  }

  List<AutoClient> get filteredActiveClients {
    return _filteredActiveClients;
  }

  List<Client> get filteredAddedClients {
    return _filteredAddedClients;
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

  BlockedServices get blockedServicesList {
    return _blockedServicesList;
  }

  UpdateAvailable get updateAvailable {
    return _updateAvailable;
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

  void setClientsLoadStatus(LoadStatus status, bool notify) {
    _clients.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setClientsData(ClientsData data) {
    _clients.data = data;
    if (_searchTermClients != null && _searchTermClients != '') {
      _filteredActiveClients = _clients.data!.autoClientsData.where(
        (client) => client.ip.contains(_searchTermClients!.toLowerCase()) || (client.name != null ? client.name!.contains(_searchTermClients!.toLowerCase()) : false)
      ).toList();
      _filteredAddedClients = _clients.data!.clients.where(
        (client) {
          isContained(String value) => value.contains(value.toLowerCase());
          return client.ids.any(isContained);
        }
      ).toList();
    }
    else {
      _filteredActiveClients = data.autoClientsData;
      _filteredAddedClients = data.clients;
    }
    notifyListeners();
  }

  void setSearchTermClients(String? value) {
    _searchTermClients = value;
    if (value != null && value != '') {
      if (_clients.data != null) {
        _filteredActiveClients = _clients.data!.autoClientsData.where(
          (client) => client.ip.contains(value.toLowerCase()) || (client.name != null ? client.name!.contains(value.toLowerCase()) : false)
        ).toList();
        _filteredAddedClients = _clients.data!.clients.where(
          (client) {
            isContained(String value) => value.contains(value.toLowerCase());
            return client.ids.any(isContained);
          }
        ).toList();
      }
    }
    else {
      if (_clients.data != null) _filteredActiveClients = _clients.data!.autoClientsData;
      if (_clients.data != null) _filteredAddedClients = _clients.data!.clients;
    }
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

  void setFilteringLoadStatus(LoadStatus loadStatus, bool notify) {
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

  void setBlockedServiceListData(List<BlockedService> data) {
    _blockedServicesList.services = data;
    notifyListeners();
  }

  void setBlockedServicesListLoadStatus(int status, bool notify) {
    _blockedServicesList.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setUpdateAvailableLoadStatus(LoadStatus status, bool notify) {
    _updateAvailable.loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }

  void setUpdateAvailableData(UpdateAvailableData data) {
    _updateAvailable.data = data;
    notifyListeners();
  }

  Future<dynamic> createServer(Server server) async {
    final saved = await saveServerQuery(_dbInstance!, server);
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
    final updated = await setDefaultServerQuery(_dbInstance!, server.id);
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
    final result = await editServerQuery(_dbInstance!, server);
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
    final result = await removeServerQuery(_dbInstance!, server.id);
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

  Future<dynamic> updateBlocking({
    required Server server,
    required String block, 
    required bool newStatus,
    int? time
  }) async {
    switch (block) {
      case 'general':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await updateGeneralProtection(
          server: server, 
          enable: newStatus,
          time: time
        );

        _protectionsManagementProcess = _protectionsManagementProcess.where((e) => e != 'general').toList();

        if (result['result'] == 'success') {
          _serverStatus.data!.generalEnabled = newStatus;
          if (time != null) {
            _serverStatus.data!.timeGeneralDisabled = time;
            _serverStatus.data!.disabledUntil = generateTimeDeadline(time);
          }
          else {
            _serverStatus.data!.timeGeneralDisabled = 0;
            _serverStatus.data!.disabledUntil = null;
          }
          notifyListeners();
          return null;
        }
        else {
          notifyListeners();
          return result['log'];
        }

      case 'general_legacy':
        _protectionsManagementProcess.add('general');
        notifyListeners();

        final result = await updateGeneralProtectionLegacy(server, newStatus);

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

        final result = await updateFiltering(
          server: server, 
          enable: newStatus,
        );

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

        final result = serverVersionIsAhead(
          currentVersion: serverStatus.data!.serverVersion, 
          referenceVersion: 'v0.107.28',
          referenceVersionBeta: 'v0.108.0-b.33'
        ) == true
          ? await updateSafeSearchSettings(server: server, body: { 'enabled': newStatus })
          : await updateSafeSearchLegacy(server, newStatus);

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

  void checkServerUpdatesAvailable(Server server) async {
    setUpdateAvailableLoadStatus(LoadStatus.loading, true);
    final result = await checkServerUpdates(server: server);
    if (result['result'] == 'success') {
      UpdateAvailableData data = UpdateAvailableData.fromJson(result['data']);
      final gitHubResult = await getUpdateChangelog(server: server, releaseTag: data.newVersion ?? data.currentVersion);
      if (gitHubResult['result'] == 'success') {
        data.changelog = gitHubResult['body'];
      }
      data.updateAvailable = data.newVersion != null 
        ? compareVersions(
            currentVersion: data.currentVersion,
            newVersion: data.newVersion!,
          )
        : false;
      setUpdateAvailableData(data);
      setUpdateAvailableLoadStatus(LoadStatus.loaded, true);
    }
    else {
      setUpdateAvailableLoadStatus(LoadStatus.error, true);
    }
  }

  void clearUpdateAvailable(Server server, String newCurrentVersion) {
    if (_updateAvailable.data != null) {
      _updateAvailable.data!.updateAvailable = null;
      _updateAvailable.data!.currentVersion = newCurrentVersion;
      notifyListeners();
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
            checkServerUpdatesAvailable(serverObj); // Do not await
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