import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';

part 'records_view_model.g.dart';

class RecordsViewModel = _RecordsViewModelBase with _$RecordsViewModel;

abstract class _RecordsViewModelBase with Store {
  DatabaseService recordDataBaseProvider;
  @observable
  int page = 0;
  @observable
  ScrollController scrollController = ScrollController();
  @observable
  bool isLoading = false;
  @observable
  ObservableList users = ObservableList();
  final dio = Dio();
  @observable
  List tList = [];

  init() {
    recordDataBaseProvider = DatabaseService.instance;
  }

  @action
  startFetchingData() {
    isLoading = true;
  }

  @action
  completeFetchingData() {
    print(page);
    isLoading = false;
    users.addAll(tList);
    page++;
  }

  Future<void> getMoreData(int index) async {
    startFetchingData();

    var url =
        "https://parxlab-ocr-engine-root-service-dev.azurewebsites.net/api/v1/OCREngine/GetHistory";

    final response = await dio.get(url,
        queryParameters: {"page": page, "limit": 10});
    tList = ObservableList();

    for (int i = 0; i < response.data['data'].length; i++) {
      tList.add(response.data['data'][i]);
    }


    completeFetchingData();
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
