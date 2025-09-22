import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo();
  Future<bool> get isConnected async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final isConnectedToNetwork =
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
    return isConnectedToNetwork;
  }
}
