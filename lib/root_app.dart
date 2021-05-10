import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/view/home_view.dart';
import 'package:flutter_ocr/view/login/view/login_view.dart';

import 'core/constants/color_constants.dart';
import 'core/init/navigation/navigation_routes.dart';
import 'core/init/navigation/navigation_service.dart';

class IsparkScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreferencesManager.instance
              .getStringValue(PreferencesKeys.TOKEN)
              .isNotEmpty
          ? HomeView()
          : LoginView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoutes.instance.generateRoute,
      theme: ThemeData(
          primaryColor: ColorConstants.ISPARK_YELLOW,
          primaryColorLight: ColorConstants.ISPARK_YELLOW,
          primaryColorDark: ColorConstants.ISPARK_YELLOW),
    );
  }
}
