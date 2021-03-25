import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';

part 'singlerecord_view_model.g.dart';

class SingleRecordViewModel = _SingleRecordViewModelBase
    with _$SingleRecordViewModel;

abstract class _SingleRecordViewModelBase with Store {
  @observable
  int recordId;

  @action
  setRecordId(int currentId) {
    recordId = currentId;
  }

  @action
  Future<RecordModel> getRecordInfo() async {
    final record = await DatabaseService.instance.getItem(recordId);
    return record;
  }

  @action
  getNext() async {
    var myMap = await DatabaseService.instance.getNextItem(recordId);
    recordId = myMap["id"];
  }

  @action
  getPrevious() async {
    var myMap = await DatabaseService.instance.getPreviousItem(recordId);
    recordId = myMap["id"];
  }
}
