import 'package:flutter/material.dart';

import 'color_constants.dart';

class StyleConstants {
  static const LinearGradient kYellowLinearGradient = LinearGradient(
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

  static final BoxDecoration kRecordCardDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    color: ColorConstants.ISPARK_YELLOW_DARK,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: ColorConstants.ISPARK_BLUE),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, -2), // changes position of shadow
      ),
    ],
  );

  static const kTextDoubleShadow = <Shadow>[
    Shadow(
      offset: Offset(2.0, 0.0),
      blurRadius: 3.0,
      color: Colors.white,
    ),
    Shadow(
      offset: Offset(0.0, 5.0),
      blurRadius: 8.0,
      color: Colors.black38,
    ),
  ];
  static const kTextSingleShadow = <Shadow>[
    Shadow(
      offset: Offset(0.0, 5.0),
      blurRadius: 8.0,
      color: Colors.black38,
    ),
  ];

  static final kBoxShadow = <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      spreadRadius: 1,
      blurRadius: 5,
      offset: Offset(0, 3), // changes position of shadow
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 4,
      offset: Offset(0, -2), // changes position of shadow
    ),
  ];
}
