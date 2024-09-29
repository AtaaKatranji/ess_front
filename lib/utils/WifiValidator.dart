import 'package:ESS/utils/Permissions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';



class WifiValidator {
  final String workSSID = 'Sultan_Ext'; // Set your router's SSID here
  final String workBSSID = '76:fe:ce:77:6f:0c'; // Optional: Set your router's BSSID here
  
  Future<bool> isConnectedToWorkWifi() async {
    checkAndRequestPermission(Permission.location);
    checkAndRequestPermission(Permission.locationWhenInUse);
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      final wifiInfo = WifiInfo();
      String? currentSSID = await wifiInfo.getWifiName();
      String? currentBSSID = await wifiInfo.getWifiBSSID();
      print(currentSSID);
      print(currentBSSID);
      // Remove any extra quotation marks from SSID for Android
      currentSSID = currentSSID?.replaceAll('"', '');

      // Check if the connected Wi-Fi matches your work router
      if (currentSSID == workSSID || currentBSSID == workBSSID) {
        return true;
      }
    }
    return false;
  }
}
