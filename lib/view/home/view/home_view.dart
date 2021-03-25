import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/bold_header_text.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/custom_drawer.dart';
import 'package:flutter_ocr/core/components/custom_elevated_button.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/view/home/viewmodel/home_view_model.dart';

import '../../../core/constants/style_constants.dart';

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
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: StyleConstants.kYellowLinearGradient),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: buildDrawer(context),
        key: viewModel.scaffoldState,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 4,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      buildCameraPreview(),
                      Observer(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: viewModel.scannedText != null &&
                                      !viewModel.isLoading
                                  ? FloatingActionButton(
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        viewModel.prepareToNewFile();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          );
                        },
                      )
                    ],
                  )),
              Expanded(flex: 4, child: buildScannedImageText()),
              Expanded(flex: 2, child: buildSavePlateButton()),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<void> buildCameraPreview() {
    return FutureBuilder<void>(
      future: viewModel.initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(viewModel.controller);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Observer buildScannedImageText() {
    return Observer(
      builder: (BuildContext context) {
        return viewModel.isLoading
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoldHeaderText(text: 'PLAKA BİLGİSİ'),
            SizedBox(height: 10),
            viewModel.scannedText != null
                ? buildEditableLicensePlateTextField()
                : Text("Bilgi yok"),
            SizedBox(height: 20),
            BoldHeaderText(text: 'KONUM BİLGİSİ'),
            SizedBox(height: 10),
            viewModel.locationModel != null
                ? buildCoordinationsText()
                : Text("Bilgi yok"),
          ],
        ),
      ),
    );
  }

  Observer buildSavePlateButton() {
    return Observer(
      builder: (BuildContext context) {
        bool isAvailable =
            viewModel.scannedText != null && !viewModel.isLoading;
        return CustomElevatedButton(
          icon: Icons.save,
          buttonColor:
              !isAvailable ? ColorConstants.ISPARK_YELLOW : Colors.green,
          buttonText: Text(!isAvailable ? "Fotoğraf Çek" : "Kaydet"),
          buttonTextColor: ColorConstants.ISPARK_WHITE,
          onPressed: !isAvailable
              ? viewModel.getImageFile
              : () async => viewModel.saveLicensePlate(),
        );
      },
    );
  }

  EditableText buildEditableLicensePlateTextField() {
    return EditableText(
      forceLine: false,
      toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
      onChanged: (value) {
        viewModel.updateEditableText(value);
      },
      textAlign: TextAlign.center,
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.text,
      maxLines: 2,
      cursorColor: Colors.red,
      backgroundCursorColor: Colors.red,
      focusNode: viewModel.focusNode,
      controller: viewModel.editingController,
      style: TextStyle(fontSize: 20, color: ColorConstants.ISPARK_BLUE),
    );
  }

  Text buildCoordinationsText() {
    return Text(
      viewModel.locationModel.latitude.toString() +
          " , " +
          viewModel.locationModel.longitude.toString(),
      style: TextStyle(color: ColorConstants.ISPARK_BLACK),
    );
  }

  CustomDrawer buildDrawer(BuildContext context) {
    return CustomDrawer(
      firstFunction: viewModel.navigateToRecordsPage,
      drawerHeaderName: 'PARXLAB',
      firstOptionName: 'Kayıtlar',
      firstIconData: Icons.save,
      logOutFunction: viewModel.logout,
    );
  }
}
