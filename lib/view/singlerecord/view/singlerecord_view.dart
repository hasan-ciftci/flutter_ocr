import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
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
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              singleRecordViewModel.getPrevious();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(snapshot.data.plate),
                              ),
                              Expanded(
                                child: Text(snapshot.data.latitude.toString() +
                                    ", " +
                                    snapshot.data.longitude.toString()),
                              ),
                              Expanded(
                                child: GoogleMap(
                                  markers: Set<Marker>.of([
                                    Marker(
                                        markerId: MarkerId('SomeId'),
                                        position: LatLng(37.718590, 35.327610),
                                        infoWindow: InfoWindow(
                                            title: 'The title of the marker'))
                                  ]),
                                  mapType: MapType.normal,
                                  initialCameraPosition: singleRecordViewModel
                                      .getCameraPosition(37.718590, 35.327610),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    singleRecordViewModel.controller
                                        .complete(controller);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              singleRecordViewModel.getNext();
                            },
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          )),
    );
  }
}
