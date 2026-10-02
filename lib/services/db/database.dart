import 'package:sqflite/sqflite.dart';

/// Schema changes since the settings tables moved out of SQLite. Existing
/// installs are version 11, which has `runningOnHa` and no `glinetAuth`.
Future<void> upgradeDatabase(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 12) {
    await db.execute(
      'ALTER TABLE servers ADD COLUMN glinetAuth INTEGER DEFAULT 0',
    );
  }
}

Future<Map<String, dynamic>> loadDb() async {
  List<Map<String, Object?>>? servers;

  Database db = await openDatabase(
    'adguard_home_manager.db',
    version: 12,
    onCreate: (Database db, int version) async {
      await db.execute(
        """
          CREATE TABLE 
            servers (
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
              runningOnHa INTEGER,
              glinetAuth INTEGER
            )
        """
      );
    },
    onUpgrade: upgradeDatabase,
    onOpen: (Database db) async {
      await db.transaction((txn) async{
        servers = await txn.rawQuery(
          'SELECT * FROM servers',
        );
      });
    }
  );

  return {
    "servers": servers,
    "dbInstance": db,
  };
}