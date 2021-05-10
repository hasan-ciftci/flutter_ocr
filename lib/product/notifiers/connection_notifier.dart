import 'package:connectivity/connectivity.dart';

class ConnectionNotifier {
  ConnectivityResult _connectivityResult;

  ConnectivityResult get connectivityResult => _connectivityResult;

  ///Sets current connectivity type on Provider
  ///Gets data type of [ConnectivityResult]
  setConnectivityResult(ConnectivityResult con) {
    _connectivityResult = con;
  }
}
