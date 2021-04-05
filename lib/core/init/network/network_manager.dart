import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/base/base_model.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static NetworkManager get instance => _instance;
  Dio _dio;

  NetworkManager._internal() {
    BaseOptions baseOptions = BaseOptions(headers: {
      "Authorization": "Bearer " +
          PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN)
    });
    _dio = Dio(baseOptions);
  }

  Future dioPost<T extends BaseModel>(
      {@required String baseURL,
      @required String endPoint,
      @required T model}) async {
    final response = await _dio.post(baseURL + endPoint, data: model.toJson());
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
    final response = await _dio.get(
      baseURL + endPoint,
      queryParameters: model.toJson(),
    );
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
    final response = await _dio.post(
      baseURL + endPoint,
      data: file,
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }
}
