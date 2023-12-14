import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class SearchCompanyController extends GetxController {

  final count = 0.obs;
  final searchController = TextEditingController();

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

  void clickOnCompany({required int index}) {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.LOGIN);
  }

}
