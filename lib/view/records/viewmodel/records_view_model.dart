import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/core/init/notifier/provider_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

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
  BuildContext myContext;

  init() {
    recordDataBaseProvider = DatabaseService.instance;
    _recordsService = RecordsService();
  }

  void getContext(BuildContext ctx) {
    myContext = ctx;
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
    List recordData = fetchedNewRecords['data'];
    print(
        "recordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordData");
    print(recordData);
    print(
        "recordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordDatarecordData");
    newData
      ..clear()
      ..addAll(recordData);

    updateRecordNotifier(recordData);

    completeFetchingData();
  }

  updateRecordNotifier(List recordData) {
    Provider.of<RecordNotifier>(myContext, listen: false).addRecord(recordData);
  }

  Future<List<RecordModel>> getPlates() async {
    var recordList = await recordDataBaseProvider.getRecordList("username");
    return recordList;
  }

  Future<void> getFirstDataOnline() async {
    try {
      ConnectivityResult result =
          Provider.of<ConnectionNotifier>(myContext, listen: false)
              .connectivityResult;
      if (result != ConnectivityResult.none) {
        await getMoreData();
        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            await getMoreData();
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  transformOfflineRecordsToFormDataList(
      List<RecordModel> plates, Map<dynamic, dynamic> recordAndPlateMap) {
    List<FormData> bulkRecordFormData = plates.map((e) {
      recordAndPlateMap.addAll({"plate-${e.timestamp}.jpg": "${e.id}"});
      return FormData.fromMap(
        {
          "Image": MultipartFile.fromBytes(base64Decode(e.base64Image),
              filename: "plate-${e.timestamp}.jpg"),
          "LicensePlate": e.plate,
          "Username": e.username,
        },
      );
    }).toList();
    return bulkRecordFormData;
  }

  deleteTransferredOfflineRecords(List<FormData> bulkRecordFormData,
      Map<dynamic, dynamic> recordAndPlateMap) async {
    for (var element in bulkRecordFormData) {
      try {
        await NetworkManager.instance.dioPostForm(
            baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
            endPoint: ApiConstants.BULK_SAVE_ENDPOINT,
            file: element);

        int savedRecordId =
            int.parse(recordAndPlateMap[element.files.first.value.filename]);
        await DatabaseService.instance.removeItem(savedRecordId);
      } catch (e) {
        print(e);

        ///Skip deleting local item due to an error.
      }
    }
  }

  Future<bool> checkIfOfflineRecordsExists() async {
    ConnectivityResult result =
        myContext.read<ConnectionNotifier>().connectivityResult;
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      var plates = await getPlates();
      if (plates != null) {
        try {
          Map<dynamic, dynamic> recordAndPlateMap = Map();
          List<FormData> bulkRecordFormData =
              transformOfflineRecordsToFormDataList(plates, recordAndPlateMap);

          await deleteTransferredOfflineRecords(
              bulkRecordFormData, recordAndPlateMap);
        } catch (e) {
          print(e);
        }
        return true;
      }
      return false;
    }
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

  dispose() {
    Provider.of<RecordNotifier>(myContext, listen: false).clearList();
  }
}
