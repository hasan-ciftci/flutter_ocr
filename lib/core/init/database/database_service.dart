import 'package:flutter_ocr/core/init/database/IDatabaseService.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends DatabaseProvider<RecordModel> {
  static DatabaseService _instance;

  static DatabaseService get instance {
    _instance ??= DatabaseService._init();
    return _instance;
  }

  DatabaseService._init();

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
  String columntimestamp = "timestamp";
  String columnBase64Image = "base64Image";

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
        $columnUsername VARCHAR(100),
        $columnPlate VARCHAR(100),
        $columnDate datetime default current_timestamp,
        $columnLatitude DOUBLE,
        $columnLongitude DOUBLE,
        $columnAltitude DOUBLE,
        $columnHeading DOUBLE,
        $columnSpeed DOUBLE,
        $columnSpeedAccuracy DOUBLE,
        $columnFloor INTEGER, 
        $columnIsMocked INTEGER,
        $columnTimestamp VARCHAR(100),
        $columnBase64Image VARCHAR(255) )
        ''',
    );
  }

  @override
  Future<RecordModel> getItem(int id) async {
    if (database != null) open();

    final userMaps = await database.query(
      _tableName,
      where: '$columnId = ?',
      columns: [
        columnId,
        columnUsername,
        columnPlate,
        columnDate,
        columnLatitude,
        columnLongitude,
        columnAltitude,
        columnHeading,
        columnSpeed,
        columnSpeedAccuracy,
        columnTimestamp,
        columnFloor,
        columnIsMocked,
        columntimestamp,
        columnBase64Image
      ],
      whereArgs: [id],
    );

    if (userMaps.isNotEmpty)
      return RecordModel.fromJson(userMaps.first);
    else
      return null;
  }

  Future<Map<String, dynamic>> getNextItem(int id) async {
    if (database != null) open();

    final userMaps = await database.query(
      _tableName,
      where: '$columnId > ?',
      columns: [
        columnId,
      ],
      orderBy: "id ASC",
      limit: 1,
      whereArgs: [id],
    );

    if (userMaps.isNotEmpty)
      return userMaps.first;
    else
      return null;
  }

  Future<Map<String, dynamic>> getPreviousItem(int id) async {
    if (database != null) open();

    final userMaps = await database.query(
      _tableName,
      where: '$columnId < ?',
      columns: [
        columnId,
      ],
      orderBy: "id DESC",
      limit: 1,
      whereArgs: [id],
    );

    if (userMaps.isNotEmpty)
      return userMaps.first;
    else
      return null;
  }
}
