import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/base/base_model.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static NetworkManager get instance => _instance;
  Dio _dio;

  NetworkManager._internal() {
    _dio = Dio();
  }

  Future dioPost<T extends BaseModel>(
      {@required String baseURL,
      @required String endPoint,
      @required T model}) async {
    try {
      final response = await _dio.post(baseURL + endPoint,
          data: model.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer " +
                PreferencesManager.instance
                    .getStringValue(PreferencesKeys.TOKEN)
          }));
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        default:
      }
    } catch (e) {
      if (e is DioError) {
        checkAuthenticationEnded(e);
      }
    }
  }

  Future dioGet<T extends BaseModel>(
      {@required String baseURL,
      @required String endPoint,
      @required T model}) async {
    try {
      final response = await _dio.get(baseURL + endPoint,
          queryParameters: model.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer " +
                PreferencesManager.instance
                    .getStringValue(PreferencesKeys.TOKEN)
          }));
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        default:
      }
    } catch (e) {
      if (e is DioError) {
        checkAuthenticationEnded(e);
      }
    }
  }

  Future dioPostForm<T extends FormData>(
      {@required String baseURL,
      @required String endPoint,
      @required T file}) async {
    try {
      final response = await _dio.post(baseURL + endPoint,
          data: file,
          options: Options(headers: {
            "Authorization": "Bearer " +
                PreferencesManager.instance
                    .getStringValue(PreferencesKeys.TOKEN)
          }));
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        default:
      }
    } catch (e) {
      if (e is DioError) {
        checkAuthenticationEnded(e);
      }
    }
  }
}

checkAuthenticationEnded(DioError e) {
  if (e.error.toString().contains("401")) {
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);

    PreferencesManager.instance.clearAll();
  }
}
