import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ContactDetailController extends GetxController {

  final count = 0.obs;

  final contactController = TextEditingController();
  final emergencyController = TextEditingController();
  final companyEmailController = TextEditingController();
  final personalEmailController = TextEditingController();
  final currentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

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

  void clickOnEditButton() {
    Get.back();
  }
}
