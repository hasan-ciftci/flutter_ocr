import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/view/viewmodel/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Observer(
            builder: (BuildContext context) {
              return viewModel.image != null
                  ? Image.file(viewModel.image)
                  : Text("no image");
            },
          ),
          ElevatedButton(
            child: Text("Pick Image"),
            onPressed: () async {
              viewModel.getImageFile();
            },
          ),
          ElevatedButton(
            child: Text("Scan Image"),
            onPressed: () async {
              viewModel.scanImage();
            },
          ),
          Observer(
            builder: (BuildContext context) {
              return viewModel.isScanning
                  ? Center(child: CircularProgressIndicator())
                  : Text(viewModel.scannedText ?? "");
            },
          )
        ],
      ),
    );
  }
}
