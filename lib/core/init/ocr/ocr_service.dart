import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

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
}
