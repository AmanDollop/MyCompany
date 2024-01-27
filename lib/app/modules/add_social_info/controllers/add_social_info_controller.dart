import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:http/http.dart' as http;
import '../../../../api/api_constants/ac.dart';

class AddSocialInfoController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final twitterController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedinController = TextEditingController();

  final saveButtonValue = false.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  Map<String, dynamic> bodyParams = {};

  final userDataFromLocalDataBase =''.obs;

  UserDetails? userData;
  SocialInfo? socialInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      accessType.value = Get.arguments[0];
      isChangeable.value = Get.arguments[1];
      profileMenuName.value = Get.arguments[2];
    } catch (e) {}
    await setDefaultData();
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

  Future<void> setDefaultData() async {

    userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

    userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;

    socialInfo=userData?.socialInfo;

    twitterController.text = socialInfo?.twitter??'';

    linkedinController.text = socialInfo?.linkedin??'';

    instagramController.text = socialInfo?.instagram??'';

    facebookController.text = socialInfo?.facebook??'';
    count.value++;
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnSaveButton() async {
    if(key.currentState!.validate()) {
      saveButtonValue.value = true;
      await callingAddSocialInfoApi();
    }
  }

  Future<void> callingAddSocialInfoApi() async {
    try {
      bodyParams = {
        AK.action: ApiEndPointAction.updateSocialInfo,
        AK.twitter: twitterController.text.trim().toString(),
        AK.facebook: facebookController.text.trim().toString(),
        AK.instagram: instagramController.text.trim().toString(),
        AK.linkedin: linkedinController.text.trim().toString(),
      };
      http.Response? response = await CAI.updateUserControllerApi(bodyParams: bodyParams);
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          saveButtonValue.value = false;
        } else {
          CM.error();
          Get.back();
          saveButtonValue.value = false;
        }
      } else {
        saveButtonValue.value = false;
        CM.error();
        Get.back();
      }
    } catch (e) {
      saveButtonValue.value = false;
      CM.error();
      Get.back();
    }
  }

}
