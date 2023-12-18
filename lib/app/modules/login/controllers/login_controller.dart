import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class LoginController extends GetxController {

  final count = 0.obs;
  final termsCheckBoxValue = false.obs;
  final key = GlobalKey<FormState>();

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
    if(key.currentState!.validate() && termsCheckBoxValue.value){
      Get.toNamed(Routes.OTP_VERIFICATION);
    }
  }

  void clickOnCreateAccountButton() {
    CM.unFocusKeyBoard();
    emailController.clear();
    Get.toNamed(Routes.SIGN_UP);
  }

}
