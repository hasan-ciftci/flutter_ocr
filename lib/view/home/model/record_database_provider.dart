import 'package:flutter_ocr/core/init/database/database_provider.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:sqflite/sqflite.dart';

class RecordDataBaseProvider extends DatabaseProvider<RecordModel> {
  String _databaseName = "recordsdb";
  String _tableName = "records";
  int _version = 1;
  Database database;

  String columnId = "id";
  String columnUsername = "username";
  String columnPlate = "plate";
  String columnDate = "date";
  String columnLatitude = "latitude";
  String columnLongitude = "longitude";
  String columnAltitude = "altitude";
  String columnHeading = "heading";
  String columnSpeed = "speed";
  String columnSpeedAccuracy = "speedAccuracy";
  String columnTimestamp = "timeStamp";
  String columnFloor = "floor";
  String columnIsMocked = "isMocked";

  @override
  Future<List<RecordModel>> getRecordList(String username) async {
    if (database != null) open();
    List<Map> recordsMap = await database.query(_tableName);
    return recordsMap.map((e) => RecordModel.fromJson(e)).toList();
  }

  @override
  Future<bool> insertRecord(RecordModel model) async {
    if (database != null) open();

    final recordsMap = await database.insert(
      _tableName,
      model.toJson(),
    );

    return recordsMap != null;
  }

  @override
  Future open() async {
    database = await openDatabase(
      _databaseName,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  @override
  Future<bool> updateRecord(int id, RecordModel model) async {
    if (database != null) open();

    final recordsMap = await database.update(
      _tableName,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return recordsMap != null;
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE IF NOT EXISTS $_tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnUsername VARCHAR(20),
        $columnPlate VARCHAR(20),
        $columnDate datetime default current_timestamp,
        $columnLatitude DOUBLE,
        $columnLongitude DOUBLE,
        $columnAltitude DOUBLE,
        $columnHeading DOUBLE,
        $columnSpeed DOUBLE,
        $columnSpeedAccuracy DOUBLE,
        $columnFloor INTEGER, 
        $columnIsMocked INTEGER )
        ''',
    );
  }
}
