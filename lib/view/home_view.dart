import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/image%20picker/image_picker.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Pick Image"),
          onPressed: () {
            ImagePickerService.instance.getImageFile();
          },
        ),
      ),
    );
  }
}
