import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/product/models/response/scan_response_model.dart';

class OcrService {
  static OcrService _instance;

  TextRecognizer textRecognizer;

  static OcrService get instance {
    _instance ??= OcrService._init();
    return _instance;
  }

  OcrService._init() {
    textRecognizer = FirebaseVision.instance.textRecognizer();
  }

  Future<String> getTextFromImageOffline(File imageFile) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    return visionText.text ?? "";
  }

  Future<ScanResponseModel> getTextFromImageOnline(File imageFile) async {
    FormData formData = FormData.fromMap(
        {'Image': await MultipartFile.fromFile(imageFile.path)});

    var scanResponse = await NetworkManager.instance.dioPostForm(
      endPoint: ApiConstants.SCAN_ENDPOINT,
      baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
      file: formData,
    );
    ScanResponseModel scanResponseModel =
        ScanResponseModel.fromJson(scanResponse);
    return scanResponseModel;
  }
}
