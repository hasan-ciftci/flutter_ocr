import 'package:flutter_ocr/product/models/pagination_model.dart';

class LoginResponseModel {
  PaginationMetaData paginationMetaData;
  Data data;
  bool result;
  String message;
  int httpStatusCode;
  String exceptionCode;

  LoginResponseModel(
      {this.paginationMetaData,
      this.data,
      this.result,
      this.message,
      this.httpStatusCode,
      this.exceptionCode});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    paginationMetaData != null
        ? new PaginationMetaData.fromJson(json['paginationMetaData'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    result = json['result'];
    message = json['message'];
    httpStatusCode = json['httpStatusCode'];
    exceptionCode = json['exceptionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final Map<String, dynamic> paginationMetaData = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.paginationMetaData != null) {
      data['paginationMetaData'] = this.paginationMetaData.toJson();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    data['httpStatusCode'] = this.httpStatusCode;
    data['exceptionCode'] = this.exceptionCode;
    return data;
  }
}

class Data {
  String tokenType;
  String accessToken;
  int expiresIn;

  Data({this.tokenType, this.accessToken, this.expiresIn});

  Data.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
