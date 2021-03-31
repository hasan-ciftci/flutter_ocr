import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/enums.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/view/home_view.dart';
import 'package:flutter_ocr/view/login/view/login_view.dart';

import 'core/init/navigation/navigation_routes.dart';
import 'core/init/navigation/navigation_service.dart';

class FlutterOcr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreferencesManager.instance.getStringValue(PreferencesKeys.TOKEN) !=
              null
          ? HomeView()
          : LoginView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoutes.instance.generateRoute,
    );
  }
}
