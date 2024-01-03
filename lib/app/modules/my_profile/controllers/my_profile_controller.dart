// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_employee_details_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MyProfileController extends GetxController {
  final count = 0.obs;

  final userPic = ''.obs;
  final userFullName = ''.obs;
  final userShortName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final countryCode = ''.obs;
  final developer = ''.obs;


  final twitterUrl = ''.obs;
  final linkedinUrl = ''.obs;
  final instagramUrl = ''.obs;
  final facebookUrl = ''.obs;

  final titleList = [
    'Take Order',
    'Sales Summery',
    'Leave Tracker',
    'Assets',
    'My Expense',
  ].obs;

  final getEmployeeDetailsModal = Rxn<GetEmployeeDetailsModal>();
  List<GetEmployeeDetails>? getEmployeeDetails;

  final apiResponseValue = true.obs;
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;


  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await BottomSheetForOTP.callingGetUserDataApi();
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
    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userFullName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userFullName.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userFullName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.shortName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userShortName.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.shortName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userProfilePic, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userPic.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userProfilePic, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      email.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      countryCode.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode, tableName: DataBaseConstant.tableNameForContactInfo);

    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userDesignation,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      developer.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userDesignation,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.twitter,tableName: DataBaseConstant.tableNameForSocialInfo) != 'null') {
      twitterUrl.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.twitter,tableName: DataBaseConstant.tableNameForSocialInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.linkedin,tableName: DataBaseConstant.tableNameForSocialInfo) != 'null') {
      linkedinUrl.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.linkedin,tableName: DataBaseConstant.tableNameForSocialInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.instagram,tableName: DataBaseConstant.tableNameForSocialInfo) != 'null') {
      instagramUrl.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.instagram,tableName: DataBaseConstant.tableNameForSocialInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.facebook,tableName: DataBaseConstant.tableNameForSocialInfo) != 'null') {
      facebookUrl.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.facebook,tableName: DataBaseConstant.tableNameForSocialInfo);
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

  Future<void> clickOnList({required int listIndex}) async {
    if (getEmployeeDetails?[listIndex].menuClick == 'personal') {
      Get.toNamed(Routes.PERSONAL_INFO,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    } else if (getEmployeeDetails?[listIndex].menuClick == 'contact') {
      Get.toNamed(Routes.CONTACT_DETAIL,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    } else if (getEmployeeDetails?[listIndex].menuClick == 'job') {
      Get.toNamed(Routes.JOB_INFO,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'social') {
      await Get.toNamed(Routes.ADD_SOCIAL_INFO,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
      apiResponseValue.value = true;
      onInit();
    }else if (getEmployeeDetails?[listIndex].menuClick == 'bank') {
      Get.toNamed(Routes.BANK_DETAIL,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'education') {
      Get.toNamed(Routes.EDUCATION,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'experience') {
      Get.toNamed(Routes.EXPERIENCE,arguments: [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName]);
    }else if (getEmployeeDetails?[listIndex].menuClick == 'promotion') {
      Get.toNamed(Routes.PROMOTION);
    } else {
      Get.toNamed(Routes.DOCUMENT);
    }
  }

  Future<void> callingGetEmployeeDetailsApi() async {
    try {
      getEmployeeDetailsModal.value = await CAI.getEmployeeDetailsApi(bodyParams: {AK.action: 'getEmployeeProfileMenu'});
      if (getEmployeeDetailsModal.value != null) {
        getEmployeeDetails = getEmployeeDetailsModal.value?.getEmployeeDetails;
      }
    } catch (e) {
      print('e::::::::  $e');
      apiResponseValue.value = false;
    }
  }

  Future<void> clickOnTwitterButton() async {
    if(twitterUrl.isNotEmpty){
      if (!await launcher.launchUrl(
        twitterUrl.value,
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${twitterUrl.value}');
      }
    }else{
      CM.showSnackBar(message: 'Please add twitter url');
      await Get.toNamed(Routes.ADD_SOCIAL_INFO);
      apiResponseValue.value = true;
      onInit();
    }
  }

  Future<void> clickOnLinkedinButton() async {
    if(linkedinUrl.value.isNotEmpty){
      if (!await launcher.launchUrl(
        linkedinUrl.value,
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${linkedinUrl.value}');
      }
    }else{
      CM.showSnackBar(message: 'Please add linkedin url');
      await Get.toNamed(Routes.ADD_SOCIAL_INFO);
      apiResponseValue.value = true;
      onInit();
    }
  }

  Future<void> clickOnInstagramButton() async {
    if(instagramUrl.value.isNotEmpty){
      if (!await launcher.launchUrl(
        instagramUrl.value,
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${instagramUrl.value}');
      }
    }else{
      CM.showSnackBar(message: 'Please add instagram url');
      await Get.toNamed(Routes.ADD_SOCIAL_INFO);
      apiResponseValue.value = true;
      onInit();
    }
  }

  Future<void> clickOnFacebookButton() async {
    if(facebookUrl.value.isNotEmpty){
      if (!await launcher.launchUrl(
        facebookUrl.value,
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${facebookUrl.value}');
      }
    }else{
      CM.showSnackBar(message: 'Please add facebook url');
      await Get.toNamed(Routes.ADD_SOCIAL_INFO);
      apiResponseValue.value = true;
      onInit();
    }
  }

  Future<void> clickOnEditSocialInfoButton() async {
    await Get.toNamed(Routes.ADD_SOCIAL_INFO);
    apiResponseValue.value = true;
    onInit();
  }

}
