import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/preferences_keys.dart';
import 'package:flutter_ocr/core/init/image%20picker/image_picker.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/model/position_model.dart';
import 'package:flutter_ocr/view/home/model/record_database_provider.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  String _producedText;
  File _selectedImage;
  TextEditingController editingController;
  FocusNode focusNode;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  RecordDataBaseProvider recordDataBaseProvider;

  init() {
    editingController = TextEditingController();
    focusNode = FocusNode();
    recordDataBaseProvider = RecordDataBaseProvider();
    recordDataBaseProvider.open();
  }

  @action
  Future<void> scanImage() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      //Scan Image with API
      //TODO:IMPLEMENT API CONNECTION
      _getPosition();
      scanImageOffline();
    } else {
      await scanImageOffline();
    }
  }

  @action
  void updateEditableText(value) {
    scannedText = value;
  }

  getLicensePlates() async {
    //TODO:PUSH RECORDS PAGE
    final result = await recordDataBaseProvider.getRecordList(
        PreferencesManager.instance.getStringValue(PreferencesKeys.USER_NAME));
    result.forEach((element) {
      print(element.toJson());
    });
  }

  Future<void> saveLicensePlate() async {
    //TODO: IMPLEMENT SAVING OPERATIONS FOR API
    _changeLoadingStatus();
    await recordDataBaseProvider.insertRecord(
      RecordModel(
        latitude: locationModel?.latitude,
        longitude: locationModel?.longitude,
        altitude: locationModel?.altitude,
        speedAccuracy: locationModel?.speedAccuracy,
        heading: locationModel?.heading,
        plate: scannedText,
        speed: locationModel?.speed,
        isMocked: locationModel?.isMocked,
        floor: locationModel?.floor,
        username: PreferencesManager.instance
            .getStringValue(PreferencesKeys.USER_NAME),
      ),
    );
    _changeLoadingStatus();

    _prepareToNewFile();

    ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
      SnackBar(
        elevation: 10,
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.green,
        content: Text("Başarılı"),
      ),
    );
  }

  @action
  Future<void> getImageFile() async {
    _prepareToNewFile();
    _selectedImage = await ImagePickerService.instance.getImageFile();
    _updateSelectedImage(_selectedImage);
    if (_selectedImage != null) {
      scanImage();
    }
  }

  @observable
  bool isLoading = false;

  @observable
  String scannedText;

  @observable
  File image;

  @observable
  LocationModel locationModel;

  @action
  void _changeLoadingStatus() {
    isLoading = !isLoading;
  }

  @action
  void _updateScannedText(String producedText) {
    scannedText = producedText;
    editingController.text = scannedText;
  }

  @action
  void _updateSelectedImage(File selectedImage) {
    image = selectedImage;
  }

  @action
  void _prepareToNewFile() {
    image = null;
    scannedText = null;
    locationModel = null;
  }

  Future<void> scanImageOffline() async {
    if (_selectedImage != null) {
      _changeLoadingStatus();
      _producedText =
          await OcrService.instance.getTextFromImage(_selectedImage);
      _updateScannedText(_producedText);
      _changeLoadingStatus();
    }
  }

  Future _getPosition() async {
    try {
      final position = await LocationService.instance.determinePosition();
      if (position != null) {
        locationModel = LocationModel(
            latitude: position.longitude,
            longitude: position.longitude,
            altitude: position.altitude,
            heading: position.heading,
            speed: position.speed,
            speedAccuracy: position.speedAccuracy,
            timestamp: DateTime.now().toString(),
            floor: position.floor,
            isMocked: position.isMocked == true ? 1 : 0);
      }
    } catch (e) {
      print(e);
    }
  }

  logout() {
    //TODO: IMPLEMENT LOGOUT
  }
}
