import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/education_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../../../../api/api_constants/ac.dart';

class AddEducationController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();

  final labelTypeText = ['Education', 'Achievement'];
  final achievementAndEducationType = ''.obs;

  final educationAchievementId = ''.obs;

  final achievementNameController = TextEditingController();
  final universityLocationController = TextEditingController();
  final yearController = TextEditingController();
  final remarkController = TextEditingController();

  final sendAddRequestButtonValue = false.obs;
  Map<String, dynamic> bodyParams = {};
  GetEducationDetails? getEducationDetails;

  final profileMenuName = ''.obs;
  final tabBarValueData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    profileMenuName.value = Get.arguments[0];
    if(profileMenuName.value == 'Add Achievement' || profileMenuName.value == 'Add Education'){
      tabBarValueData.value = Get.arguments[1];
      if(tabBarValueData.value == 'Achievement'){
        achievementAndEducationType.value ='1';
      }else{
        achievementAndEducationType.value = "0";
      }
    }else{
      getEducationDetails = Get.arguments[1];
      setDefaultDat();
    }
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

  void setDefaultDat(){
    achievementNameController.text = getEducationDetails?.classAchievement ??'';
    universityLocationController.text = getEducationDetails?.universityLocation ??'';
    yearController.text = getEducationDetails?.year ??'';
    remarkController.text = getEducationDetails?.remark ??'';
    educationAchievementId.value = getEducationDetails?.educationAchievementId ??'';
    achievementAndEducationType.value = getEducationDetails?.type ??'';
  }

  void clickOnBackButton() {
    Get.back();
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
        AK.action: ApiEndPointAction.addEducation,
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
