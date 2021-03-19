import 'package:flutter/material.dart';
import 'package:flutter_ocr/view/login/view/login_view.dart';

import 'core/init/navigation/navigation_routes.dart';
import 'core/init/navigation/navigation_service.dart';

void main() {
  runApp(FlutterOcr());
}

class FlutterOcr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoutes.instance.generateRoute,
    );
  }
}
