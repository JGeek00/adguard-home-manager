import 'package:sqflite/sqflite.dart';

Future<Map<String, dynamic>> loadDb(bool acceptsDynamicTheme) async {
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

  Future upgradeDbToV4(Database db) async {
    await db.execute("ALTER TABLE servers ADD COLUMN runningOnHa INTEGER");
    await db.execute("UPDATE servers SET runningOnHa = 0");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM servers',
      );
    });
  }

  Future upgradeDbToV5(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN useDynamicColor NUMERIC");
    await db.execute("ALTER TABLE appConfig ADD COLUMN staticColor NUMERIC");
    await db.execute("ALTER TABLE appConfig ADD COLUMN useThemeColorForStatus NUMERIC");
    await db.execute("UPDATE appConfig SET useDynamicColor = ${acceptsDynamicTheme == true ? 1 : 0}, staticColor = 0, useThemeColorForStatus = 0");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Future upgradeDbToV6(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN showNameTimeLogs NUMERIC");
    await db.execute("UPDATE appConfig SET showNameTimeLogs = 0");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Future upgradeDbToV7(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN doNotRememberVersion TEXT");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Database db = await openDatabase(
    'adguard_home_manager.db',
    version: 7,
    onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE servers (id TEXT PRIMARY KEY, name TEXT, connectionMethod TEXT, domain TEXT, path TEXT, port INTEGER, user TEXT, password TEXT, defaultServer INTEGER, authToken TEXT, runningOnHa INTEGER)");
      await db.execute("CREATE TABLE appConfig (theme NUMERIC, overrideSslCheck NUMERIC, hideZeroValues NUMERIC, useDynamicColor NUMERIC, staticColor NUMERIC, useThemeColorForStatus NUMERIC, showNameTimeLogs NUMERIC, doNotRememberVersion TEXT)");
      await db.execute("INSERT INTO appConfig (theme, overrideSslCheck, hideZeroValues, useDynamicColor, staticColor, useThemeColorForStatus, showNameTimeLogs) VALUES (0, 0, 0, ${acceptsDynamicTheme == true ? 1 : 0}, 0, 0, 0)");
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion == 1) {
        await upgradeDbToV2(db);
        await upgradeDbToV3(db);
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
      }
      if (oldVersion == 2) {
        await upgradeDbToV3(db);
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
      }
      if (oldVersion == 3) {
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
      }
      if (oldVersion == 4) {
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
      }
      if (oldVersion == 5) {
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
      }
      if (oldVersion == 6) {
        await upgradeDbToV7(db);
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