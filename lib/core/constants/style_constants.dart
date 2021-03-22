import 'package:flutter/material.dart';

import 'color_constants.dart';

class StyleConstants {
  static const kYellowLinearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.1,
        0.7,
        0.9
      ],
      colors: [
        ColorConstants.ISPARK_YELLOW_LIGHT,
        ColorConstants.ISPARK_YELLOW,
        ColorConstants.ISPARK_YELLOW_DARK,
      ]);
}
