import 'dart:async';

import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'singlerecord_view_model.g.dart';

class SingleRecordViewModel = _SingleRecordViewModelBase
    with _$SingleRecordViewModel;

abstract class _SingleRecordViewModelBase with Store {
  Completer<GoogleMapController> controller = Completer();

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    bearing: 20,
  );

  @observable
  int recordId;

  @observable
  double latitude;
  @observable
  double longitude;

  @action
  setRecordId(int currentId) {
    recordId = currentId;
  }

  @action
  Future<RecordModel> getRecordInfo(int currentId) async {
    final record = await DatabaseService.instance.getItem(currentId);
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
