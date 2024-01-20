import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/face/face.dart';

class MyFaceAttendanceController extends GetxController {

  final count = 0.obs;
  final userFaceModel = Rxn<UserFaceData>();

  @override
  void onInit() {
    super.onInit();
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

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnChangeFaceButton() async {
    var fc = CustomFaceDetector();

    userFaceModel.value = await fc.getFaceFeatures();
    userFaceModel.value?.name = "Abhishek";
    fc.dispose();
    await CM.setString(key: 'faceData', value: jsonEncode(userFaceModel.value?.toJson()));
  }

}
