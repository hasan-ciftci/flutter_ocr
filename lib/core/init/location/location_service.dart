import 'package:geolocator/geolocator.dart';

class LocationService {
  static LocationService _instance;

  static Position position;

  static LocationService get instance {
    _instance ??= LocationService._init();
    return _instance;
  }

  LocationService._init();

  static Future firstLocationInit() async {
    try {
      position ??= await instance.determinePosition();
    } catch (e) {
      print(e);
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
  }
}
