import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/route_not_found_widget.dart';
import 'package:flutter_ocr/core/constants/navigation_root_name_constants.dart';
import 'package:flutter_ocr/view/login/view/login_view.dart';
import 'package:flutter_ocr/view/records/view/records_view.dart';
import 'package:flutter_ocr/view/singlerecord/view/singlerecord_view.dart';

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
      case NavigationConstants.RECORDS_VIEW:
        return normalNavigate(
          RecordsView(),
        );
      //GETS ID VALUE FROM SELECTED CARD ON RECORDS VIEW
      //ID USING FOR QUERY LOCAL DB TO GET DETAILS OF RECORD
      case NavigationConstants.SINGLE_RECORD_VIEW:
        return normalNavigate(SingleRecordView(), arguments: args);
      default:
        return normalNavigate(
          RouteNotFoundWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, {RouteSettings arguments}) {
    return MaterialPageRoute(builder: (context) => widget, settings: arguments);
  }
}
