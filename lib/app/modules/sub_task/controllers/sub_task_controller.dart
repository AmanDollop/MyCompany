import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class SubTaskController extends GetxController {

  final count = 0.obs;
  final taskId = ''.obs;
  final taskName = 'Task Name'.obs;
  final apiResValue = false.obs;
  final switchValue = false.obs;

  final taskSearchController = TextEditingController();

  final filterGridCardTitleTextList = [
    'Pending',
    'In Progress',
    'Completed',
    'On Hold',
    'Cancelled',
  ];

  final filterValueList = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      apiResValue.value=true;
      taskId.value = Get.arguments[0];
      taskName.value = Get.arguments[1];
    }catch(e){
      apiResValue.value=false;
    }
    apiResValue.value=false;
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

  Future<void> subTaskSearchOnChange({required String value}) async {}

  void clickOnCard({required int index}) {
    Get.toNamed(Routes.ADD_SUB_TASK,arguments: ['Update Sub Task']);
  }

  void clickOnAddNewSubTaskButton() {
    Get.toNamed(Routes.ADD_SUB_TASK,arguments: ['Add Sub Task']);
  }

}
