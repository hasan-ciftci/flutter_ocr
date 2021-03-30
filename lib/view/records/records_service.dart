import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/product/models/request/pagination_data_model.dart';

class RecordsService {
  fetchRecords(
      {@required int paginationPage, @required int quantityOfData}) async {
    PaginationDataModel paginationDataModel =
        PaginationDataModel(page: paginationPage, limit: quantityOfData);

    final response = await NetworkManager.instance.dioGet<PaginationDataModel>(
        baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
        endPoint: ApiConstants.GET_RECORDS_ENDPOINT,
        model: paginationDataModel);

    return response;
  }
}
