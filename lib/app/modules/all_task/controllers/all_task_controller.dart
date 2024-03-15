import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/validator/v.dart';
import 'package:http/http.dart' as http;
import '../../../../api/api_model/task_data_modal.dart';

class AllTaskController extends GetxController {
  final count = 0.obs;
  final menuName = ''.obs;

  final apiResValue = false.obs;
  final createTaskButtonValue = false.obs;
  final hideSearchFieldValue = false.obs;

  final key = GlobalKey<FormState>();
  final taskSearchController = TextEditingController();
  final addTaskCategoryController = TextEditingController();

  final topGridCardTextColorList = [
    const Color(0xff02930D),
    const Color(0xffE09701),
    const Color(0xff0717AF),
  ];

  final topGridCardColorList = [
    const Color(0xffF2FFF3),
    const Color(0xffFFF2D8),
    const Color(0xffDDE0FB),
  ];

  final topGridCardTitleTextList = [
    'Completed Task',
    'Due Task',
    'Today’s Due Task',
  ];

  final topGridCardSubTitleTextList = [];

  final cardIconsList = [
    'assets/icons/watch_icon.png',
    'assets/icons/watch_icon.png',
    'assets/icons/watch_icon.png',
  ];

  final getTaskDataModal = Rxn<TaskDataModal>();
  List<TaskCategory> taskCategoryList = [];
  List<TaskCount>? taskCountList;
  Map<String, dynamic> bodyParamsForGetTask = {};
  final isLastPage = false.obs;
  String limit = '10';
  final offset = 0.obs;

