import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/face/face.dart';
import 'package:flutter_face_api/face_api.dart' as regula;


class FaceDetectionController extends GetxController {
  //TODO: Implement FaceDetectionController

  final count = 0.obs;

  //User data from Shared Prefs
  final userSavedFaceData = Rxn<UserFaceData>();

  //Current Face Data
  final userFaceData = Rxn<UserFaceData>();

  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserFaceData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getUserFaceData() async {
    userSavedFaceData.value = UserFaceData.fromJson(jsonDecode(await CM.getString(key: 'faceData') ?? ''));
    image1.bitmap = userSavedFaceData.value?.image;
    image1.imageType = regula.ImageType.PRINTED;
    await clickOnAuthenticateFace();
  }

  Future<void> clickOnAuthenticateFace() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 400,
      maxWidth: 400,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      userFaceData.value = await CustomFaceDetector().getFaceFeatures(fileImage: File(pickedFile.path));
      image2.bitmap = base64Encode(await pickedFile.readAsBytes());
      image2.imageType = regula.ImageType.PRINTED;

      double similarity = compareFaces(userSavedFaceData.value!.faceFeatures!,userFaceData.value!.faceFeatures!);
      print("similarity:::$similarity");

      if (similarity >= 0.5 && similarity <= 1.5) {
        if (await CustomFaceDetector().matchFaces(image1: image1, image2: image2)) {
          print('Face Matched');
          CM.showToast('Face Matched');
        } else {
          print('Face does not Match');
          CM.showToast('Face does not Match');
        }
      } else {
        print('Face does not Match');
        CM.showToast('Face does not Match');
      }
    } else {
      CM.showToast('Take a pic first');
    }
  }



}
