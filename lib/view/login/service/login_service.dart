import 'package:flutter_ocr/core/constants/api_constants.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/navigation/navigation_service.dart';
import 'package:flutter_ocr/core/init/network/network_manager.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/login/model/login_response_model.dart';
import 'package:flutter_ocr/view/login/model/user_model.dart';

import 'ILoginService.dart';

class LoginService implements ILoginService {
  @override
  Future loginUser(User model) async {
    final loginResponse = await NetworkManager.instance.dioPost(
        endPoint: ApiConstants.LOGIN_ENDPOINT,
        model: model,
        baseURL: ApiConstants.LOGIN_BASE_URL);

    LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(loginResponse);

    print(loginResponseModel.toJson());
    if (loginResponseModel.data?.accessToken != null) {
      final token = loginResponseModel.data.accessToken;
      await saveTokenToPreferences(token);

      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.HOME_VIEW);
    }

    //TODO: CREATE MOCK DATA FOR SAVING PLATE PROCESS
    PreferencesManager.instance
        .setStringValue(PreferencesKeys.USER_NAME, model.username);
  }

  saveTokenToPreferences(String token) async {
    await PreferencesManager.instance
        .setStringValue(PreferencesKeys.TOKEN, token);
  }
}
