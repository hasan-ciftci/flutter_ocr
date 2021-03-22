import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/constants/color_constants.dart';

class RectangleTextFormField extends StatelessWidget {
  final String hintText;
  final bool isObscure;

  const RectangleTextFormField({
    Key key,
    @required this.hintText,
    @required this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.ISPARK_BLACK),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
