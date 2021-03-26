import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/record_card.dart';
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
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: ColorConstants.ISPARK_WHITE,
      body: FutureBuilder(
        future: recordsViewModel.getPlates(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecordModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildRecordList(snapshot);
          } else {
            return buildCircularProgressIndicator();
          }
        },
      ),
    );
  }

  ListView buildRecordList(AsyncSnapshot<List<RecordModel>> snapshot) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildRecordCard(snapshot, index),
        );
      },
    );
  }

  RecordCard buildRecordCard(
      AsyncSnapshot<List<RecordModel>> snapshot, int index) {
    var data = snapshot.data[index];
    return RecordCard(
      onPressed: () {
        recordsViewModel.navigateToSingleRecordViewPage(data.id);
      },
      plate: data.plate ?? "Bulunamadı",
      date: data.timestamp ?? "Bulunamadı",
      id: data.id ?? "yok",
    );
  }

  Center buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
