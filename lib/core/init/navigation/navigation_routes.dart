import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/route_not_found_widget.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/view/login/view/login_view.dart';

import '../../../view/home/view/home_view.dart';

class NavigationRoutes {
  static NavigationRoutes _instance = NavigationRoutes._init();

  static NavigationRoutes get instance => _instance;

  NavigationRoutes._init();

  Route<dynamic> generateRoute(args) {
    switch (args.name) {
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(
          LoginView(),
        );
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(
          HomeView(),
        );
      default:
        return normalNavigate(
          RouteNotFoundWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
