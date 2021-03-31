import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/custom_appbar.dart';
import 'package:flutter_ocr/core/components/custom_drawer.dart';
import 'package:flutter_ocr/core/components/custom_elevated_button.dart';
import 'package:flutter_ocr/core/constants/color_constants.dart';
import 'package:flutter_ocr/view/home/viewmodel/home_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                  flex: 5,
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
              Expanded(flex: 3, child: buildScannedImageText()),
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
          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(viewModel.controller),
              Observer(
                builder: (BuildContext context) {
                  return viewModel.selectedImage != null
                      ? Image.file(
                          viewModel.selectedImage,
                          fit: BoxFit.fill,
                        )
                      : SizedBox();
                },
              ),
              FractionallySizedBox(
                widthFactor: 0.6,
                heightFactor: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorConstants.ISPARK_YELLOW, width: 3.0)),
                ),
              ),
            ],
          );
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
            ? SizedBox()
            : viewModel.isScanning
                ? buildScanningAnimation(message: 'Plaka taranıyor')
                : buildOcrResultText();
      },
    );
  }

  Center buildScanningAnimation({@required String message}) => Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          processingAnimation,
          SizedBox(
            width: 10,
          ),
          Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ));

  Center buildLoadingAnimation() => Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          processingAnimation,
          SizedBox(
            width: 10,
          ),
          Text("Kaydediliyor"),
        ],
      ));

  Center buildOcrResultText() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: viewModel.scannedText != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildEditableLicensePlateTextField(),
                    buildCoordinationsText()
                  ],
                )
              : buildPlaceholderInformativeText(),
        ),
      ),
    );
  }

  Observer buildSavePlateButton() {
    return Observer(
      builder: (BuildContext context) {
        bool isAvailable =
            viewModel.scannedText != null && !viewModel.isScanning;
        return CustomElevatedButton(
            icon: Icons.save,
            buttonColor:
                !isAvailable ? ColorConstants.ISPARK_YELLOW : Colors.green,
            buttonText: Text(!isAvailable ? "Fotoğraf Çek" : "Kaydet"),
            buttonTextColor: ColorConstants.ISPARK_WHITE,
            onPressed: viewModel.isScanning || viewModel.isLoading
                ? null
                : isAvailable
                    ? () async => viewModel.saveLicensePlate()
                    : () async => viewModel.getImageFile());
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

  Observer buildCoordinationsText() {
    return Observer(
      builder: (BuildContext context) {
        return viewModel.locationModel != null
            ? Text(
                viewModel.locationModel.latitude.toString() +
                    " , " +
                    viewModel.locationModel.longitude.toString(),
                style: TextStyle(color: ColorConstants.ISPARK_BLACK),
              )
            : Text("Konum servisine ulaşılamıyor");
      },
    );
  }

  CustomDrawer buildDrawer(BuildContext context) {
    return CustomDrawer(
      firstFunction: viewModel.navigateToRecordsPage,
      firstOptionName: 'Kayıtlar',
      firstIconData: Icons.save,
      logOutFunction: viewModel.logout,
    );
  }

  Column buildPlaceholderInformativeText() {
    return Column(
      children: [
        Icon(
          Icons.fit_screen,
          size: 45,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Plakayı çerçeve içine alın",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  final processingAnimation = SpinKitChasingDots(
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
}
