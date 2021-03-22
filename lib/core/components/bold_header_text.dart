import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

class BoldHeaderText extends StatelessWidget {
  final String text;
  const BoldHeaderText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: ColorConstants.ISPARK_BLACK,
          fontSize: 17,
          fontWeight: FontWeight.bold),
    );
  }
}
