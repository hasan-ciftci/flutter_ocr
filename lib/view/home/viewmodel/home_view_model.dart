import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/model/position_model.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  String _producedText;
  File _selectedImage;
  String _selectedImageBase64;
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
      await scanImageOnline();
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
        timestamp: DateFormat('dd.MM.yyyy - HH:mm:ss')
            .format(DateTime.now())
            .toString(),
        base64Image: _selectedImageBase64,
        username: PreferencesManager.instance
            .getStringValue(PreferencesKeys.USER_NAME),
      ),
    );
    _changeLoadingStatus();

    prepareToNewFile();

    showSnackBar(status: SnackBarStatus.SUCCESS, message: "Kaydedildi");
  }

  @action
  Future<void> getImageFile() async {
    prepareToNewFile();
    XFile previewImage;
    try {
      await initializeControllerFuture;
      previewImage = await controller.takePicture();
    } catch (e) {
      print(e);
    }
    _selectedImage = File(previewImage.path);
    if (_selectedImage != null) {
      await convertImageToBase64(_selectedImage);
      scanImage();
    }
  }

  convertImageToBase64(File imageReadyToBeConverted) async {
    final bytes = await File(imageReadyToBeConverted.path).readAsBytes();
    _selectedImageBase64 = base64.encode(bytes);
  }

  @observable
  bool isLoading = false;
  @observable
  bool isScanning = false;

  @observable
  String scannedText;

  @observable
  LocationModel locationModel;

  @action
  void _changeLoadingStatus() {
    isLoading = !isLoading;
  }

  @action
  void _changeScanningStatus() {
    isScanning = !isScanning;
  }

  @action
  void _updateScannedText(String producedText) {
    scannedText = producedText;
    editingController.text = scannedText;
  }

  @action
  void prepareToNewFile() {
    scannedText = null;
    locationModel = null;
  }

  Future<void> scanImageOffline() async {
    if (_selectedImage != null) {
      _changeScanningStatus();
      _producedText =
          await OcrService.instance.getTextFromImage(_selectedImage);
      if (_producedText.isNotEmpty) {
        _updateScannedText(_producedText);
      } else {
        showSnackBar(
            status: SnackBarStatus.FAIL, message: "Plaka tanımlanamadı");
      }
      _changeScanningStatus();
    }
  }

  Future<void> scanImageOnline() async {
    if (_selectedImage != null) {
      _changeScanningStatus();
      await _getPosition();
      _producedText =
          await OcrService.instance.getTextFromImage(_selectedImage);
      if (_producedText.isNotEmpty) {
        _updateScannedText(_producedText);
      } else {
        showSnackBar(
            status: SnackBarStatus.FAIL, message: "Plaka tanımlanamadı");
      }
      _changeScanningStatus();
    }
  }

  Future _getPosition() async {
    try {
      final position = await LocationService.instance.determinePosition();
      if (position != null) {
        locationModel = LocationModel(
            latitude: position.latitude,
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

  showSnackBar({SnackBarStatus status, String message}) {
    ScaffoldMessenger.of(scaffoldState.currentContext).showSnackBar(
      SnackBar(
        elevation: 10,
        duration: Duration(milliseconds: 1500),
        backgroundColor:
            status == SnackBarStatus.SUCCESS ? Colors.green : Colors.red,
        content: Text(message),
      ),
    );
  }
}
