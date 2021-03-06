import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';

class RecordCard extends StatelessWidget {
  final String plate;
  final String date;
  final int id;
  final Function onPressed;

  const RecordCard(
      {Key key,
      @required this.plate,
      @required this.date,
      @required this.id,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(boxShadow: StyleConstants.kBoxShadow),
          child: ListTile(
            tileColor: Colors.white,
            isThreeLine: false,
            title: buildPlateText(),
            subtitle: buildDateText(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorConstants.ISPARK_YELLOW,
            ),
          ),
        ));
  }

  Text buildId() {
    return Text(
      id.toString() + ".",
      textAlign: TextAlign.center,
      style: TextStyle(
          shadows: StyleConstants.kTextDoubleShadow,
          color: ColorConstants.ISPARK_BLUE_DARK),
    );
  }

  Column buildDateColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDateHeader(),
        buildDateText(),
      ],
    );
  }

  Text buildDateText() {
    return Text(
      date,
      style: TextStyle(
          color: ColorConstants.ISPARK_BLACK,
          fontWeight: FontWeight.bold,
          fontSize: 16),
    );
  }

  Text buildDateHeader() {
    return Text(
      "Tarih",
      style: TextStyle(
          shadows: StyleConstants.kTextSingleShadow,
          color: ColorConstants.ISPARK_WHITE,
          fontSize: 18),
    );
  }

  Text buildPlateText() {
    return Text(
      plate,
      style: TextStyle(
          color: ColorConstants.ISPARK_BLUE,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}
