import 'package:sqflite/sqflite.dart';

import '../db/db_context.dart';
import '../models/task_model.dart';

class TaskRepository {
  late DatabaseContext localDb;
  String tableName = 'task';

  TaskRepository() {
    localDb = DatabaseContext();
  }

  Future<List<TaskModel>> getAll() async {
    final db = await localDb.database;
    List<Map<String, dynamic>> mapa = await db.query(tableName);
    return List.generate(mapa.length, (index) {
      return TaskModel.fromDb(mapa[index]);
    });
  }

  Future<TaskModel> getOne(id) async {
    final db = await localDb.database;
    List<Map<String, dynamic>> mapa =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return TaskModel.fromDb(mapa[0]);
  }

  Future<void> add(TaskModel obj) async {
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
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> update(TaskModel obj) async {
    final db = await localDb.database;
    await db.update(
      tableName,
      obj.toMapSqlite(),
      where: 'id = ?',
      whereArgs: [obj.id],
    );
  }
}