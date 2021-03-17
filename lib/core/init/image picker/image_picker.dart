import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static ImagePickerService _instance;
  ImagePicker _picker;

  static ImagePickerService get instance {
    _instance ??= ImagePickerService._init();
    return _instance;
  }

  ImagePickerService._init() {
    _picker = ImagePicker();
  }

  Future getImageFile() async {
    final _file = await _picker.getImage(source: ImageSource.gallery);
    if (_file != null) {
      return _file;
    }
  }
}
