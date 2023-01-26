import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> hasWiFi() async {
    return await Connectivity().checkConnectivity() == ConnectivityResult.wifi;
  }

  static Future<bool> has4G() async {
    return await Connectivity().checkConnectivity() ==
        ConnectivityResult.mobile;
  }
}
