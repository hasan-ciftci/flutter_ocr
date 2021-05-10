import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: ColorConstants.ISPARK_YELLOW,
    centerTitle: true,
    title: Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.contain,
      height: 50,
    ),
  );
}
