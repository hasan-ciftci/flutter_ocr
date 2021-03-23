import 'package:flutter_ocr/view/home/model/position_model.dart';

import '../../../core/init/database/database_model.dart';

class RecordModel extends DatabaseModel<RecordModel> {
  LocationModel location;
  String username;
  String plate;

  RecordModel({this.location, this.username, this.plate});

  RecordModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
    username = json['username'];
    plate = json['plate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['username'] = this.username;
    data['plate'] = this.plate;
    return data;
  }

  @override
  RecordModel fromJson(Map<String, dynamic> json) {
    return RecordModel.fromJson(json);
  }
}
