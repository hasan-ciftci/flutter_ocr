import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/image%20picker/image_picker.dart';
import 'package:flutter_ocr/core/init/ocr/ocr_service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String text = "";
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          image != null ? Image.file(image) : Text("no image"),
          ElevatedButton(
            child: Text("Pick Image"),
            onPressed: () async {
              var file = await ImagePickerService.instance.getImageFile();
              setState(() {
                image = file;
                text = "";
              });
              //final imageFromBytes = await image.readAsBytes();
              final myText = await OcrService.instance.getTextFromImage(file);
              setState(() {
                text = myText;
              });
            },
          ),
          Text(text),
        ],
      ),
    );
  }
}
