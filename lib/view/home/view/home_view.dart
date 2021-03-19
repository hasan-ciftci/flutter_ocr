import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_elevated_button.dart';
import 'package:flutter_ocr/view/home/viewmodel/home_view_model.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: buildSelectedPhoto(),
              ),
              buildPickImageButton(),
              buildScanImageButton(),
              Expanded(
                flex: 4,
                child: buildScannedImageText(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Observer buildScannedImageText() {
    return Observer(
      builder: (BuildContext context) {
        return viewModel.isScanning
            ? buildProgressIndicator()
            : buildOcrResultText();
      },
    );
  }

  Center buildProgressIndicator() => Center(child: CircularProgressIndicator());

  Padding buildOcrResultText() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            viewModel.locationModel != null
                ? Text(viewModel.locationModel.latitude.toString() +
                    " , " +
                    viewModel.locationModel.longitude.toString())
                : Text("Lokasyon belirlenemedi"),
            Text(
              viewModel.scannedText ?? "Scan a image.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  CustomElevatedButton buildScanImageButton() {
    return CustomElevatedButton(
      buttonText: "Scan Image",
      onPressed: () async {
        viewModel.scanImage();
      },
      buttonColor: Colors.blueAccent,
    );
  }

  CustomElevatedButton buildPickImageButton() {
    return CustomElevatedButton(
      buttonText: "Pick Image",
      onPressed: () async {
        viewModel.getImageFile();
      },
    );
  }

  Observer buildSelectedPhoto() {
    return Observer(
      builder: (BuildContext context) {
        return viewModel.image != null
            ? Image.file(viewModel.image)
            : Center(child: Text("no image selected."));
      },
    );
  }
}
