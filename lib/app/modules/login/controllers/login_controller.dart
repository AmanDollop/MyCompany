import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {

  final count = 0.obs;
  final termsCheckBoxValue = false.obs;
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String apiBaseUrl = '';
  String companyLogo = '';
  String companyId = '';

  final loginButtonValue = false.obs;

  Map<String, dynamic> bodyParamsSendOtp = {};
  Map<String, dynamic> otpApiResponseMap = {};


  @override
  Future<void> onInit() async {
    super.onInit();
    companyId = Get.arguments[0];
    companyLogo = Get.arguments[1];
    apiBaseUrl = await CM.getString(key: AK.baseUrl)??'';
    print('apiBaseUrl::::::::::::::     $apiBaseUrl');
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

  Future<void> clickOnContinueButton() async {
    CM.unFocusKeyBoard();
    if(key.currentState!.validate() && termsCheckBoxValue.value){
      loginButtonValue.value = true;
      await sendOtpApiCalling();
    }
  }

  void clickOnCreateAccountButton() {
    CM.unFocusKeyBoard();
    emailController.clear();
    termsCheckBoxValue.value=false;
    Get.toNamed(Routes.SIGN_UP,arguments: [companyId]);
  }

  Future<void> sendOtpApiCalling() async {
    try{
      bodyParamsSendOtp = {
        AK.action: 'userSentOtp',
        AK.userEmail: emailController.text.trim().toString(),
      };
      http.Response? response = await CAI.sendOtpApi(bodyParams: bodyParamsSendOtp);
      if (response != null && response.statusCode == 200) {
        otpApiResponseMap = jsonDecode(response.body);
        loginButtonValue.value = false;
        print('otpApiResponseMap["otp"]:::::::   ${otpApiResponseMap["otp"].toString()}');
        await BottomSheetForOTP.commonBottomSheetForVerifyOtp(otp: otpApiResponseMap["otp"].toString(),email: emailController.text.trim().toString());
      }
      else {
        loginButtonValue.value = false;
        CM.error();
      }
    }catch(e){
      loginButtonValue.value = false;
      CM.error();
    }

  }


}
