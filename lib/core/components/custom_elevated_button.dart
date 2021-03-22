import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final IconData icon;

  const CustomElevatedButton(
      {Key key,
      @required this.onPressed,
      @required this.buttonText,
      this.buttonColor,
      this.buttonTextColor,
      this.icon})
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon) : SizedBox(),
          SizedBox(
            width: 10,
          ),
          Text(
            buttonText,
            style: TextStyle(
                color: buttonTextColor ?? Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
