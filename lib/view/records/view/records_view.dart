import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/record_card.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/product/notifiers/connection_notifier.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
    recordsViewModel.getContext(context);
    return Scaffold(
      backgroundColor: ColorConstants.ISPARK_WHITE,
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: recordsViewModel.checkIfOfflineRecordsExistsAndSendToAPI(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildListView();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verileriniz eşitleniyor..."),
                Center(child: _buildMockProgressIndicator()),
              ],
            );
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  buildListView() {
    ConnectivityResult result =
        context.read<ConnectionNotifier>().connectivityResult;
    if (result != ConnectivityResult.none) {
      return FutureBuilder(
        future: recordsViewModel.getFirstDataOnline(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Observer(
              builder: (BuildContext context) {
                return buildOnlineListView();
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verileriniz yükleniyor"),
                Center(child: _buildMockProgressIndicator()),
              ],
            );
          }
        },
      );
    } else {
      return FutureBuilder(
        future: recordsViewModel.getLocalPlateRecords(),
        builder:
            (BuildContext context, AsyncSnapshot<List<RecordModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildRecordListOffline(snapshot);
          } else {
            return _buildProgressIndicator();
          }
        },
      );
    }
  }

  Widget buildOnlineListView() {
    return recordsViewModel.allRecords.length != 0
        ? ListView.builder(
            itemCount: recordsViewModel.allRecords.length + 1,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == recordsViewModel.allRecords.length) {
                return Observer(
                  builder: (BuildContext context) {
                    return _buildProgressIndicator();
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildOnlineRecordCard(index),
                );
              }
            },
            controller: recordsViewModel.scrollController,
          )
        : Center(
            child: Text("Henüz hiç kayıt oluşturulmadı."),
          );
  }

  Widget buildRecordListOffline(AsyncSnapshot<List<RecordModel>> snapshot) {
    return snapshot.data?.length != 0
        ? ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildOfflineRecordCard(
                    snapshot, snapshot.data.length - index - 1),
              );
            },
          )
        : Center(
            child: Text("Henüz hiç kayıt oluşturulmadı."),
          );
  }

  RecordCard buildOnlineRecordCard(int index) {
    return RecordCard(
        plate: recordsViewModel.allRecords[index]['licensePlate'],
        date: recordsViewModel.allRecords[index]['createdOn'],
        id: recordsViewModel.allRecords[index]['id'],
        onPressed: () {
          recordsViewModel.navigateToSingleRecordViewPage(index);
        });
  }

  RecordCard buildOfflineRecordCard(
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: recordsViewModel.isLoading ? 1.0 : 00,
          child: fetchingAnimation,
        ),
      ),
    );
  }

  Widget _buildMockProgressIndicator() {
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: fetchingAnimation,
      ),
    );
  }

  final fetchingAnimation = SpinKitChasingDots(
    size: 30,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index.isEven ? Colors.yellow : Colors.black,
        ),
      );
    },
  );

  @override
  void dispose() {
    super.dispose();
    recordsViewModel.dispose();
  }
}
