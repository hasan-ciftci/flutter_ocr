import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/record_card.dart';
import 'package:flutter_ocr/core/constants/app_constants.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';

import '../viewmodel/records_view_model.dart';

class RecordsView extends StatefulWidget {
  @override
  _RecordsViewState createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  RecordsViewModel recordsViewModel;

  @override
  void initState() {
    super.initState();
    recordsViewModel = RecordsViewModel();
    recordsViewModel.init();
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
                child: FutureBuilder(
                  future: recordsViewModel.getPlates(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RecordModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RecordCard(
                              plate: snapshot.data[index].plate ?? "Bulunamadı",
                              date: snapshot.data[index].timestamp ??
                                  "Bulunamadı",
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
