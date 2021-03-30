import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/notifier/provider_service.dart';
import 'package:flutter_ocr/root_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ...ProviderService.instance.dependItems,
      ],
      child: FlutterOcr(),
    ),
  );
}
