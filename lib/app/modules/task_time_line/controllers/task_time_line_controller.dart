import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_task_time_line_modal.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class TaskTimeLineController extends GetxController {

  final count = 0.obs;

  TaskDetails? subTaskList;

  final sendMessageController = TextEditingController();

  List<bool> t =[
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
  ];

  final apiResValue = true.obs;

  final getTaskTimeLineModal = Rxn<GetTaskTimeLineModal>();
  List<TimeLine>? timeLineList;
  Map<String,dynamic> bodyParamsForGetTaskTimeLine = {};

  Map<String,dynamic> bodyParamsForAddTaskTimeLine = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    subTaskList = Get.arguments[0];
    await callingGetSubTaskApi();
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

  Future<void> callingGetSubTaskApi() async {
    try {
      count.value=0;
      bodyParamsForGetTaskTimeLine = {
          AK.action: ApiEndPointAction.getTimeline,
          // AK.taskId:  '69',
          AK.taskId: subTaskList?.taskId ?? '',
        };
      getTaskTimeLineModal.value = await CAI.getTaskTimeLineApi(bodyParams: bodyParamsForGetTaskTimeLine);
      if (getTaskTimeLineModal.value != null) {
        timeLineList = getTaskTimeLineModal.value?.timeLine;
        print('getTaskTimeLineModal.value?.isTaskTimeLineActive::: ${getTaskTimeLineModal.value?.isTaskTimeLineActive}');
        count.value++;
      }
    } catch (e) {
      print('get task time line api error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  void clickOnMessageView({required int index}) {
    CD.commonIosDeleteConfirmationDialog(clickOnCancel: () => Get.back(), clickOnDelete: () => clickOnDeleteMessageButton(),);
  }

  void clickOnDeleteMessageButton() {
    Get.back();
  }

  Future<void> clickOnSendMessageButton() async {
    if(sendMessageController.text.isNotEmpty){
      bodyParamsForAddTaskTimeLine = {
        AK.action: ApiEndPointAction.addTaskTimeline,
        // AK.taskId:  '69',
        AK.taskId: subTaskList?.taskId ?? '',
        AK.taskTimelineStatus: subTaskList?.taskStatus ?? '',
        AK.taskTimelineDate: '${DateTime.now()}',
        AK.taskTimelineDescription: sendMessageController.text.trim().toString(),
      };
      await callingAddTaskTimeLineApi();
    }
  }

  Future<void> callingAddTaskTimeLineApi() async {
    try {
      http.Response? response = await CAI.addTaskApi(bodyParams: bodyParamsForAddTaskTimeLine);
      if (response != null && response.statusCode == 200) {
        sendMessageController.clear();
        await callingGetSubTaskApi();
      } else {
        CM.error();
        // createTaskButtonValue.value = false;
      }
    } catch (e) {
      print('add task error::: $e');
      CM.error();
      // createTaskButtonValue.value = false;
    }
  }


}
