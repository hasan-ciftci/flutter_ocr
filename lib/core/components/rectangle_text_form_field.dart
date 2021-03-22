import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

class RectangleTextFormField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final TextEditingController controller;

  const RectangleTextFormField({
    Key key,
    @required this.hintText,
    @required this.isObscure,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
