import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> checkStoragePermission() async {
    PermissionStatus p = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (p == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  static Future<bool> requestPermission() async {
    Map<PermissionGroup, PermissionStatus> p =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (p.containsKey(PermissionGroup.storage) &&
        p.containsValue(PermissionStatus.granted)) {
      return true;
    }

    return false;
  }

  static Future<bool> openSettings() async {
    return await PermissionHandler().openAppSettings();
  }
}
