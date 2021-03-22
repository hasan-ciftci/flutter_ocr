import 'package:flutter_ocr/view/login/model/user_model.dart';

abstract class ILoginService {
  Future loginUser(User model);
}