  Map<String, dynamic> bodyParamsForAddTask = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      apiResValue.value = true;
      menuName.value = Get.arguments[0];
      await callingGetTaskDataApi();
    } catch (e) {
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
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

  onRefresh() async {
    CM.unFocusKeyBoard();
    offset.value = 0;
    getTaskDataModal.value = null;
    taskCountList?.clear();
    taskCategoryList.clear();
    isLastPage.value = false;
    await onInit();
  }

  Future<void> taskSearchOnChange({required String value}) async {
    count.value++;
    taskCategoryList.clear();
    offset.value = 0;
    apiResValue.value= true;
    isLastPage.value = false;
    await callingGetTaskDataApi();
  }

  Future<void> callingGetTaskDataApi() async {
    try {
      // getTaskDataModal.value = null;
      // taskCategoryList.clear();
      bodyParamsForGetTask = {
        AK.limit: limit.toString(),
        AK.offset: offset.toString(),
        AK.action: ApiEndPointAction.getTaskCategory,
        AK.search: taskSearchController.text.trim().toString()
      };
      getTaskDataModal.value = await CAI.getTaskDataApi(bodyParams: bodyParamsForGetTask);
      // if (offset.value == 0) {
      //   apiResValue.value = true;
      //   taskCategoryList.clear();
      //   taskCountList?.clear();
      //   isLastPage.value = false;
      // }
      if (getTaskDataModal.value != null) {
        if (getTaskDataModal.value?.taskCategory != null && getTaskDataModal.value!.taskCategory!.isNotEmpty) {
          taskCategoryList.addAll(getTaskDataModal.value?.taskCategory ?? []);
        } else {
          isLastPage.value = true;
        }
      }
    } catch (e) {
      print('get task api error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> clickOnAddNewTaskButton({int? taskCardListViewIndex}) async {
    CM.unFocusKeyBoard();
    if (taskCardListViewIndex != null) {
      addTaskCategoryController.text = taskCategoryList[taskCardListViewIndex].taskCategoryName ?? '';
    }
    await CBS.commonBottomSheet(
      isDismissible: false,
      isFullScreen: true,
      onTap: () => CM.unFocusKeyBoard(),
      children: [
        Obx(() {
          count.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task Category',
                style: Theme.of(Get.context!)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.px),
              ),
              SizedBox(height: 14.px),
              Form(
                key: key,
                child: CW.commonTextField(
                  borderRadius: 6.px,
                  isBorder: true,
                  isSearchLabelText: true,
                  hintText: 'Enter Task Category',
                  controller: addTaskCategoryController,
                  validator: (value) => V.isValid(value: value, title: 'Please enter task category'),
                ),
              ),
              SizedBox(height: 14.px),
              CW.commonElevatedButton(
                onPressed: createTaskButtonValue.value
                    ? () => null
                    : () => taskCardListViewIndex != null
                        ? clickOnUpdateTaskButton(
                            taskCategoryId: taskCategoryList[taskCardListViewIndex].taskCategoryId ?? '',
                            addTaskCategoryControllerValue: addTaskCategoryController.text.trim().toString())
                        : clickOnCreateTaskButton(addTaskCategoryControllerValue: addTaskCategoryController.text.trim().toString()),
                buttonText: taskCardListViewIndex != null
                    ? 'Update Task'
                    : 'Create Task',
                isLoading: createTaskButtonValue.value,
              ),
              SizedBox(height: 20.px),
            ],
          );
        })
      ],
    ).whenComplete(() {
      createTaskButtonValue.value = false;
      addTaskCategoryController.clear();
    });
  }

  Future<void> clickOnCreateTaskButton({required String addTaskCategoryControllerValue}) async {
    CM.unFocusKeyBoard();
    print('addTaskCategoryControllerValue::::: $addTaskCategoryController');
    if (key.currentState!.validate()) {
      createTaskButtonValue.value = true;
      bodyParamsForAddTask.clear();
      bodyParamsForAddTask = {
        AK.action: ApiEndPointAction.addTaskCategory,
        AK.taskCategoryName: addTaskCategoryControllerValue,
      };
      await callingAddTaskApi();
      Get.back();
    }
  }

  Future<void> clickOnUpdateTaskButton({required String taskCategoryId, required String addTaskCategoryControllerValue}) async {
    CM.unFocusKeyBoard();
    print('taskCategoryId:::::: $taskCategoryId');
    if (key.currentState!.validate()) {
      createTaskButtonValue.value = true;
      bodyParamsForAddTask.clear();
      bodyParamsForAddTask = {
        AK.action: ApiEndPointAction.addTaskCategory,
        AK.taskCategoryId: taskCategoryId,
        AK.taskCategoryName: addTaskCategoryControllerValue,
      };
      await callingAddTaskApi();
      Get.back();
    }
  }

  Future<void> callingAddTaskApi() async {
    try {
      http.Response? response = await CAI.addTaskApi(bodyParams: bodyParamsForAddTask);
      if (response != null && response.statusCode == 200) {
        createTaskButtonValue.value = false;
        apiResValue.value = true;
        offset.value = 0;
        isLastPage.value = false;
        getTaskDataModal.value = null;
        taskCategoryList.clear();
        taskCountList?.clear();
        await callingGetTaskDataApi();
      } else {
        CM.error();
        createTaskButtonValue.value = false;
      }
    } catch (e) {
      print('add task error::: $e');
      CM.error();
      createTaskButtonValue.value = false;
    }
  }

  Future<void> clickOnTaskDeleteButton({required int taskCardListViewIndex}) async {
    CM.unFocusKeyBoard();
    print('::::  ${taskCategoryList[taskCardListViewIndex].taskCategoryId}');
    CD.commonIosDeleteConfirmationDialog(
      clickOnCancel: () => Get.back(),
      clickOnDelete: () async {
        bodyParamsForAddTask.clear();
        bodyParamsForAddTask = {
          AK.action: ApiEndPointAction.deleteTaskCategory,
          AK.taskCategoryId: taskCategoryList[taskCardListViewIndex].taskCategoryId ?? ''
        };
        await callingAddTaskApi();
        Get.back();
      },
    );
  }

  Future<void> clickOnTaskCard({required int taskCardListViewIndex}) async {
    CM.unFocusKeyBoard();
    if (taskCategoryList[taskCardListViewIndex].taskCategoryId != null && taskCategoryList[taskCardListViewIndex].taskCategoryId!.isNotEmpty) {
      await Get.toNamed(Routes.SUB_TASK, arguments: [
        taskCategoryList[taskCardListViewIndex].taskCategoryId,
        taskCategoryList[taskCardListViewIndex].taskCategoryName
      ]);
      offset.value = 0;
      isLastPage.value = false;
      taskCategoryList.clear();
      onInit();
    } else {
      CM.showSnackBar(message: 'Sub task not found');
    }
  }

  Future<void> onLoadMore() async {
    CM.unFocusKeyBoard();
    offset.value = offset.value + 1;
    try {
      if (int.parse(limit) <= taskCategoryList.length) {
        await callingGetTaskDataApi();
      }
    } catch (e) {
      CM.error();
    }
  }
}
