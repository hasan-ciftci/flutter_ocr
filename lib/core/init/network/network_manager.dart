import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/base/base_model.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';

class NetworkManager {
  static NetworkManager _instance;

  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  Dio _dio;

  NetworkManager._init() {
    _dio = Dio();
  }

  Future dioPost<T extends BaseModel>(
      {@required String baseURL,
      @required String endPoint,
      @required T model}) async {
    final response = await _dio.post(baseURL + endPoint,
        data: model.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer " +
              PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN)
        }));
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }

  Future dioGet<T extends BaseModel>(
      {@required String baseURL,
      @required String endPoint,
      @required T model}) async {
    var myToken =
        PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN);
    final response = await _dio.get(baseURL + endPoint,
        queryParameters: model.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer " +
              PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN)
        }));
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }

  Future dioPostForm<T extends FormData>(
      {@required String baseURL,
      @required String endPoint,
      @required T file}) async {
    final response = await _dio.post(baseURL + endPoint,
        data: file,
        options: Options(headers: {
          "Authorization": "Bearer " +
              PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN)
        }));
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }
}
