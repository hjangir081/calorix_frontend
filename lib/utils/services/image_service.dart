import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'permission_service.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickFromCamera() async {
    final allowed = await PermissionService.requestCamera();
    if (!allowed) return null;

    final image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }

  static Future<File?> pickFromGallery() async {
    final allowed = await PermissionService.requestGallery();
    print("Permission: $allowed");

    if (!allowed) return null;

    final image = await _picker.pickImage(source: ImageSource.gallery);

    print("Image result: $image");

    return image != null ? File(image.path) : null;
  }
}