import 'package:sqflite/sqflite.dart';

import '../db/db_context.dart';
import '../models/country_model.dart';

class CountryRepository {
  late DatabaseContext localDb;
  String tableName = 'country';

  CountryRepository() {
    localDb = DatabaseContext();
  }

  Future<List<CountryModel>> getAll() async {
    final db = await localDb.database;
    List<Map<String, dynamic>> mapa = await db.query(tableName, orderBy: 'code');
    return List.generate(mapa.length, (index) {
      return CountryModel.fromDb(mapa[index]);
    });
  }

  Future<CountryModel> getOne(id) async {
    final db = await localDb.database;
    List<Map<String, dynamic>> mapa =
        await db.query(tableName, where: 'code = ?', whereArgs: [id]);
    return CountryModel.fromDb(mapa[0]);
  }

  Future<void> add(CountryModel obj) async {
    final db = await localDb.database;
    await db.insert(
      tableName,
      obj.toMapSqlite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteAll() async {
    final db = await localDb.database;
    await db.delete(
      tableName,
    );
  }

  Future<void> deleteOne(id) async {
    final db = await localDb.database;
    await db.delete(
      tableName,
      where: 'code = ?',
      whereArgs: [id],
    );
  }

  Future<void> update(CountryModel obj) async {
    final db = await localDb.database;
    await db.update(
      tableName,
      obj.toMapSqlite(),
      where: 'code = ?',
      whereArgs: [obj.code],
    );
  }
}