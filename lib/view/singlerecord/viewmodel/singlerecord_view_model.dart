import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../model/plate_image_guid_model.dart';

part 'singlerecord_view_model.g.dart';

class SingleRecordViewModel = _SingleRecordViewModelBase
    with _$SingleRecordViewModel;

abstract class _SingleRecordViewModelBase with Store {
  BuildContext myContext;

  setContext(BuildContext ctx) {
    myContext = ctx;
  }

  Completer<GoogleMapController> controller = Completer();

  CameraPosition markedPosition;

  getCameraPosition(double latitude, double longitude) {
    return markedPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 10.0,
    );
  }

  ///Gets value on build from widgets final parameter
  @observable
  int recordId;

  ///Update [recordId]
  @action
  setRecordId(int currentId) {
    recordId = currentId;
  }

  ///Get record from local data with [recordId]
  @action
  Future<RecordModel> getRecordInfo(int currentId) async {
    final record = await DatabaseService.instance.getItem(currentId);
    return record;
  }

  ///Update [recordId] with smallest value bigger than current [recordId]
  @action
  getNext() async {
    var myMap = await DatabaseService.instance.getNextItem(recordId);
    recordId = myMap["id"];
  }

  ///Update [recordId] with biggest value smaller than current [recordId]
  @action
  getPrevious() async {
    var myMap = await DatabaseService.instance.getPreviousItem(recordId);
    recordId = myMap["id"];
  }

  ///Send an API request to get Image with link of record on online mod.
  Future<String> getImage(String base64ImgUrl) async {
    String imageGuid = base64ImgUrl.split("/").last.toUpperCase();
    PlateImageGuidModel plateImageGuidModel =
        PlateImageGuidModel(guid: imageGuid);
    var response = await NetworkManager.instance.dioGet<PlateImageGuidModel>(
        baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
        endPoint: ApiConstants.GET_IMAGE_ASYNC_ENDPOINT,
        model: plateImageGuidModel);
    final decodedBytes = response["data"];
    return decodedBytes;
  }
}
