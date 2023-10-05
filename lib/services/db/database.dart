import 'package:sqflite/sqflite.dart';

import 'package:adguard_home_manager/config/home_top_items_default_order.dart';

Future<Map<String, dynamic>> loadDb(bool acceptsDynamicTheme) async {
  List<Map<String, Object?>>? servers;
  List<Map<String, Object?>>? appConfig;

  Future rebuildAppConfig(Database db) async {
    await db.execute("DROP TABLE appConfig");
    await db.execute("CREATE TABLE appConfig (theme NUMERIC, overrideSslCheck NUMERIC, hideZeroValues NUMERIC, useDynamicColor NUMERIC, staticColor NUMERIC, useThemeColorForStatus NUMERIC, showTimeLogs NUMERIC, showIpLogs NUMERIC, combinedChart NUMERIC, doNotRememberVersion TEXT)");
    await db.execute("INSERT INTO appConfig (theme, overrideSslCheck, hideZeroValues, useDynamicColor, staticColor, useThemeColorForStatus, showTimeLogs, showIpLogs, combinedChart) VALUES (0, 0, 0, ${acceptsDynamicTheme == true ? 1 : 0}, 0, 0, 0, 0, 0)");
  }

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

  Future upgradeDbToV8(Database db) async {
    try {
      final data = await db.rawQuery(
        'SELECT * FROM appConfig',
      );
      await rebuildAppConfig(db);
      await db.update(
        'appConfig', 
        {
          'theme': data[0]['theme'],
          'overrideSslCheck': data[0]['overrideSslCheck'],
          'hideZeroValues': data[0]['hideZeroValues'],
          'useDynamicColor': data[0]['useDynamicColor'],
          'staticColor': data[0]['staticColor'],
          'useThemeColorForStatus': data[0]['useThemeColorForStatus'],
          'showTimeLogs': data[0]['showNameTimeLogs'],
          'showIpLogs': data[0]['showIpLogs'],
          'combinedChart': data[0]['combinedChart'],
        }
      );
    } catch (e) {
      await rebuildAppConfig(db);
    }
  }

  Future upgradeDbToV9(Database db) async {
    await db.execute("ALTER TABLE appConfig ADD COLUMN hideServerAddress NUMERIC");
    await db.execute("ALTER TABLE appConfig ADD COLUMN homeTopItemsOrder TEXT");
    await db.execute("UPDATE appConfig SET hideServerAddress = 0, homeTopItemsOrder = '$homeTopItemsDefaultOrderString'");

    await db.transaction((txn) async{
      await txn.rawQuery(
        'SELECT * FROM appConfig',
      );
    });
  }

  Database db = await openDatabase(
    'adguard_home_manager.db',
    version: 9,
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
              runningOnHa INTEGER
            )
        """
      );

      await db.execute(
        """
          CREATE TABLE 
            appConfig (
              theme NUMERIC, 
              overrideSslCheck NUMERIC, 
              hideZeroValues NUMERIC, 
              useDynamicColor NUMERIC, 
              staticColor NUMERIC, 
              useThemeColorForStatus NUMERIC, 
              showTimeLogs NUMERIC, 
              showIpLogs NUMERIC, 
              combinedChart NUMERIC, 
              doNotRememberVersion TEXT, 
              hideServerAddress NUMERIC, 
              homeTopItemsOrder TEXT
            )
        """
      );

      await db.execute(
        """
          INSERT INTO 
            appConfig (
              theme, 
              overrideSslCheck, 
              hideZeroValues, 
              useDynamicColor, 
              staticColor, 
              useThemeColorForStatus, 
              showTimeLogs, 
              showIpLogs, 
              combinedChart, 
              hideServerAddress, 
              homeTopItemsOrder
            ) 
          VALUES (
            0, 
            0, 
            0, 
            ${acceptsDynamicTheme == true ? 1 : 0}, 
            0, 
            0, 
            0, 
            0, 
            0, 
            0, 
            '$homeTopItemsDefaultOrderString'
          )
        """
      );
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion == 1) {
        await upgradeDbToV2(db);
        await upgradeDbToV3(db);
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 2) {
        await upgradeDbToV3(db);
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 3) {
        await upgradeDbToV4(db);
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 4) {
        await upgradeDbToV5(db);
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 5) {
        await upgradeDbToV6(db);
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 6) {
        await upgradeDbToV7(db);
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 7) {
        await upgradeDbToV8(db);
        await upgradeDbToV9(db);
      }
      if (oldVersion == 8) {
        await upgradeDbToV9(db);
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