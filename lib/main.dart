import 'package:flutter/material.dart';
import 'package:flutter_ocr/core/init/location/location_service.dart';
import 'package:flutter_ocr/core/init/notifier/provider_service.dart';
import 'package:flutter_ocr/core/init/preferences/preferences_manager.dart';
import 'package:flutter_ocr/root_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Init preferences for control if token exists for page navigation
  await PreferencesManager.preferencesInit();
  //Init location service for set a variable with current location.
  //Variable gets new value on every 30 secs after first init
  //and used by scanning functions.
  await LocationService.firstLocationInit();
  runApp(
    MultiProvider(
      providers: [
        ...ProviderService.instance.dependItems,
      ],
      child: IsparkScanner(),
    ),
  );
}
