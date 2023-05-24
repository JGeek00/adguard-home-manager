import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/models/dns_info.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/models/update_available.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/services/db/queries.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class ServersProvider with ChangeNotifier {
  Database? _dbInstance;

  List<Server> _serversList = [];
  Server? _selectedServer;

  final DnsInfo _dnsInfo = DnsInfo(
    loadStatus: 0, // 0 = loading, 1 = loaded, 2 = error
    data: null
  );

  final UpdateAvailable _updateAvailable = UpdateAvailable(
    loadStatus: LoadStatus.loading,
    data: null,
  );

  List<Server> get serversList {
    return _serversList;
  }

  Server? get selectedServer {
    return _selectedServer;
  }

  DnsInfo get dnsInfo {
    return _dnsInfo;
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

  Future<Map<String, dynamic>> initializateServer(Server server) async {
    _selectedServer = server;
    final serverStatus = await getServerStatus(server);
    if (serverStatus['result'] == 'success') {
      checkServerUpdatesAvailable(server); // Do not await
      return {
        "success": true,
        "serverData": serverStatus['data']
      };
    }
    else {
      return {
        "success": false
      };
    } 
  }

  Future<Map<String, dynamic>?> saveFromDb(List<Map<String, dynamic>>? data) async {
    if (data != null) {
      Server? defaultServer;
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
          defaultServer = serverObj;
        }
      }

      notifyListeners();

      if (defaultServer != null) {
        final result =  await initializateServer(defaultServer);
        return result;
      }
      else {
        return null;
      }
    }
    else {
      notifyListeners();
      return null;
    }
  }
}