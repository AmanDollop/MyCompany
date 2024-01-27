import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/experience_modal.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class AddExperienceController extends GetxController {

  final count = 0.obs;

  final key = GlobalKey<FormState>();

  final designationController = TextEditingController();
  final companyNameController = TextEditingController();
  final joiningDateController = TextEditingController();
  final releaseDateController = TextEditingController();
  final locationController = TextEditingController();
  final remarkController = TextEditingController();
  final sendChangeRequestButtonValue = false.obs;

  Map<String, dynamic> bodyParamsForUpdateExperienceDetails = {};

  final profileMenuName = ''.obs;

  GetExperienceDetails? getExperienceDetails;
  final experienceId = ''.obs;


  @override
  void onInit() {
    super.onInit();
    profileMenuName.value = Get.arguments[0];
    if(profileMenuName.value!='Add Experience'){
      getExperienceDetails = Get.arguments[1];
      setDefaultData();
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

  void setDefaultData() {
    designationController.text = getExperienceDetails?.designation ?? 'Designation not found!';
    companyNameController.text = getExperienceDetails?.companyName ?? 'Company name not found!';
    joiningDateController.text = getExperienceDetails?.joiningDate ?? 'Joining date not found!';
    releaseDateController.text = getExperienceDetails?.releaseDate ?? 'Release date not found!';
    locationController.text = getExperienceDetails?.companyLocation ?? 'Company location not found!';
    remarkController.text = getExperienceDetails?.remark ?? 'Remark not found!';
    experienceId.value = getExperienceDetails?.experienceId ?? '';
  }

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

  Future<void> clickOnSaveButton() async {
    if(key.currentState!.validate()){
      sendChangeRequestButtonValue.value= true;
      await callingExperienceApiAdd();
    }
  }

  Future<void> callingExperienceApiAdd() async {
    try{
      bodyParamsForUpdateExperienceDetails={
        AK.action : ApiEndPointAction.addExperience,
        AK.experienceId : experienceId.value,
        AK.designation : designationController.text.trim().toString(),
        AK.companyName : companyNameController.text.trim().toString(),
        AK.joiningDate : joiningDateController.text.trim().toString(),
        AK.releaseDate : releaseDateController.text.trim().toString(),
        AK.companyLocation : locationController.text.trim().toString(),
        AK.remark : remarkController.text.trim().toString(),
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
