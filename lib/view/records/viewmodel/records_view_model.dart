import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
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

  navigateToSingleRecordViewPage(int recordId) {
    NavigationService.instance.navigateToPage(
        path: NavigationConstants.SINGLE_RECORD_VIEW,
        data: {"passedId": recordId});
    setCurrentId(recordId);
  }

  @action
  setCurrentId(int currentId) {
    id = currentId;
  }

  @observable
  int id;
}
