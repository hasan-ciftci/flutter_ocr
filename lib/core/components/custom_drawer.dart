import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';

class CustomDrawer extends StatelessWidget {
  final IconData firstIconData;
  final String firstOptionName;
  final Function firstFunction;

  final IconData secondIconData;
  final String secondOptionName;
  final Function secondFunction;

  final Function logOutFunction;

  const CustomDrawer({
    Key key,
    @required this.firstFunction,
    @required this.logOutFunction,
    @required this.firstIconData,
    @required this.firstOptionName,
    this.secondIconData,
    this.secondOptionName,
    this.secondFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorConstants.ISPARK_WHITE,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildDrawerHeader(),
            buildFirstOption(),
            (secondFunction != null &&
                    secondOptionName != null &&
                    secondIconData != null)
                ? buildSecondOption()
                : SizedBox(),
            Divider(),
            buildLogoutOption(),
          ],
        ),
      ),
    );
  }

  ListTile buildLogoutOption() {
    return ListTile(
      trailing: Icon(
        Icons.arrow_right,
        color: ColorConstants.ISPARK_BLUE_DARK,
      ),
      leading: Icon(
        Icons.logout,
        color: ColorConstants.ISPARK_BLACK,
      ),
      title: Text(
        'Çıkış',
        textScaleFactor: 1.3,
        style: TextStyle(color: ColorConstants.ISPARK_BLUE_DARK),
      ),
      onTap: logOutFunction,
    );
  }

  ListTile buildFirstOption() {
    return ListTile(
      trailing: Icon(
        Icons.arrow_right,
        color: ColorConstants.ISPARK_BLUE_DARK,
      ),
      leading: Icon(
        firstIconData,
        color: ColorConstants.ISPARK_BLACK,
      ),
      title: Text(
        firstOptionName,
        textScaleFactor: 1.3,
        style: TextStyle(color: ColorConstants.ISPARK_BLUE_DARK),
      ),
      onTap: firstFunction,
    );
  }

  DrawerHeader buildDrawerHeader() {
    return DrawerHeader(
      child: Center(
          child: RichText(
        textScaleFactor: 2,
        text: TextSpan(children: [
          TextSpan(
              text: "İspark", style: TextStyle(fontWeight: FontWeight.w300)),
          TextSpan(
              text: "Scanner", style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
      )),
      decoration: BoxDecoration(
        color: ColorConstants.ISPARK_YELLOW,
      ),
    );
  }

  ListTile buildSecondOption() {
    return ListTile(
      trailing: Icon(
        Icons.arrow_right,
        color: ColorConstants.ISPARK_BLUE_DARK,
      ),
      leading: Icon(
        secondIconData,
        color: ColorConstants.ISPARK_BLACK,
      ),
      title: Text(
        secondOptionName,
        textScaleFactor: 1.5,
        style: TextStyle(color: ColorConstants.ISPARK_BLUE_DARK),
      ),
      onTap: secondFunction,
    );
  }
}
