import 'package:flutter/material.dart';
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

  addRecord(List<dynamic> recordList) {
    _recordList.addAll(recordList);
  }

  getRecord(int index) => _recordList[index];

  clearList() => _recordList.clear();
}
