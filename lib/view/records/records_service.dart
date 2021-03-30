import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/product/models/request/pagination_data_model.dart';

class RecordsService {
  fetchRecords(int page, int length) async {
    PaginationDataModel paginationDataModel =
        PaginationDataModel(page: page, limit: 10);

    final response = await NetworkManager.instance.dioGet<PaginationDataModel>(
        baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
        endPoint: ApiConstants.GET_RECORDS_ENDPOINT,
        model: paginationDataModel);

    return response;
  }
}
