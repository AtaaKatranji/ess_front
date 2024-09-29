import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  // Request location permission
  PermissionStatus locationStatus = await Permission.location.request();
  if (locationStatus.isGranted) {
    print("Location permission granted.");
  } else if (locationStatus.isDenied) {
    print("Location permission denied.");
    await askForPermissionAgain(Permission.location);
  } else if (locationStatus.isPermanentlyDenied) {
    print("Location permission permanently denied.");
    openAppSettings();
  }
  // Request change Wi-Fi state permission
  PermissionStatus wifiStatus = await Permission.locationWhenInUse.request();
  if (wifiStatus.isGranted) {
    print("Wi-Fi state change permission granted.");
  } else if (wifiStatus.isDenied) {
    print("Wi-Fi state change permission denied.");
    await askForPermissionAgain(Permission.locationWhenInUse);
  } else if (wifiStatus.isPermanentlyDenied) {
    print("Wi-Fi state change permission permanently denied.");
    openAppSettings();
  }
}
//checks the status of the given permission
Future<void> checkAndRequestPermission(Permission permission) async {
  PermissionStatus status = await permission.status;

  if (status.isGranted) {
    print("${permission.toString()} is already granted.");
  } else if (status.isDenied) {
    print("${permission.toString()} is denied, requesting again...");
    await askForPermissionAgain(permission);
  } else if (status.isPermanentlyDenied) {
    print("${permission.toString()} is permanently denied. Redirecting to settings...");
    openAppSettings();
  }
}
//Requests the denied permission again
Future<void> askForPermissionAgain(Permission permission) async {
  PermissionStatus status = await permission.request();
  if (status.isGranted) {
    print("Permission granted after asking again.");
  } else {
    print("Permission still denied.");
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
