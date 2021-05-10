import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isObscure;
  final TextEditingController controller;

  const CustomTextFormField({
    Key key,
    @required this.hintText,
    @required this.isObscure,
    @required this.labelText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.ISPARK_BLACK),
      ),
    );
  }
}
