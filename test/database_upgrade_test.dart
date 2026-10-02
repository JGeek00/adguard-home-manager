import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:adguard_home_manager/services/db/database.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('version 11 rows keep runningOnHa and gain glinetAuth 0', () async {
    final path = '${Directory.systemTemp.path}/agh-v11-${DateTime.now().microsecondsSinceEpoch}.db';
    addTearDown(() async {
      final file = File(path);
      if (await file.exists()) await file.delete();
    });

    final created = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 11,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE servers (
              id TEXT PRIMARY KEY,
              name TEXT,
              connectionMethod TEXT,
              domain TEXT,
              path TEXT,
              port INTEGER,
              user TEXT,
              password TEXT,
              defaultServer INTEGER,
              authToken TEXT,
              runningOnHa INTEGER
            )
          ''');
        },
      ),
    );
    await created.insert('servers', {
      'id': 'ha',
      'name': 'ha',
      'connectionMethod': 'http',
      'domain': '10.0.0.2',
      'runningOnHa': 1,
      'defaultServer': 0,
    });
    await created.insert('servers', {
      'id': 'plain',
      'name': 'plain',
      'connectionMethod': 'http',
      'domain': '10.0.0.1',
      'runningOnHa': 0,
      'defaultServer': 1,
    });
    await created.close();

    final upgraded = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 12,
        onUpgrade: upgradeDatabase,
      ),
    );
    final rows = await upgraded.query('servers', orderBy: 'id');
    await upgraded.close();

    expect(rows, hasLength(2));
    expect(rows[0]['id'], 'ha');
    expect(rows[0]['runningOnHa'], 1);
    expect(rows[0]['glinetAuth'], 0);
    expect(rows[1]['id'], 'plain');
    expect(rows[1]['runningOnHa'], 0);
    expect(rows[1]['glinetAuth'], 0);
  });
}
