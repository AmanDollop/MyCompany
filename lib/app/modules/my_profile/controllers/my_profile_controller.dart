// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/get_employee_details_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import '../../../../api/api_model/user_data_modal.dart';

class MyProfileController extends GetxController {
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

  final profileMenuDetails= ''.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await BottomSheetForOTP.callingGetUserDataApi();
      if(await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForProfileMenu)) {
        await callingGetEmployeeDetailsApi();
      }
      await setDefaultData();
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

    userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

    userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;

    personalInfo=userData?.personalInfo;
    contactInfo=userData?.contactInfo;
    jobInfo=userData?.jobInfo;
    socialInfo=userData?.socialInfo;

    profileMenuDetails.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.profileMenuDetails, tableName: DataBaseConstant.tableNameForProfileMenu);
    getEmployeeDetails = GetEmployeeDetailsModal.fromJson(jsonDecode(profileMenuDetails.value)).getEmployeeDetails;

      userFullName.value = personalInfo?.userFullName ?? '';

      userShortName.value = personalInfo?.shortName??'';

      userPic.value = personalInfo?.userProfilePic??'';

      email.value = contactInfo?.userEmail??'';

      mobileNumber.value = contactInfo?.userMobile??'';

      countryCode.value = contactInfo?.countryCode??'';

      developer.value = jobInfo?.userDesignation??'';

      twitterUrl.value = socialInfo?.twitter??'';

      linkedinUrl.value = socialInfo?.linkedin??'';

      instagramUrl.value = socialInfo?.instagram??'';

      facebookUrl.value = socialInfo?.facebook??'';

    await callingGetEmployeeDetailsApi();

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

    dynamic arguments = [getEmployeeDetails?[listIndex].accessType,getEmployeeDetails?[listIndex].isChangeable,getEmployeeDetails?[listIndex].profileMenuName];

    if (getEmployeeDetails?[listIndex].menuClick == 'personal') {
      Get.toNamed(Routes.PERSONAL_INFO,arguments:arguments);
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'contact') {
      Get.toNamed(Routes.CONTACT_DETAIL,arguments:arguments);
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'job') {
      await Get.toNamed(Routes.JOB_INFO,arguments:arguments);
      apiResponseValue.value = true;
      onInit();
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'social') {
      await Get.toNamed(Routes.ADD_SOCIAL_INFO,arguments:arguments);
      apiResponseValue.value = true;
      onInit();
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'bank') {
      if(AC.isConnect.value){
        Get.toNamed(Routes.BANK_DETAIL,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'education') {
      if(AC.isConnect.value) {
        Get.toNamed(Routes.EDUCATION,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'experience') {
      if(AC.isConnect.value) {
        Get.toNamed(Routes.EXPERIENCE,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'promotion') {
      if(AC.isConnect.value) {
        Get.toNamed(Routes.PROMOTION,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'document') {
      if(AC.isConnect.value) {
        Get.toNamed(Routes.DOCUMENT,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'shift_detail') {
      Get.toNamed(Routes.SHIFT_DETAIL,arguments:arguments);
    }
    else if (getEmployeeDetails?[listIndex].menuClick == 'attendance_face') {
      if(AC.isConnect.value) {
        Get.toNamed(Routes.MY_FACE_ATTENDANCE,arguments:arguments);
      }else{
        CM.noInternet();
      }
    }
    else {
      CM.showSnackBar(message: 'Comming soon.');
    }
  }

  Future<void> callingGetEmployeeDetailsApi() async {
    try {
      getEmployeeDetailsModal.value = await CAI.getEmployeeDetailsApi(bodyParams: {AK.action: ApiEndPointAction.getEmployeeProfileMenu});
      if (getEmployeeDetailsModal.value != null) {
        getEmployeeDetails = getEmployeeDetailsModal.value?.getEmployeeDetails;
        if(await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForProfileMenu)) {
          await DataBaseHelper().insertInDataBase(data: {'getEmployeeDetails':json.encode(getEmployeeDetailsModal.value)}, tableName: DataBaseConstant.tableNameForProfileMenu);
        }
        else{
          await DataBaseHelper().upDateDataBase(data: {'getEmployeeDetails':json.encode(getEmployeeDetailsModal.value)}, tableName: DataBaseConstant.tableNameForProfileMenu);
        }
      }
    } catch (e) {
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

  void clickOnReportingPersonCard({required int listIndex}) {}

}
