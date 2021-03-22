import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/constants/preferences_keys.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/login/model/login_response_model.dart';
import 'package:flutter_ocr/view/login/model/user_model.dart';

import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/init/network/network_manager.dart';
import 'ILoginService.dart';

class LoginService implements ILoginService {
  @override
  Future loginUser(User model) async {
    final loginResponse = await NetworkManager.instance
        .dioPost(ApiConstants.LOGIN_ENDPOINT, model);

    LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(loginResponse);

    if (loginResponseModel.data?.accessToken != null) {
      final token = loginResponseModel.data.accessToken;
      await saveTokenToPreferences(token);
      NavigationService.instance
          .navigateToPage(path: NavigationConstants.HOME_VIEW);
    }
  }

  saveTokenToPreferences(String token) async {
    await PreferencesManager.instance
        .setStringValue(PreferencesKeys.TOKEN, token);
  }
}
