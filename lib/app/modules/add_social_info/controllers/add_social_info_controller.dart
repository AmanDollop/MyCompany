import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSocialInfoController extends GetxController {

  final count = 0.obs;

  final twitterController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedinController = TextEditingController();

  final saveButtonValue = false.obs;

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

  void clickOnSaveButton() {
    Get.back();
  }

}
