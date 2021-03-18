import 'package:flutter/material.dart';
import 'package:flutter_ocr/view/home/view/home_view.dart';

void main() {
  runApp(FlutterOcr());
}

class FlutterOcr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}
