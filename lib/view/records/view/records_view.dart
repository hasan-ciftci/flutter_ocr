import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/record_card.dart';
import 'package:flutter_ocr/core/constants/app_constants.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/preferences_keys.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/view/home/model/record_database_provider.dart';

class RecordsView extends StatefulWidget {
  @override
  _RecordsViewState createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  RecordDataBaseProvider recordDataBaseProvider;

  @override
  void initState() {
    super.initState();
    recordDataBaseProvider = RecordDataBaseProvider();
  }

  getLicensePlates() async {
    //TODO:PUSH RECORDS PAGE
    final result = await recordDataBaseProvider.getRecordList(
        PreferencesManager.instance.getStringValue(PreferencesKeys.USER_NAME));
    result.forEach((element) {
      print(element.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: StyleConstants.kYellowLinearGradient),
      child: Scaffold(
        appBar: buildAppBar(
            appBarText: ApplicationConstants.COMPANY_NAME,
            appBarTextColor: ColorConstants.ISPARK_YELLOW_DARK,
            appBarColor: ColorConstants.ISPARK_BLACK),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RecordCard(
                      plate: '35 IZMIR 35',
                      date: '09.09.2021',
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
