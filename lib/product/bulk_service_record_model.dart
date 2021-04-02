import 'package:flutter_ocr/view/home/model/record_model.dart';

class BulkServiceRecordModel {
  List<RecordModel> recordModel;

  BulkServiceRecordModel(this.recordModel);

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>();
    if (this.recordModel != null) {
      data = this.recordModel.map((v) => v.toJson()).toList();
    }
    return data;
  }

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      recordModel = new List<RecordModel>();
      json['data'].forEach((v) {
        recordModel.add(new RecordModel.fromJson(v));
      });
    }
  }
}
