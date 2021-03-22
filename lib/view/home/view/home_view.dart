import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ocr/core/components/bold_header_text.dart';
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
        key: viewModel.scaffoldState,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 4, child: buildSelectedPhoto()),
                buildPickImageButton(),
                Expanded(flex: 4, child: buildScannedImageText()),
                Expanded(flex: 2, child: buildSavePlateButton()),
              ],
            ),
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

  CustomElevatedButton buildPickImageButton() {
    return CustomElevatedButton(
      icon: Icons.photo_camera,
      buttonColor: ColorConstants.ISPARK_BLUE_LIGHT,
      buttonText: "Plaka Fotoğrafı çek",
      onPressed: () async {
        viewModel.getImageFile();
      },
    );
  }

  CustomElevatedButton buildSavePlateButton() {
    return CustomElevatedButton(
      icon: Icons.save,
      buttonColor: ColorConstants.ISPARK_BLUE_DARK,
      buttonText: "Kaydet",
      onPressed: () async {
        viewModel.saveLicensePlate();
      },
    );
  }

  Observer buildSelectedPhoto() {
    return Observer(
      builder: (BuildContext context) {
        return viewModel.image != null
            ? Image.file(viewModel.image)
            : Center(child: Text("Fotoğraf eklemediniz"));
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
}
