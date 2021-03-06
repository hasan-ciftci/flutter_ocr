import 'package:dio/dio.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';

class HomeService {
  ///Send post request to API save [ServiceRecordModel]
  saveLicensePlateOnline(ServiceRecordModel serviceRecordModel) {
    NetworkManager.instance.dioPost<ServiceRecordModel>(
        baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
        endPoint: ApiConstants.ADD_RECORD_ENDPOINT,
        model: serviceRecordModel);
  }

  ///Send image as [FormData] to API for scanning text
  scanTextOnline(FormData formData) {
    return NetworkManager.instance.dioPostForm(
      endPoint: ApiConstants.SCAN_ENDPOINT,
      baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
      file: formData,
    );
  }
}
