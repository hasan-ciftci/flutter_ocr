import 'package:flutter_ocr/product/notifiers/connection_notifier.dart';
import 'package:flutter_ocr/product/notifiers/record_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderService {
  static ProviderService _instance;

  static ProviderService get instance {
    if (_instance == null) _instance = ProviderService._init();
    return _instance;
  }

  ProviderService._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => RecordNotifier(),
    ),
    Provider(
      create: (context) => ConnectionNotifier(),
    ),
  ];
}
