import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';

part 'records_view_model.g.dart';

class RecordsViewModel = _RecordsViewModelBase with _$RecordsViewModel;

abstract class _RecordsViewModelBase with Store {
  DatabaseService recordDataBaseProvider;

  init() {
    recordDataBaseProvider = DatabaseService.instance;
  }

  Future<List<RecordModel>> getPlates() async {
    var x = await recordDataBaseProvider.getRecordList("username");
    return x;
  }
}
