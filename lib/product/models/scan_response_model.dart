import 'package:flutter_ocr/product/models/pagination_model.dart';

class ScanResponseModel {
  PaginationMetaData paginationMetaData;
  Data data;
  bool result;
  String message;
  String httpStatusCode;
  String exceptionCode;

  ScanResponseModel(
      {this.paginationMetaData,
      this.data,
      this.result,
      this.message,
      this.httpStatusCode,
      this.exceptionCode});

  ScanResponseModel.fromJson(Map<String, dynamic> json) {
    paginationMetaData = json['paginationMetaData'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    result = json['result'];
    message = json['message'];
    httpStatusCode = json['httpStatusCode'];
    exceptionCode = json['exceptionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paginationMetaData'] = this.paginationMetaData;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    data['httpStatusCode'] = this.httpStatusCode;
    data['exceptionCode'] = this.exceptionCode;
    return data;
  }
}

class Data {
  String licensePlate;
  String licensePlateImage;

  Data({this.licensePlate, this.licensePlateImage});

  Data.fromJson(Map<String, dynamic> json) {
    licensePlate = json['licensePlate'];
    licensePlateImage = json['licensePlateImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['licensePlate'] = this.licensePlate;
    data['licensePlateImage'] = this.licensePlateImage;
    return data;
  }
}
