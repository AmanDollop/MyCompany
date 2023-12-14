import 'dart:io';

import 'package:task/common/common_methods/cm.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:flutter/material.dart';
/// flutter pub add image_picker For Image Picker And Also See Configuration  in pubspec.yaml
import 'package:image_picker/image_picker.dart';

///flutter pub add image_cropper For Image  Cropper And Also See Configuration  in pubspec.yaml
import 'package:image_cropper/image_cropper.dart';

class IP{
  static Future<File?> pickImage({
    bool pickFromGallery = false,
    bool isCropper = false,
    Color? cropperColor ,
  }) async {
    XFile? imagePicker = pickFromGallery
        ? await ImagePicker().pickImage(source: ImageSource.gallery)
        : await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      if (isCropper) {
        CroppedFile? cropImage = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: cropperColor??Col.primary,
              toolbarTitle: "Cropper",
              activeControlsWidgetColor: cropperColor??Col.primary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
          compressQuality: 40,
        );
        if (cropImage != null) {
          return File(cropImage.path);
        } else {
          return null;
        }
      } else {
        return File(imagePicker.path);
      }
    } else {
      return null;
    }
  }
}