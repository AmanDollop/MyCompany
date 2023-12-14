import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';

class SignUpController extends GetxController {

  final count = 0.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final selectYourDepartmentController = TextEditingController();
  final selectYourBranchController = TextEditingController();
  final shiftTimeController = TextEditingController();
  final joiningDateController = TextEditingController();
  final designationController = TextEditingController();
  final  emailController = TextEditingController();
  final mobileNumberController = TextEditingController();

  final genderText= ['Male','Female'].obs;
  final genderIndexValue = '-1'.obs;

  final getData = ''.obs;


  @override
  void onInit() {
    super.onInit();
    // getData.value = Get.parameters['branchIndexValue.value']??'';
    // print('getData.value:::::  ${getData.value}');
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
    CM.unFocusKeyBoard();
    Get.back();
  }

  void clickOnProfileButton() {
    CM.unFocusKeyBoard();
    CBS.commonBottomSheetForImagePicker();
  }

  Future<void> clickOnSelectYourBranchTextField() async {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.SELECT_BRANCE,arguments: [getData.value])?.then((value) {
      if(value != null){
        getData.value = value;
        selectYourBranchController.text = getData.value;
      }
    });
  }

  Future<void> clickOnShiftTimeTextField() async {
    CM.unFocusKeyBoard();
    TimeOfDay? pickedTime = await CDT.androidTimePicker(context: Get.context!);
    if(pickedTime != null){
      shiftTimeController.text = '${pickedTime.hour}:${pickedTime.minute}:${pickedTime.period.name.toUpperCase()}';
    }
  }

  Future<void> clickOnJoiningDateTextField() async {
    CM.unFocusKeyBoard();
    DateTime? pickedDate = await CDT.androidDatePicker(context: Get.context!,);
    if(pickedDate != null) {
      joiningDateController.text = '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
    }
  }

  void clickOnRegisterButton() {
    CM.unFocusKeyBoard();
    Get.back();
  }

}
