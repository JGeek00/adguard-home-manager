import 'package:adguard_home_manager/models/dns_statistics.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/models/server.dart';

class ServersProvider with ChangeNotifier {
  Database? _dbInstance;

  List<Server> _serversList = [];
  Server? _selectedServer;
  bool? _isServerConnected;
  DnsStatistics? _dnsStatistics;

  List<Server> get serversList {
    return _serversList;
  }

  Server? get selectedServer {
    return _selectedServer;
  }

  bool? get isServerConnected {
    return _isServerConnected;
  }

  DnsStatistics? get dnsStatistics {
    return _dnsStatistics;
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

  void setIsServerConnected(bool status) {
    _isServerConnected = status;
    notifyListeners();
  }

  void setDnsStatistics(DnsStatistics data) {
    _dnsStatistics = data;
    notifyListeners();
  }
 
  Future<bool> createServer(Server server) async {
    final saved = await saveServerIntoDb(server);
    if (saved == true) {
      if (server.defaultServer == true) {
        final defaultServer = await setDefaultServer(server);
        if (defaultServer == true) {
          _serversList.add(server);
          notifyListeners();
          return true;
        }
        else {
          return false;
        }
      }
      else {
        _serversList.add(server);
        notifyListeners();
        return true;
      }
    }
    else {
      return false;
    }
  }

  Future<bool> setDefaultServer(Server server) async {
    final updated = await setDefaultServerDb(server.id);
    if (updated == true) {
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
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> editServer(Server server) async {
    final result = await editServerDb(server);
    if (result == true) {
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
      return true;
    }
    else {
      return false;
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

  Future<bool> saveServerIntoDb(Server server) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO servers (id, name, connectionMethod, domain, path, port, user, password, defaultServer, authToken) VALUES ("${server.id}", "${server.name}", "${server.connectionMethod}", "${server.domain}", ${server.path != null ? "${server.path}" : null}, ${server.port}, "${server.user}", "${server.password}", 0, "${server.authToken}")',
        );
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  Future<bool> editServerDb(Server server) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE servers SET name = "${server.name}", connectionMethod = "${server.connectionMethod}", domain = "${server.domain}", path = ${server.path != null ? "${server.path}" : null}, port = ${server.port}, user = "${server.user}", password = "${server.password}", authToken = "${server.authToken}" WHERE id = "${server.id}"',
        );
        return true;
      });
    } catch (e) {
      return false;
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

  Future<bool> setDefaultServerDb(String id) async {
    try {
      return await _dbInstance!.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE servers SET defaultServer = 0 WHERE defaultServer = 1',
        );
        await txn.rawUpdate(
          'UPDATE servers SET defaultServer = 1 WHERE id = "$id"',
        );
        return true;
      });
    } catch (e) {
      return false;
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
          authToken: server['authToken']
        );
        _serversList.add(serverObj);
        if (convertFromIntToBool(server['defaultServer']) == true) {
          _selectedServer = serverObj;
          final dnsStatistics = await getDnsStatistics(serverObj);
          if (dnsStatistics['result'] == 'success') {
            _dnsStatistics = dnsStatistics['data'];
            _isServerConnected = true;
          }
          else {
            _isServerConnected = false;
          }
        }
      }
    }
    notifyListeners();
  }
}