import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/models/server.dart';

class ServersProvider with ChangeNotifier {
  Database? _dbInstance;

  List<Server> _serversList = [];
  Server? _selectedServer;

  List<Server> get serversList {
    return _serversList;
  }

  Server? get selectedServer {
    return _selectedServer;
  }

  void setDbInstance(Database db) {
    _dbInstance = db;
  }

  void addServer(Server server) {
    _serversList.add(server);
    notifyListeners();
  }

  void saveFromDb(List<Map<String, dynamic>>? data) async {
    if (data != null) {
      for (var server in data) {
        final Server serverObj = Server(
          name: server['name'],
          connectionMethod: server['connectionMethod'],
          domain: server['domain'],
          path: server['path'],
          port: server['port'],
          user: server['user'],
          password: server['password'],
          defaultServer: convertFromIntToBool(server['isDefaultServer'])!,
        );
        _serversList.add(serverObj);
        if (convertFromIntToBool(server['isDefaultServer']) == true) {
          _selectedServer = serverObj;
        }
      }
    }
    notifyListeners();
  }
}