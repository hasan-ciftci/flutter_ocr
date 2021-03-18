import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color buttonColor;

  const CustomElevatedButton(
      {Key key,
      @required this.onPressed,
      @required this.buttonText,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return Colors.green;
            return buttonColor ?? Colors.blue;
          },
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
