// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class OtherUserProfileController extends GetxController {

  final count = 0.obs;

  final userId = ''.obs;
  final apiResValue = true.obs;

  Map<String, dynamic> bodyParamsForOtherUserProfileApi ={};

  final userDataModal = Rxn<UserDataModal?>();
  UserDetails? userData;
  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  JobInfo? jobInfo;
  SocialInfo? socialInfo;

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    userId.value = Get.arguments[0];
    await callingGetOtherUserDataApi();
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

  Future<void> clickOnTwitterButton() async {
    if(socialInfo?.twitter != null && socialInfo!.twitter!.isNotEmpty){
      if (!await launcher.launchUrl(
        socialInfo?.twitter ?? '',
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${socialInfo?.twitter ?? ''}');
      }
    }
  }

  Future<void> clickOnLinkedinButton() async {
    if(socialInfo?.linkedin != null && socialInfo!.linkedin!.isNotEmpty){
      if (!await launcher.launchUrl(
        socialInfo?.linkedin ?? '',
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${socialInfo?.linkedin}');
      }
    }
  }

  Future<void> clickOnInstagramButton() async {
    if(socialInfo?.instagram != null && socialInfo!.instagram!.isNotEmpty){
      if (!await launcher.launchUrl(
        socialInfo?.instagram ?? '',
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${socialInfo?.instagram}');
      }
    }
  }

  Future<void> clickOnFacebookButton() async {
    if(socialInfo?.twitter != null && socialInfo!.twitter!.isNotEmpty){
      if (!await launcher.launchUrl(
        socialInfo?.facebook ?? "",
        const LaunchOptions(mode: PreferredLaunchMode.externalNonBrowserApplication),
      )) {
        throw Exception('Could not launch ${socialInfo?.facebook}');
      }
    }
  }

  Future<void> callingGetOtherUserDataApi() async {
    try {
      bodyParamsForOtherUserProfileApi = {
        AK.action: ApiEndPointAction.getOtherUserProfile,
        AK.otherUserId: userId.value
      };
      userDataModal.value = await CAI.getUserDataApi(bodyParams: bodyParamsForOtherUserProfileApi);
      if (userDataModal.value != null) {
        userData = userDataModal.value?.userDetails;
        personalInfo = userData?.personalInfo;
        contactInfo = userData?.contactInfo;
        jobInfo = userData?.jobInfo;
        socialInfo = userData?.socialInfo;
      }
    } catch (e) {
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }
}
