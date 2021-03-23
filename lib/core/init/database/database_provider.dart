import 'package:sqflite/sqflite.dart';

import 'database_model.dart';

abstract class DatabaseProvider<T extends DatabaseModel> {
  Future open();
  Future<List<T>> getRecordList(String username);
  Future<bool> updateRecord(int id, T model);
  Future<bool> insertRecord(T model);

  Database database;

  Future<void> close() async {
    await database.close();
  }
}
