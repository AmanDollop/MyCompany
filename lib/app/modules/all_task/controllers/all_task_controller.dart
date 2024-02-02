import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/validator/v.dart';
import 'package:http/http.dart'  as http;
import '../../../../api/api_model/task_data_modal.dart';


class AllTaskController extends GetxController {
  final count = 0.obs;
  final menuName = ''.obs;

  final apiResValue = false.obs;
  final createTaskButtonValue = false.obs;

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

  final cardGridTitleTextList = [];

  final cardGridTextColorList = [
    const Color(0xff0717AF),
    const Color(0xff388E3C),
    const Color(0xffE09701),
    const Color(0xff524FFF),
    const Color(0xff825802),
    const Color(0xffCE1212),
  ];

  final getTaskDataModal = Rxn<TaskDataModal>();
  List<CategoryDetails>? taskDataList;
  Map<String, dynamic> bodyParamsForGetTask = {};

  Map<String, dynamic> bodyParamsForAddTask = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      menuName.value = Get.arguments[0];
      await callingGetTaskDataApi();
    }catch(e){
      CM.error();
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

  Future<void> taskSearchOnChange({required String value}) async {
    await callingGetTaskDataApi();
  }

  Future<void> callingGetTaskDataApi() async {
    apiResValue.value = true;
    getTaskDataModal.value = null;
    taskDataList?.clear();
    try{
      bodyParamsForGetTask ={
        AK.action : ApiEndPointAction.getTaskCategory,
        AK.searchTaskCategory : taskSearchController.text.trim().toString()
      };
      getTaskDataModal.value = await CAI.getTaskDataApi(bodyParams: bodyParamsForGetTask);
      if(getTaskDataModal.value!=null){
        taskDataList = getTaskDataModal.value?.categoryDetails;
      }
    }catch(e){
      print('get task api error::::  $e');
      CM.error();
      apiResValue.value=false;
    }
    apiResValue.value=false;
  }

  Future<void> clickOnAddNewTaskButton() async {
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
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600,fontSize: 14.px),
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
                    : () => clickOnCreateTaskButton(addTaskCategoryControllerValue:addTaskCategoryController.text.trim().toString()),
                buttonText: 'Create',
                isLoading: createTaskButtonValue.value,
              ),
              SizedBox(height: 20.px),
            ],
          );
        })
      ],
    ).whenComplete(() {
      createTaskButtonValue.value=false;
      addTaskCategoryController.clear();
    });
  }

  Future<void> clickOnCreateTaskButton({required String addTaskCategoryControllerValue}) async {
    if(key.currentState!.validate()){
      createTaskButtonValue.value = true;
      await callingAddTaskApi(addTaskCategoryControllerValue:addTaskCategoryControllerValue);
    }
  }

  Future<void> callingAddTaskApi({required String addTaskCategoryControllerValue}) async {
    try{
      bodyParamsForAddTask ={
        AK.action : ApiEndPointAction.addTaskCategory,
        AK.taskCategoryName : addTaskCategoryControllerValue,
      };
      http.Response? response = await CAI.addTaskApi(bodyParams: bodyParamsForAddTask);
      if(response != null && response.statusCode == 200){
        createTaskButtonValue.value=false;
        Get.back();
        await callingGetTaskDataApi();
      }else{
        CM.error();
        createTaskButtonValue.value=false;
        Get.back();
      }
    }catch(e){
      print('add task error::: $e');
      CM.error();
      createTaskButtonValue.value=false;
      Get.back();
    }
  }
}
