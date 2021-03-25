import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static ImagePickerService _instance;

  static ImagePickerService get instance {
    _instance ??= ImagePickerService._init();
    return _instance;
  }

  ImagePickerService._init();

  Future<File> getImageFile() async {
    final _file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (_file != null) {
      return _file;
    }
    return null;
  }
}
