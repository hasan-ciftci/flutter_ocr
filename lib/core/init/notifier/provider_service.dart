import 'package:flutter/material.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderService {
  static ProviderService _instance;

  static ProviderService get instance {
    if (_instance == null) _instance = ProviderService._init();
    return _instance;
  }

  ProviderService._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => RecordNotifier(),
    ),
  ];
}

class RecordNotifier extends ChangeNotifier {
  List _recordList = [];
  int _index;

  addRecord(List<dynamic> recordList) {
    _recordList.addAll(recordList);
  }

  ServiceRecordModel getRecord(int index) {
    ServiceRecordModel serviceRecordModel =
        ServiceRecordModel.fromJson(_recordList[index]);
    return serviceRecordModel;
  }

  clearList() => _recordList.clear();

  setSelectedIndex(int selectedIndex) => _index = selectedIndex;

  getNextRecord() {
    if (_index < _recordList.length - 1) {
      _index++;
      notifyListeners();
    }
  }

  getPreviousRecord() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  int get index => _index;
}
