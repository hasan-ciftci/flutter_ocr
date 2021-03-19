import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_ocr/core/init/image%20picker/image_picker.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:flutter_ocr/view/home/model/position_model.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  String _producedText;
  File _selectedImage;

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
  Future<void> getImageFile() async {
    _prepareToNewFile();
    _selectedImage = await ImagePickerService.instance.getImageFile();
    _updateSelectedImage(_selectedImage);
  }

  @observable
  bool isScanning = false;

  @observable
  String scannedText = "";

  @observable
  File image;

  @observable
  LocationModel locationModel;

  @action
  void _changeScanningStatuts() {
    isScanning = !isScanning;
  }

  @action
  void _updateScannedText(String producedText) {
    scannedText = producedText;
  }

  @action
  void _updateSelectedImage(File selectedImage) {
    image = selectedImage;
  }

  @action
  void _prepareToNewFile() {
    image = null;
    scannedText = null;
  }

  Future<void> scanImageOffline() async {
    if (_selectedImage != null) {
      _changeScanningStatuts();
      _producedText =
          await OcrService.instance.getTextFromImage(_selectedImage);
      _updateScannedText(_producedText);
      _changeScanningStatuts();
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
            timestamp: position.timestamp,
            floor: position.floor,
            isMocked: position.isMocked);
      }
    } catch (e) {
      print(e);
    }
  }
}
