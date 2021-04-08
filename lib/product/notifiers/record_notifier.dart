import 'package:flutter/foundation.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';

class RecordNotifier extends ChangeNotifier {
  List _recordList = [];
  int _index;

  //Gets list of records from API
  //When lazy scroll updates list, clears history and add latest version of list
  addRecord(List<dynamic> recordList) {
    _recordList
      ..clear()
      ..addAll(recordList);
  }

  ///Gets [index] from Record View when a Record Card selected
  ///Returns [ServiceRecordModel] to show on Single Record View
  ServiceRecordModel getRecord(int index) {
    ServiceRecordModel serviceRecordModel =
        ServiceRecordModel.fromJson(_recordList[index]);
    return serviceRecordModel;
  }

  clearList() => _recordList.clear();

  ///Passing [selectedIndex] to provider for neglecting ID business in build method.
  setSelectedIndex(int selectedIndex) => _index = selectedIndex;

  ///Update Provider's [_index] value
  getNextRecord() {
    if (_index < _recordList.length - 1) {
      _index++;
      notifyListeners();
    }
  }

  ///Update Provider's [_index] value
  getPreviousRecord() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  ///Get current index of [_recordList] on Provider.
  int get index => _index;
}
