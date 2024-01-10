import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

import '../../../../api/api_model/user_data_modal.dart';

class PersonalInfoController extends GetxController {

  final count = 0.obs;

  final userDataFromLocalDataBase =''.obs;

  UserDetails? userData;
  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  JobInfo? jobInfo;
  SocialInfo? socialInfo;

  final userPic = ''.obs;
  final userFullName = ''.obs;
  final userShortName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final dob = ''.obs;
  final bloodGroup = ''.obs;
  final gender = ''.obs;
  final interestHobbies = ''.obs;
  final specialSkills = ''.obs;
  final languagesKnown = ''.obs;



  final apiResponseValue = true.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
    await setDefaultData();
    apiResponseValue.value=false;
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

    personalInfo=userData?.personalInfo;
    contactInfo=userData?.contactInfo;
    jobInfo=userData?.jobInfo;
    socialInfo=userData?.socialInfo;

      userPic.value = personalInfo?.userProfilePic ?? '';

      userFullName.value = personalInfo?.userFullName??'';

      userShortName.value = personalInfo?.shortName??'';

      dob.value = personalInfo?.memberDateOfBirth??'';

      bloodGroup.value = personalInfo?.bloodGroup??'';

      gender.value = personalInfo?.gender??'';

      interestHobbies.value = personalInfo?.hobbiesAndInterest??'';

      specialSkills.value = personalInfo?.skills??'';

      languagesKnown.value = personalInfo?.languageKnown??'';

      email.value = contactInfo?.userEmail??'';

      mobileNumber.value = contactInfo?.userMobile ?? '';

  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditViewButton() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }


}
