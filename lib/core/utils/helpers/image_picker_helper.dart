import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';

class ImagePickerHelper {
  static Future<String?> pickFromCamera(BuildContext context) async {
    return await _pickImage(context, ImageSource.camera);
  }

  static Future<String?> pickFromGallery(BuildContext context) async {
    return await _pickImage(context, ImageSource.gallery);
  }

  // Helper function to pick image from specified source
  static Future<String?> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      if (context.mounted) {
        _showError('No image selected.');
      }
    }
    return null;
  }

  static void _handlePermissionStatus(BuildContext context, PermissionStatus status, String source) {
    if (status.isPermanentlyDenied) {
      _showError('$source access permission is permanently denied. Please enable it in settings.');
      openAppSettings();
    } else if (status.isDenied) {
      _showError('$source access permission denied. Please enable it in settings.');
    }
  }

  static void _showError(String message) {
    GeneralSnackbar.show(message: message);
  }
}
