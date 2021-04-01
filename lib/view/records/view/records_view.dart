import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/record_card.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/init/notifier/provider_service.dart';
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
    recordsViewModel.getMoreData();
    recordsViewModel.scrollController.addListener(() {
      if (recordsViewModel.scrollController.position.pixels ==
          recordsViewModel.scrollController.position.maxScrollExtent) {
        recordsViewModel.getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    recordsViewModel.getContext(context);
    return Scaffold(
      backgroundColor: ColorConstants.ISPARK_WHITE,
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: buildListView(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data;
          } else {
            return _buildProgressIndicator();
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<Widget> buildListView() async {
    ConnectivityResult result =
        Provider.of<ConnectionNotifier>(context).connectivityResult;
    if (result != ConnectivityResult.none) {
      return Observer(
        builder: (BuildContext context) {
          return buildOnlineListView();
        },
      );
    } else {
      return FutureBuilder(
        future: recordsViewModel.getPlates(),
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

  ListView buildOnlineListView() {
    return ListView.builder(
      itemCount: recordsViewModel.users.length + 1,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == recordsViewModel.users.length) {
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
    );
  }

  ListView buildRecordListOffline(AsyncSnapshot<List<RecordModel>> snapshot) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildOfflineRecordCard(
              snapshot, snapshot.data.length - index - 1),
        );
      },
    );
  }

  RecordCard buildOnlineRecordCard(int index) {
    return RecordCard(
        plate: recordsViewModel.users[index]['licensePlate'],
        date: recordsViewModel.users[index]['createdOn'],
        id: recordsViewModel.users[index]['id'],
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
