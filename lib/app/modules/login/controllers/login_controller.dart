import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  FocusNode focusNodeForEmail = FocusNode();

  String apiBaseUrl = '';
  String companyLogo = '';
  String companyId = '1';

  final loginButtonValue = false.obs;

  Map<String, dynamic> bodyParamsSendOtp = {};
  Map<String, dynamic> otpApiResponseMap = {};

  final deviceId = ''.obs;
  final deviceType = ''.obs;
  final fcmId = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    companyId = Get.arguments[0];
    companyLogo = Get.arguments[1];
    apiBaseUrl = await CM.getString(key: AK.baseUrl) ?? '';
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
    if (key.currentState!.validate() && termsCheckBoxValue.value) {
      try {
        loginButtonValue.value = true;
        await sendOtpApiCalling();
      } catch (e) {
        loginButtonValue.value = false;
      }
    } else {
      loginButtonValue.value = false;
    }
    loginButtonValue.value = false;
  }

  void clickOnCreateAccountButton() {
    CM.unFocusKeyBoard();
    emailController.clear();
    termsCheckBoxValue.value = false;
    loginButtonValue.value = false;
    Get.toNamed(Routes.SIGN_UP, arguments: [companyId])?.then((value) {
      emailController.text = value;
      return value;
    });
  }

  Future<void> getIdsMethod() async {
    deviceId.value = await CM.getDeviceId();
    deviceType.value = CM.getDeviceType();
    if (Platform.isAndroid) {
      fcmId.value = await FirebaseMessaging.instance.getToken() ?? '';
    } else if (Platform.isIOS) {
      fcmId.value = await CM.generateRandomString();
    }
  }

  Future<void> sendOtpApiCalling() async {
    try {
      await getIdsMethod();
      bodyParamsSendOtp = {
        AK.action: ApiEndPointAction.userSentOtp,
        AK.userEmail: emailController.text.trim().toString(),
        AK.fcmId: fcmId.value,
        AK.deviceId: deviceId.value,
        AK.deviceType: deviceType.value,
      };
      http.Response? response = await CAI.sendOtpApi(bodyParams: bodyParamsSendOtp);
      if (response != null) {
        loginButtonValue.value = false;
        otpApiResponseMap = jsonDecode(response.body);
        if (response.statusCode == 200) {
          loginButtonValue.value = false;
          await BottomSheetForOTP.commonBottomSheetForVerifyOtp(otp: otpApiResponseMap["otp"].toString(), email: emailController.text.trim().toString(),companyLogo:companyLogo);
        }
        else if (response.statusCode == 201) {
          await BottomSheetForOTP.deviceChangeRequestBottomSheetView(message:otpApiResponseMap["message"],id:otpApiResponseMap["id"]);
        }
        else {
          loginButtonValue.value = false;
          CM.error();
        }
      } else {
        loginButtonValue.value = false;
        CM.error();
      }
    } catch (e) {
      loginButtonValue.value = false;
      CM.error();
    }
  }

}
