import 'package:sqflite/sqflite.dart' as Sqfite;
import 'package:path/path.dart' as Path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DB_helpers {
  //for connect database
  static Future<Database> database() async {
    final get_DB_path = await Sqfite.getDatabasesPath();
    final Sqldatabase = await Sqfite.openDatabase(
        Path.join(get_DB_path, 'Places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE subscriber_places(id TEXT PRIMARY KEY,title TEXT,image TEXT, cityname TEXT');
    }, version: 1);

    return Sqldatabase;
  }

//for insertData
  static Future<void> insertData(String table, Map<String, Object> data) async {
    final sqlDataBAse = await database();
    sqlDataBAse.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//for gettingData
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDataBase = await database();
    return sqlDataBase.query(table);
  }
}
