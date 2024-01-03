import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class ExperienceController extends GetxController {

  final key = GlobalKey<FormState>();
  final count = 0.obs;

  final designationController = TextEditingController();
  final companyNameController = TextEditingController();
  final joiningDateController = TextEditingController();
  final releaseDateController = TextEditingController();
  final locationController = TextEditingController();

  final sendChangeRequestButtonValue = false.obs;

  Map<String, dynamic> bodyParamsForUpdateExperienceDetails = {};

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
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

  Future<void> clickOnJoiningDateTextField() async {
    CM.unFocusKeyBoard();

    await CDT.iosPicker(
        context: Get.context!,
        dateController: joiningDateController,
        initialDate: joiningDateController.text.isNotEmpty
            ? DateFormat('dd MMM yyyy').parse(joiningDateController.text)
            : DateTime.now());
  }

  Future<void> clickOnReleaseDateTextField() async {
    CM.unFocusKeyBoard();

    await CDT.iosPicker(
        context: Get.context!,
        dateController: releaseDateController,
        initialDate: releaseDateController.text.isNotEmpty
            ? DateFormat('dd MMM yyyy').parse(releaseDateController.text)
            : DateTime.now());

  }

  Future<void> clickOnSendChangeRequestButton() async {
    if(key.currentState!.validate()){
      sendChangeRequestButtonValue.value= true;
      await callingExperienceApi();
    }
  }

  Future<void> callingExperienceApi() async {
    try{
      bodyParamsForUpdateExperienceDetails={
        AK.action:'addExperience',
        AK.experienceId : '1',
        AK.designation : designationController.text.trim().toString(),
        AK.companyName : companyNameController.text.trim().toString(),
        AK.joiningDate : joiningDateController.text.trim().toString(),
        AK.releaseDate : releaseDateController.text.trim().toString(),
        AK.companyLocation : locationController.text.trim().toString(),
      };
      http.Response? response =  await CAI.updateUserControllerApi(bodyParams: bodyParamsForUpdateExperienceDetails);
      if(response != null){
        if(response.statusCode ==200){
          Get.back();
        }else{
          CM.error();
          sendChangeRequestButtonValue.value = false;
        }
      }else{
        CM.error();
        sendChangeRequestButtonValue.value = false;
      }
    }catch(e){
      CM.error();
      sendChangeRequestButtonValue.value = false;
    }
  }

}
