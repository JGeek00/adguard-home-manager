import 'package:sqflite/sqflite.dart';

Future<Map<String, dynamic>> loadDb() async {
  List<Map<String, Object?>>? servers;
  List<Map<String, Object?>>? appConfig;

  Future upgradeDbToV2(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN overrideSslCheck NUMERIC");
    await db.execute("UPDATE appConfig SET overrideSslCheck = 0");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Future upgradeDbToV3(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN hideZeroValues NUMERIC");
    await db.execute("UPDATE appConfig SET hideZeroValues = 0");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Database db = await openDatabase(
    'adguard_home_manager.db',
    version: 3,
    onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE servers (id TEXT PRIMARY KEY, name TEXT, connectionMethod TEXT, domain TEXT, path TEXT, port INTEGER, user TEXT, password TEXT, defaultServer INTEGER, authToken TEXT)");
      await db.execute("CREATE TABLE appConfig (theme NUMERIC, overrideSslCheck NUMERIC, hideZeroValues NUMERIC)");
      await db.execute("INSERT INTO appConfig (theme, overrideSslCheck) VALUES (0, 0, 0)");
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion == 1) {
        await upgradeDbToV2(db);
        await upgradeDbToV3(db);
      }
      if (oldVersion == 2) {
        await upgradeDbToV3(db);
      }
    },
    onOpen: (Database db) async {
      await db.transaction((txn) async{
        servers = await txn.rawQuery(
          'SELECT * FROM servers',
        );
      });
      await db.transaction((txn) async{
        appConfig = await txn.rawQuery(
          'SELECT * FROM appConfig',
        );
      });
    }
  );

  return {
    "servers": servers,
    "appConfig": appConfig![0],
    "dbInstance": db,
  };
}