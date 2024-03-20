import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_task_time_line_modal.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class TaskTimeLineController extends GetxController {

  final count = 0.obs;
  TaskDetails? subTaskList;

  final scrollController = ScrollController();

  final sendMessageController = TextEditingController();
  FocusNode focusNodeSendMessage = FocusNode();

  final apiResValue = true.obs;

  final getTaskTimeLineModal = Rxn<GetTaskTimeLineModal>();
  // List<TimeLine>? timeLineList;

  Map<DateTime, List<TimeLine>> timeLineList = {};

  Map<String,dynamic> bodyParamsForGetTaskTimeLine = {};

  Map<String,dynamic> bodyParamsForAddTaskTimeLine = {};

  late OverlayEntry overlayEntry;


  @override
  Future<void> onInit() async {
    super.onInit();
    subTaskList = Get.arguments[0];
    await callingGetSubTaskApi();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        count.value=0;
        await callingGetSubTaskApi();
        count.value++;
      }
    });
  }

  Stream<Map<DateTime, List<TimeLine>>> counterStream() async* {
    while (true) {
      yield await callingGetSubTaskApi();
      apiResValue.value = false;
      await Future.delayed(const Duration(milliseconds: 1000));
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

  void clickOnBackButton() {
    Get.back();
  }

  Future<Map<DateTime, List<TimeLine>>> callingGetSubTaskApi() async {
    try {
      bodyParamsForGetTaskTimeLine = {
          AK.action: ApiEndPointAction.getTimeline,
          AK.taskId: subTaskList?.taskId ?? '',
        };
      getTaskTimeLineModal.value = await CAI.getTaskTimeLineApi(bodyParams: bodyParamsForGetTaskTimeLine);
      if (getTaskTimeLineModal.value != null) {
        timeLineList = groupMessagesByDay(messagesDetailData: getTaskTimeLineModal.value?.timeLine ?? []);
      }
    } catch (e) {
      print('get task time line api error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    // apiResValue.value = false;
    return timeLineList;
  }

  Map<DateTime, List<TimeLine>> groupMessagesByDay({required List<TimeLine> messagesDetailData}) {

    Map<DateTime, List<TimeLine>> groupedMessages = {};

    for (var message in messagesDetailData) {
      DateTime date = DateTime(DateTime.parse('${message.taskTimelineDate}').year, DateTime.parse('${message.taskTimelineDate}').month, DateTime.parse('${message.taskTimelineDate}').day);

      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }

      groupedMessages[date]!.add(message);
    }
    return reverseGroupedMessages(groupedMessages: groupedMessages);
  }

  Map<DateTime, List<TimeLine>> reverseGroupedMessages({required Map<DateTime, List<TimeLine>> groupedMessages}) {
    List<MapEntry<DateTime, List<TimeLine>>> entries = groupedMessages.entries.toList();
    entries = entries.reversed.toList();

    Map<DateTime, List<TimeLine>> reversedGroupedMessages = {};
    for (var entry in entries) {
      reversedGroupedMessages[entry.key] = entry.value;
    }
    return reversedGroupedMessages;
  }

  void clickOnMessageView({required String messageId}) {
    CD.commonIosDeleteConfirmationDialog(clickOnCancel: () => Get.back(), clickOnDelete: () => clickOnDeleteMessageButton(messageId: messageId),);
  }

  Future<void> clickOnDeleteMessageButton({required String messageId}) async {
    bodyParamsForAddTaskTimeLine = {
      AK.action: ApiEndPointAction.deleteTimeline,
      AK.taskTimelineId: messageId,
    };
    await callingAddTaskTimeLineApi();
    Get.back();
  }

  Future<void> clickOnSendMessageButton() async {
    if(sendMessageController.text.isNotEmpty){
      bodyParamsForAddTaskTimeLine = {
        AK.action: ApiEndPointAction.addTaskTimeline,
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
