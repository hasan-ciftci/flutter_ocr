class ApiConstants {
  static const LOGIN_BASE_URL =
      'https://parxlab-ocr-engine-user-service-dev.azurewebsites.net/';
  static const LOGIN_ENDPOINT = 'api/v1/User/Login';

  static const OCR_ENGINE_BASE_URL =
      'https://parxlab-ocr-engine-root-service-dev.azurewebsites.net/';
  static const SCAN_ENDPOINT = 'api/v1/OCREngine/GetImageOCRRecognizer';
  static const ADD_RECORD_ENDPOINT = 'api/v1/History/AddHistory';
  static const GET_RECORDS_ENDPOINT = 'api/v1/History/GetHistory';
}
