import 'package:flutter_ocr/core/base/base_model.dart';

class PlateImageGuidModel extends BaseModel {
  String guid;

  PlateImageGuidModel({this.guid});

  PlateImageGuidModel.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    PlateImageGuidModel.fromJson(json);
  }
}
