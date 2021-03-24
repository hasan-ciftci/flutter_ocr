import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';

class RecordCard extends StatelessWidget {
  final String plate;
  final String date;

  const RecordCard({
    Key key,
    @required this.plate,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: StyleConstants.kRecordCardDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: buildPlateText(),
          ),
          Expanded(
            flex: 3,
            child: buildDateColumn(),
          ),
        ],
      ),
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
      textAlign: TextAlign.center,
      style: TextStyle(
          shadows: StyleConstants.kTextDoubleShadow,
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
      textAlign: TextAlign.center,
      style: TextStyle(
          shadows: StyleConstants.kTextDoubleShadow,
          color: ColorConstants.ISPARK_BLUE,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}
