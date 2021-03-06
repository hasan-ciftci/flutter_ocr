import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/database/database_service.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/product/models/scan_response_model.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';
import 'package:flutter_ocr/product/notifiers/connection_notifier.dart';
import 'package:flutter_ocr/view/home/model/position_model.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:flutter_ocr/view/home/service/home_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  BuildContext myContext;

  setContext(BuildContext ctx) {
    myContext = ctx;
  }

  String _producedText;
  @observable
  File selectedImage;
  String _selectedImageBase64;

  ///Periodically(30 secs.) updated Position
  Position myPosition;
  TextEditingController editingController;
  FocusNode focusNode;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  DatabaseService recordDataBaseProvider;

  ///Service for API methods
  HomeService _homeService;

  CameraController controller;
  Future<void> initializeControllerFuture;
  ScanResponseModel _onlineScanResponseModel;

  ///Status of if record is saving
  @observable
  bool isLoading = false;

  ///Status of if image is scanning
  @observable
  bool isScanning = false;

  ///Edited final text to ready to send API
  @observable
  String scannedText;

  ///If location services available contains location informations
  @observable
  LocationModel locationModel;

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
        ResolutionPreset.high);
    initializeControllerFuture = controller.initialize();
    _homeService = HomeService();
    myPosition = LocationService.position;
    renewPositionIn30Seconds();
  }

  @action
  Future<void> scanImage() async {
    ConnectivityResult result =
        myContext.read<ConnectionNotifier>().connectivityResult;
    if (result != ConnectivityResult.none) {
      await scanImageOnline();
    } else {
      await scanImageOffline();
    }
  }

  @action
  void updateEditableText(value) {
    scannedText = value;
  }

  //If wifi/data connection exists work with API otherwise work with LocalDb
  Future<void> saveLicensePlate() async {
    ConnectivityResult result =
        myContext.read<ConnectionNotifier>().connectivityResult;
    if (result != ConnectivityResult.none) {
      saveLicensePlateOnline();
    } else {
      await saveLicensePlateOffline();
    }
  }

  void saveLicensePlateOnline() async {
    _changeLoadingStatus();
    try {
      ServiceRecordModel serviceRecordModel = ServiceRecordModel(
        licensePlateImage: _onlineScanResponseModel.data.licensePlateImage,
        location: "${locationModel?.latitude},${locationModel?.longitude}",
        Username: PreferencesManager.instance
            .getStringValue(PreferencesKeys.USER_NAME),
        licensePlate: scannedText,
        id: 0,
        status: 1,
        createdOn: DateTime.now().toIso8601String(),
        createdBy: 0,
      );

      await _homeService.saveLicensePlateOnline(serviceRecordModel);
      showSnackBar(status: SnackBarStatus.SUCCESS, message: "Kaydedildi");
    } catch (e) {
      showSnackBar(status: SnackBarStatus.FAIL, message: "Server hatas??");
    }

    _changeLoadingStatus();
    prepareToNewFile();
  }

  Future<void> saveLicensePlateOffline() async {
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
    selectedImage = File(previewImage.path);
    if (selectedImage != null) {
      await convertImageToBase64(selectedImage);
      scanImage();
    }
  }

  convertImageToBase64(File imageReadyToBeConverted) async {
    final bytes = await File(imageReadyToBeConverted.path).readAsBytes();
    _selectedImageBase64 = base64.encode(bytes);
  }

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
    selectedImage = null;
  }

  applyRegexToScannedText() {
    try {
      String oneLinePlate = _producedText.replaceAll("\n", " ");
      oneLinePlate = _producedText.replaceAll(RegExp(r"\s{2,}"), "");
      RegExp plateExp = RegExp(
          r"((\d{2}\s[A-Z]{1,6}\s[0-9]{1,6})|(\d{2}\s[A-Z]{1,6}[0-9]{1,6})|(\d{2}[A-Z]{1,6}\s[0-9]{1,6})|(\d{2}[A-Z]{1,6}[0-9]{1,6}))");
      var match = plateExp.firstMatch(oneLinePlate);
      if (match != null) {
        _producedText = match[0];
      }
    } catch (e) {
      print(e.toSring());
    }
  }

  Future<void> scanImageOffline() async {
    if (selectedImage != null) {
      selectedImage = await FlutterNativeImage.compressImage(selectedImage.path,
          quality: 20);
      _changeScanningStatus();
      _producedText =
          await OcrService.instance.getTextFromImageOffline(selectedImage);
      if (_producedText.isNotEmpty) {
        applyRegexToScannedText();
        _updateScannedText(_producedText);
      } else {
        selectedImage = null;
        showSnackBar(
            status: SnackBarStatus.FAIL, message: "Plaka tan??mlanamad??");
      }
      _changeScanningStatus();
    }
  }

  Future<ScanResponseModel> getTextFromImageOnline(File imageFile) async {
    FormData formData = FormData.fromMap(
        {'Image': await MultipartFile.fromFile(imageFile.path)});
    var scanResponse = await _homeService.scanTextOnline(formData);
    ScanResponseModel scanResponseModel =
        ScanResponseModel.fromJson(scanResponse);
    return scanResponseModel;
  }

  Future<void> scanImageOnline() async {
    _changeScanningStatus();
    try {
      if (selectedImage != null) {
        selectedImage = await FlutterNativeImage.compressImage(
            selectedImage.path,
            quality: 20);

        try {
          await _getPosition();
        } catch (e) {
          print(e);
        }
        _onlineScanResponseModel = await getTextFromImageOnline(selectedImage);
        if (_onlineScanResponseModel.data.licensePlate.isNotEmpty) {
          _producedText = _onlineScanResponseModel.data.licensePlate;
          _updateScannedText(_producedText);
        } else {
          selectedImage = null;
          showSnackBar(
              status: SnackBarStatus.FAIL, message: "Plaka tan??mlanamad??");
        }
      }
    } catch (e) {
      print(e);
      if (e
          .toString()
          .contains("The getter 'licensePlate' was called on null.")) {
        showSnackBar(
            status: SnackBarStatus.FAIL, message: "Plaka tan??mlanamad??");
      } else {
        showSnackBar(status: SnackBarStatus.FAIL, message: "Servis hatas??");
      }

      prepareToNewFile();
    }
    _changeScanningStatus();
  }

  ///If [myPosition] not null
  ///returns a [LocationModel] created with [myPosition]
  Future _getPosition() async {
    var position;
    try {
      if (myPosition != null) {
        position = myPosition;
      } else {
        try {
          await LocationService.instance.determinePosition();
        } catch (e) {
          print(e);
          showSnackBar(
              status: SnackBarStatus.FAIL,
              message: "Konum servisine ula????lam??yor");
        }
      }

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
    PreferencesManager.instance.clearAll();
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
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

  void renewPositionIn30Seconds() {
    Timer.periodic(
        Duration(seconds: 30),
        (Timer t) async =>
            myPosition = await LocationService.instance.determinePosition());
  }
}
