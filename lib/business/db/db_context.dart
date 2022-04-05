import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseContext {
  Database? _database;
  final String dbName = 'data.db';

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), dbName);
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      // Init ffi loader if needed.
      sqfliteFfiInit();
      // Get database factory
      var databaseFactory = databaseFactoryFfi;
      // Get directory of the app
      Directory appDirectory = await getApplicationSupportDirectory();
      String appDirectoryPath = appDirectory.path;
      // Set db creation options
      var options = OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      );
      // Set db path
      String path = join(appDirectoryPath, dbName);
      // Factory db
      return await databaseFactory.openDatabase(path, options: options);
    }
  }

  // Method that create the database the first time
  Future _onCreate(Database db, int version) async {
    // tasks table
    String cmd = "CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, ";
    cmd += "content TEXT, date TEXT, state INTEGER)";
    await db.execute(cmd);

    // country table
    cmd = "CREATE TABLE country (code TEXT PRIMARY KEY, ";
    cmd += "name TEXT, continent TEXT, latitude REAL,";
    cmd += "longitude REAL, timezone TEXT, flag TEXT)";
    await db.execute(cmd);
  }
}