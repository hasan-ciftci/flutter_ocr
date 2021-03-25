import 'dart:io';

import 'package:camera/camera.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/constants/preferences_keys.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/model/position_model.dart';
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

  DatabaseService recordDataBaseProvider;

  CameraController controller;
  Future<void> initializeControllerFuture;

  init() {
    editingController = TextEditingController();
    focusNode = FocusNode();
    recordDataBaseProvider = DatabaseService.instance;
    recordDataBaseProvider.open();
    controller = CameraController(
        CameraDescription(
            name: "0",
            lensDirection: CameraLensDirection.back,
            sensorOrientation: 90),
        ResolutionPreset.medium);
    initializeControllerFuture = controller.initialize();
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
        timestamp: DateTime.now().toString(),
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
    XFile previewImage;
    try {
      await initializeControllerFuture;
      previewImage = await controller.takePicture();
    } catch (e) {
      print(e);
    }
    _selectedImage = File(previewImage.path);
    if (_selectedImage != null) {
      scanImage();
    }
  }

  @observable
  bool isLoading = false;

  @observable
  String scannedText;

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
  void _prepareToNewFile() {
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
            floor: position.floor,
            isMocked: position.isMocked == true ? 1 : 0);
      }
    } catch (e) {
      print(e);
    }
  }

  navigateToRecordsPage() {
    NavigationService.instance
        .navigateToPage(path: NavigationConstants.RECORDS_VIEW);
  }

  logout() {
    //TODO: IMPLEMENT LOGOUT
  }
}
