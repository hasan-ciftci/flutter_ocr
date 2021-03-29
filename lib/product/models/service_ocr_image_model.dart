import 'package:flutter_ocr/product/models/pagination_model.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';

class GetRecordModel {
  PaginationMetaData paginationMetaData;
  List<ServiceRecordModel> data;
  bool result;
  String message;
  int httpStatusCode;
  String exceptionCode;

  GetRecordModel(
      {this.paginationMetaData,
      this.data,
      this.result,
      this.message,
      this.httpStatusCode,
      this.exceptionCode});

  GetRecordModel.fromJson(Map<String, dynamic> json) {
    paginationMetaData = json['paginationMetaData'] != null
        ? new PaginationMetaData.fromJson(json['paginationMetaData'])
        : null;
    if (json['data'] != null) {
      data = new List<ServiceRecordModel>();
      json['data'].forEach((v) {
        data.add(new ServiceRecordModel.fromJson(v));
      });
    }
    result = json['result'];
    message = json['message'];
    httpStatusCode = json['httpStatusCode'];
    exceptionCode = json['exceptionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paginationMetaData != null) {
      data['paginationMetaData'] = this.paginationMetaData.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    data['httpStatusCode'] = this.httpStatusCode;
    data['exceptionCode'] = this.exceptionCode;
    return data;
  }
}
