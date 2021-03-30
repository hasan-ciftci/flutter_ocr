import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';

import '../records_service.dart';

part 'records_view_model.g.dart';

class RecordsViewModel = _RecordsViewModelBase with _$RecordsViewModel;

abstract class _RecordsViewModelBase with Store {
  DatabaseService recordDataBaseProvider;
  RecordsService _recordsService;
  @observable
  int page = 0;
  @observable
  ScrollController scrollController = ScrollController();
  @observable
  bool isLoading = false;
  @observable
  ObservableList users = ObservableList();
  @observable
  List newData = [];

  init() {
    recordDataBaseProvider = DatabaseService.instance;
    _recordsService = RecordsService();
  }

  @action
  startFetchingData() {
    isLoading = true;
  }

  @action
  completeFetchingData() {
    isLoading = false;
    users.addAll(newData);
    page++;
  }

  Future<void> getMoreData() async {
    startFetchingData();

    final fetchedNewRecords = await _recordsService.fetchRecords(
        quantityOfData: 10, paginationPage: page);
    newData
      ..clear()
      ..addAll(fetchedNewRecords['data']);

    completeFetchingData();
  }

  Future<List<RecordModel>> getPlates() async {
    var recordList = await recordDataBaseProvider.getRecordList("username");
    return recordList;
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
