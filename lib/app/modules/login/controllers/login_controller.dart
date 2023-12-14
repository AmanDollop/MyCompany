import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class LoginController extends GetxController {

  final count = 0.obs;
  final termsCheckBoxValue = false.obs;

  final emailController = TextEditingController();

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
    CM.unFocusKeyBoard();
    Get.back();
  }

  void clickOnContinueButton() {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.BOTTOM_NAVIGATION);
  }

  void clickOnCreateAccountButton() {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.SIGN_UP);
  }

}
