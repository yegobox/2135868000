import 'package:backup/services/sync_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static bool isConnected = false;
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        isConnected = true;
        stock.fresh("memos");
      } else {
        isConnected = false;
      }
    });
  }
}
