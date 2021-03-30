import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/base/base_model.dart';

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
    final response =
        await _dio.get(baseURL + endPoint, queryParameters: model.toJson());
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }

  Future dioPostImage<T extends FormData>(
      {@required String baseURL,
      @required String endPoint,
      @required T file}) async {
    final response = await _dio.post(baseURL + endPoint, data: file);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        return responseBody;
      default:
    }
  }
}
