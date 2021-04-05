import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/notifier/provider_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/root_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager.preferencesInit();
  await LocationService.firstLocationInit();
  runApp(
    MultiProvider(
      providers: [
        ...ProviderService.instance.dependItems,
      ],
      child: FlutterOcr(),
    ),
  );
}
