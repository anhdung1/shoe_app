import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  for (var connect in connectivityResult) {
    if (connect == ConnectivityResult.mobile ||
        connect == ConnectivityResult.ethernet ||
        connect == ConnectivityResult.wifi) {
      return true;
    }
  }
  return false;
}
