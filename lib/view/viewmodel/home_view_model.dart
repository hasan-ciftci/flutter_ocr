import 'dart:io';

import 'package:flutter_ocr/core/init/image%20picker/image_picker.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  String _producedText;
  File _selectedImage;

  @action
  Future<void> scanImage() async {
    _changeScanningStatuts();
    _producedText = await OcrService.instance.getTextFromImage(_selectedImage);
    _updateScannedText(_producedText);
    _changeScanningStatuts();
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
}
