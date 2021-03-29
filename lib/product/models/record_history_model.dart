import 'package:flutter_ocr/product/models/pagination_model.dart';
import 'package:flutter_ocr/product/models/service_record_model.dart';

class RecordHistoryModel {
  PaginationMetaData paginationMetaData;
  ServiceRecordModel data;
  bool result;
  String message;
  int httpStatusCode;
  String exceptionCode;

  RecordHistoryModel(
      {this.paginationMetaData,
      this.data,
      this.result,
      this.message,
      this.httpStatusCode,
      this.exceptionCode});

  RecordHistoryModel.fromJson(Map<String, dynamic> json) {
    paginationMetaData = json['paginationMetaData'] != null
        ? new PaginationMetaData.fromJson(json['paginationMetaData'])
        : null;
    data = json['data'] != null
        ? new ServiceRecordModel.fromJson(json['data'])
        : null;
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
      data['data'] = this.data.toJson();
    }
    data['result'] = this.result;
    data['message'] = this.message;
    data['httpStatusCode'] = this.httpStatusCode;
    data['exceptionCode'] = this.exceptionCode;
    return data;
  }
}
