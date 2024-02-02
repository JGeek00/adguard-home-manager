import 'package:sqflite/sqflite.dart';

Future<Map<String, dynamic>> loadDb() async {
  List<Map<String, Object?>>? servers;

  Database db = await openDatabase(
    'adguard_home_manager.db',
    version: 11,
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
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      
    },
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