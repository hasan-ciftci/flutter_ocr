import 'package:flutter/material.dart';

AppBar buildAppBar(
    {@required String appBarText,
    @required Color appBarTextColor,
    @required Color appBarColor}) {
  return AppBar(
    backgroundColor: appBarColor,
    centerTitle: true,
    title: Text(
      appBarText,
      style: TextStyle(color: appBarTextColor),
    ),
  );
}
