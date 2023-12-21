import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';

class LoginController extends GetxController {

  final count = 0.obs;
  final termsCheckBoxValue = false.obs;
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String apiBaseUrl = '';
  String companyId = '';

  @override
  void onInit() {
    super.onInit();
    apiBaseUrl = Get.arguments[0];
    companyId = Get.arguments[1];
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
      BottomSheetForOTP.commonBottomSheetForVerifyOtp(
        otp: '124512'
      );
    }
  }

  void clickOnCreateAccountButton() {
    CM.unFocusKeyBoard();
    emailController.clear();
    termsCheckBoxValue.value=false;
    Get.toNamed(Routes.SIGN_UP,arguments: [companyId]);
  }


  void callingLogInApi(){

  }

}
