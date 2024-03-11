import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_my_team_member_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class MyTeamController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  late OverlayEntry overlayEntry;

  final getMyTeamMemberModal = Rxn<GetMyTeamMemberModal>();
  List<MyTeam>? myTeamMemberList;
  List<MyTeam> selectedMyTeamMemberList = [];
  Map<String, dynamic> bodyParamsForGetMyTeamMemberApi = {};

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

  Future<void> callingGetMyTeamMemberApi() async {
    try{
      bodyParamsForGetMyTeamMemberApi={
        AK.action : ApiEndPointAction.getTeamMember,
      };
      getMyTeamMemberModal.value = await CAI.getMyTeamMemberApi(bodyParams: bodyParamsForGetMyTeamMemberApi);
      if(getMyTeamMemberModal.value != null){
        myTeamMemberList = getMyTeamMemberModal.value?.myTeam;
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
