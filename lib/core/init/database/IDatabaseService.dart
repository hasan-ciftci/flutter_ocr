import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider<T extends RecordModel> {
  Future open();
  Future<List<T>> getRecordList(String username);
  Future<bool> updateRecord(int id, T model);
  Future<bool> insertRecord(T model);

  Database database;

  Future<void> close() async {
    await database.close();
  }
}
