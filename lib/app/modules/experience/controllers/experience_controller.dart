import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExperienceController extends GetxController {

  final count = 0.obs;

  final designationController = TextEditingController();
  final companyNameController = TextEditingController();
  final workFromController = TextEditingController();
  final workToController = TextEditingController();
  final locationController = TextEditingController();

  final sendChangeRequestButtonValue = false.obs;


  @override
  void onInit() {
    super.onInit();
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

  void clickOnSendChangeRequestButton() {
    sendChangeRequestButtonValue.value= true;
    Future.delayed(const Duration(seconds: 3),() => sendChangeRequestButtonValue.value=false,);
  }

}
