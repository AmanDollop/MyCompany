import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_my_team_member_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MyTeamController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  final userDataFromLocalDataBase =''.obs;
  UserDetails? userData;
  PersonalInfo? personalInfo;
  JobInfo? jobInfo;

  late OverlayEntry overlayEntry;

  final getMyTeamMemberModal = Rxn<GetMyTeamMemberModal>();
  List<MyTeam>? myTeamMemberList;
  List<MyTeam> selectedMyTeamMemberList = [];
  Map<String, dynamic> bodyParamsForGetMyTeamMemberApi = {};

  MyTeam? selfDataForMyTeamMember;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetMyTeamMemberApi();
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

  Future<void> setDefaultUserData() async {
    try{
      userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);
      userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;
      personalInfo = userData?.personalInfo;
      jobInfo = userData?.jobInfo;
      selfDataForMyTeamMember = MyTeam(
        branchId: jobInfo?.branchId ?? '',
        departmentId: jobInfo?.departmentId ?? '',
        shortName: personalInfo?.shortName ?? '',
        userDesignation: jobInfo?.userDesignation ?? '',
        userFullName: personalInfo?.userFullName ?? '',
        userId: personalInfo?.userId ?? '',
        userProfilePic: personalInfo?.userProfilePic ?? '',
      );
      count.value++;
    }catch(e){
      print('error from user data :::: $e');
      apiResValue.value = false;
    }
  }

  Future<void> callingGetMyTeamMemberApi() async {
    try{
      bodyParamsForGetMyTeamMemberApi={
        AK.action : ApiEndPointAction.getTeamMember,
      };
      getMyTeamMemberModal.value = await CAI.getMyTeamMemberApi(bodyParams: bodyParamsForGetMyTeamMemberApi);
      if(getMyTeamMemberModal.value != null){
        await setDefaultUserData();
        myTeamMemberList = getMyTeamMemberModal.value?.myTeam;
        if(selfDataForMyTeamMember != null) {
          myTeamMemberList?.insert(0, selfDataForMyTeamMember!);
          selectedMyTeamMemberList.insert(0, selfDataForMyTeamMember!);
        }
      }
    }catch(e){
      CM.error();
      apiResValue.value = false;
      print('GetMyTeamMemberApi::::: error::::  $e');
    }
    apiResValue.value = false;
  }

  void clickOnMyTeamCards({required int myTeamCardIndex}) {
    if(myTeamMemberList?[myTeamCardIndex] != null) {
      if(selectedMyTeamMemberList.contains(myTeamMemberList![myTeamCardIndex])){
        selectedMyTeamMemberList.remove(myTeamMemberList![myTeamCardIndex]);
      }else{
        selectedMyTeamMemberList.add(myTeamMemberList![myTeamCardIndex]);
      }
    }
    count.value++;
  }

  void clickOnAddButton() {
    Get.back(result: selectedMyTeamMemberList);
  }

}
