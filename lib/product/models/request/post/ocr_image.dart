import 'package:flutter_ocr/core/base/base_model.dart';

class OcrImage extends BaseModel {
  String image;

  OcrImage({this.image});

  OcrImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return OcrImage.fromJson(json);
  }
}
