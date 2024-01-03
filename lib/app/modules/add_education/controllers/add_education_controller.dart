import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../../../../api/api_constants/ac.dart';

class AddEducationController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final tabBarValue = 'Achievement'.obs;

  final labelTypeText = ['Education', 'Achievement'];
  final achievementAndEducationType = ''.obs;

  final educationAchievementId = ''.obs;

  final achievementNameController = TextEditingController();
  final universityLocationController = TextEditingController();
  final yearController = TextEditingController();
  final remarkController = TextEditingController();

  final sendAddRequestButtonValue = false.obs;
  Map<String, dynamic> bodyParams = {};

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

  void clickOnEducationTab() {
    tabBarValue.value = 'Education';
  }

  void clickOnAchievementsTab() {
    tabBarValue.value = 'Achievement';
  }

  Future<void> clickOnYearTextField() async {

    int selectedYear = DateTime.now().year;

    CM.unFocusKeyBoard();
    await CBS.commonBottomSheet(
      isDismissible: false,
      children: [
        SizedBox(
          height: 140,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              selectedYear = DateTime.now().year - index;
            },
            children: List.generate(150, (index) {
              return Center(
                child: Text(
                  '${DateTime.now().year - index}',
                  style: const TextStyle(fontSize: 24),
                ),
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.px,
                      horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textCancel,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                yearController.text = selectedYear.toString();
                Get.back();
              },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.px,
                      horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textSelect,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.px),
      ],
    );
  }

  Future<void> clickOnSendAddRequestButton() async {
    if(key.currentState!.validate()  && achievementAndEducationType.value.isNotEmpty){
      sendAddRequestButtonValue.value = true;
      await callingAddEducationAndAchievementApi();
    }
  }

  Future<void> callingAddEducationAndAchievementApi() async {
    try {
      bodyParams = {
        AK.action: 'addEducation',
        AK.educationAchievementId: educationAchievementId.value,
        AK.classAchievement: achievementNameController.text.trim().toString(),
        AK.type: achievementAndEducationType.value,
        AK.universityLocation: universityLocationController.text.trim().toString(),
        AK.year: yearController.text.trim().toString(),
        AK.remark: remarkController.text.trim().toString(),
        AK.createdDate: 'addEducation',
      };
      http.Response? response = await CAI.updateUserControllerApi(bodyParams: bodyParams);
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          sendAddRequestButtonValue.value = false;
        } else {
          Get.back();
          sendAddRequestButtonValue.value = false;
        }
      } else {
        sendAddRequestButtonValue.value = false;
        CM.error();
        Get.back();
      }
    } catch (e) {
      sendAddRequestButtonValue.value = false;
      CM.error();
      Get.back();
    }
  }
}
