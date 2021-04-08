import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/product/models/pagination_data_model.dart';

class RecordsService {
  //fetch records with implementing pagination
  fetchRecords(
      {@required int paginationPage, @required int quantityOfData}) async {
    PaginationDataModel paginationDataModel =
        PaginationDataModel(page: paginationPage, limit: quantityOfData);
    String username =
        PreferencesManager.instance.getStringValue(PreferencesKeys.USER_NAME);

    final response = await NetworkManager.instance.dioGet<PaginationDataModel>(
        baseURL: ApiConstants.OCR_ENGINE_BASE_URL,
        endPoint: ApiConstants.GET_RECORDS_ENDPOINT + username,
        model: paginationDataModel);

    return response;
  }
}
