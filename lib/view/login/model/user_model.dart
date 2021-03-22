import 'package:flutter_ocr/core/base/base_model.dart';

class User implements BaseModel {
  String username;
  String password;

  User({this.username, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
