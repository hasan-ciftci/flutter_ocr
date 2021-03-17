class OcrService {
  static OcrService _instance;

  static OcrService get instance {
    _instance ??= OcrService._init();
    return _instance;
  }

  OcrService._init();

  Future<String> getTextFromImage(file) async {}
}
