import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/core/constants/style_constants.dart';
import 'package:flutter_ocr/view/home/model/record_model.dart';
import 'package:flutter_ocr/view/singlerecord/viewmodel/singlerecord_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleRecordView extends StatefulWidget {
  @override
  _SingleRecordViewState createState() => _SingleRecordViewState();
}

class _SingleRecordViewState extends State<SingleRecordView> {
  SingleRecordViewModel singleRecordViewModel;

  @override
  void initState() {
    super.initState();
    singleRecordViewModel = SingleRecordViewModel();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    int currentId = arguments["passedId"];
    singleRecordViewModel.setRecordId(currentId);

    return Container(
      decoration: BoxDecoration(gradient: StyleConstants.kYellowLinearGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: Observer(
            builder: (BuildContext context) {
              int currentRecordId = singleRecordViewModel.recordId;
              return FutureBuilder(
                future: singleRecordViewModel.getRecordInfo(currentRecordId),
                builder: (BuildContext context,
                    AsyncSnapshot<RecordModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                      children: [
                        buildPreviousButton(),
                        buildRecordInformation(snapshot),
                        buildNextButton(),
                      ],
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: ColorConstants.ISPARK_YELLOW,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ColorConstants.ISPARK_YELLOW_DARK),
                    ));
                  }
                },
              );
            },
          )),
    );
  }

  Expanded buildNextButton() {
    return Expanded(
      child: IconButton(
        onPressed: () {
          singleRecordViewModel.getNext();
        },
        icon: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Expanded buildRecordInformation(AsyncSnapshot<RecordModel> snapshot) {
    return Expanded(
      flex: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 6, child: buildPlateText(snapshot)),
          Expanded(child: buildCoordinationText(snapshot)),
          Expanded(flex: 3, child: buildMap(snapshot)),
        ],
      ),
    );
  }

  GoogleMap buildMap(AsyncSnapshot<RecordModel> snapshot) {
    return GoogleMap(
      markers: Set<Marker>.of([
        Marker(
            markerId: MarkerId('currentPosition'),
            position: LatLng(snapshot.data.latitude, snapshot.data.longitude),
            infoWindow: InfoWindow(title: 'The title of the marker'))
      ]),
      mapType: MapType.normal,
      initialCameraPosition: singleRecordViewModel.getCameraPosition(
          snapshot.data.latitude, snapshot.data.longitude),
      onMapCreated: (GoogleMapController controller) {
        singleRecordViewModel.controller.complete(controller);
      },
    );
  }

  Column buildCoordinationText(AsyncSnapshot<RecordModel> snapshot) {
    return Column(
      children: [
        Text(
          "Konum Bilgisi",
          textScaleFactor: 1.4,
        ),
        SizedBox(
          height: 10,
        ),
        SelectableText(snapshot.data.latitude.toString() +
            ", " +
            snapshot.data.longitude.toString()),
      ],
    );
  }

  Container buildPlateText(AsyncSnapshot<RecordModel> snapshot) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: ColorConstants.ISPARK_YELLOW,
      ),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Araç Plakası",
              textScaleFactor: 1.8,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            SelectableText(
              snapshot.data.plate,
              textScaleFactor: 1.2,
              style: TextStyle(
                  color: ColorConstants.ISPARK_BLUE_DARK,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(
                  base64Decode(snapshot.data.base64Image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildPreviousButton() {
    return Expanded(
      child: IconButton(
        onPressed: () {
          singleRecordViewModel.getPrevious();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
