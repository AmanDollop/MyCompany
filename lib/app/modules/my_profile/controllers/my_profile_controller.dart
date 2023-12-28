import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_employee_details_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MyProfileController extends GetxController {
  final count = 0.obs;

  final userPic = ''.obs;
  final firstName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final countryCode = ''.obs;
  final developerType = ''.obs;

  final titleList = [
    'Take Order',
    'Sales Summery',
    'Leave Tracker',
    'Assets',
    'My Expense',
  ].obs;

  final cList = [
    [Colors.red, Colors.orange],
    [Colors.blue, Colors.black],
    [Colors.red, Colors.orange],
    [Colors.blue, Colors.black],
    [Colors.red, Colors.orange],
    [Colors.red, Colors.orange],
    [Colors.blue, Colors.black],
    [Colors.red, Colors.orange],
    [Colors.blue, Colors.black],
  ];

  final getEmployeeDetailsModal = Rxn<GetEmployeeDetailsModal>();
  List<GetEmployeeDetails>? getEmployeeDetails;

  final apiResponseValue = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await setDefaultData();
      await callingGetEmployeeDetailsApi();
    } catch (e) {
      apiResponseValue.value = false;
    }
    apiResponseValue.value = false;
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
    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.userFirstName,
            tableName: DataBaseConstant.tableNameForPersonalInfo) !=
        'null') {
      firstName.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userFirstName,
          tableName: DataBaseConstant.tableNameForPersonalInfo);
    }
    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.userLastName,
            tableName: DataBaseConstant.tableNameForPersonalInfo) !=
        'null') {
      lastName.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userLastName,
          tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.userProfilePic,
            tableName: DataBaseConstant.tableNameForPersonalInfo) !=
        'null') {
      userPic.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userProfilePic,
          tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.userEmail,
            tableName: DataBaseConstant.tableNameForContactInfo) !=
        'null') {
      email.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userEmail,
          tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.userMobile,
            tableName: DataBaseConstant.tableNameForContactInfo) !=
        'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userMobile,
          tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(
            key: DataBaseConstant.countryCode,
            tableName: DataBaseConstant.tableNameForContactInfo) !=
        'null') {
      countryCode.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.countryCode,
          tableName: DataBaseConstant.tableNameForContactInfo);
    }
  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditButton() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  void clickOnReportingPerson({required int reportingPersonIndex}) {
    // Get.toNamed(Routes.CONTACT_DETAIL);
  }

  void clickOnList({required int listIndex}) {
    if (getEmployeeDetails?[listIndex].menuClick == 'personal') {
      Get.toNamed(Routes.PERSONAL_INFO);
    } else if (getEmployeeDetails?[listIndex].menuClick == 'contact') {
      Get.toNamed(Routes.CONTACT_DETAIL);
    } else if (getEmployeeDetails?[listIndex].menuClick == 'job') {
      Get.toNamed(Routes.JOB_INFO);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'social') {
      Get.toNamed(Routes.SOCIAL_INFO);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'bank') {
      Get.toNamed(Routes.BANK_DETAIL);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'education') {
      Get.toNamed(Routes.EDUCATION);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'experience') {
      Get.toNamed(Routes.EXPERIENCE);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'promotion') {
      Get.toNamed(Routes.PROMOTION);
    } else {
      Get.toNamed(Routes.DOCUMENT);
    }
  }

  Future<void> callingGetEmployeeDetailsApi() async {
    try {
      getEmployeeDetailsModal.value = await CAI.getEmployeeDetailsApi(
          bodyParams: {AK.action: 'getEmployeeProfileMenu'});
      if (getEmployeeDetailsModal.value != null) {
        getEmployeeDetails = getEmployeeDetailsModal.value?.getEmployeeDetails;
      }
    } catch (e) {
      print('e::::::::  $e');
      apiResponseValue.value = false;
    }
  }

}
