import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/functions/conversions.dart';
import 'package:adguard_home_manager/models/server.dart';

Future<dynamic> saveServerQuery(Database db, Server server) async {
  try {
    return await db.transaction((txn) async {
      await txn.insert(
        'servers',
        { 
          'id': server.id,
          'name': server.name,
          'connectionMethod': server.connectionMethod,
          'domain': server.domain,
          'path': server.path,
          'port': server.port,
          'user': server.user,
          'password': server.password,
          'defaultServer': convertFromBoolToInt(server.defaultServer),
          'authToken': server.authToken,
          'runningOnHa': convertFromBoolToInt(server.runningOnHa)
        }
      );
      return null;
    });
  } catch (e) {
    return e;
  }
}

Future<dynamic> editServerQuery(Database db, Server server) async {
  try {
    return await db.transaction((txn) async {
      await txn.update(
        'servers',
        { 
          'id': server.id,
          'name': server.name,
          'connectionMethod': server.connectionMethod,
          'domain': server.domain,
          'path': server.path,
          'port': server.port,
          'user': server.user,
          'password': server.password,
          'defaultServer': server.defaultServer,
          'authToken': server.authToken,
          'runningOnHa': convertFromBoolToInt(server.runningOnHa)
        },
        where: 'id = ?',
        whereArgs: [server.id]
      );
      return null;
    });
  } catch (e) {
    return e;
  }
}


Future<bool> removeServerQuery(Database db, String id) async {
  try {
    return await db.transaction((txn) async {
      await txn.delete(
        'servers', 
        where: 'id = ?', 
        whereArgs: [id]
      );
      return true;
    });
  } catch (e) {
    return false;
  }
}

Future<dynamic> setDefaultServerQuery(Database db, String id) async {
  try {
    return await db.transaction((txn) async {
      await txn.update(
        'servers',
        {'defaultServer': '0'},
        where: 'defaultServer = ?',
        whereArgs: [1]
      );
      await txn.update(
        'servers',
        {'defaultServer': '1'},
        where: 'id = ?',
        whereArgs: [id]
      );
      return null;
    });
  } catch (e) {
    return e;
  }
}

Future<bool> updateConfigQuery({
  required Database db, 
  required String column,
  required dynamic value
}) async {
  try {
    return await db.transaction((txn) async {
      await txn.update(
        'appConfig',
        { column: value },
      );
      return true;
    });
  } catch (e) {
    return false;
  }
}