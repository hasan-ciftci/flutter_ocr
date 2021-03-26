import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/login/model/user_model.dart';

import '../../../core/init/navigation/navigation_service.dart';
import 'ILoginService.dart';

class LoginService implements ILoginService {
  @override
  Future loginUser(User model) async {
    //TODO: WAITING FOR SERVICE API TO BE READY
    /*
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
    */
    //TODO: CREATE MOCK DATA FOR SAVING PLATE PROCESS
    PreferencesManager.instance
        .setStringValue(PreferencesKeys.USER_NAME, model.username);

    NavigationService.instance
        .navigateToPage(path: NavigationConstants.HOME_VIEW);
  }

  saveTokenToPreferences(String token) async {
    await PreferencesManager.instance
        .setStringValue(PreferencesKeys.TOKEN, token);
  }
}
