import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  static Future<bool> requestGallery() async {
    var status = await Permission.photos.status;
    if (status.isGranted || status.isLimited) {
      return true;
    }
    if (status.isDenied) {
      final result = await Permission.photos.request();
      if (result.isGranted || result.isLimited) {
        return true;
      }
      if (result.isPermanentlyDenied) {
        await openAppSettings();
      }
      return false;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  static Future<bool> requestCamera() async {
    var status = await Permission.camera.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await Permission.camera.request();

      if (result.isGranted) return true;

      if (result.isPermanentlyDenied) {
        await openAppSettings();
      }

      return false;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      await openAppSettings();
      return false;
    }

    return false;
  }
}