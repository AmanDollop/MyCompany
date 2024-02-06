import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/sub_task_filter_data_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class SubTaskController extends GetxController {

  final count = 0.obs;
  final taskId = ''.obs;
  final taskName = 'Task Name'.obs;
  final apiResValue = false.obs;
  final switchValue = false.obs;

  final taskSearchController = TextEditingController();

  final filterValueList = [].obs;

  final getSubTaskFilterDataModal = Rxn<SubTaskFilterDataModal>();
  List<TaskStatus>? subTaskFilterList;
  Map<String, dynamic> bodyParamsForGetSubTaskFilter = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      apiResValue.value=true;
      taskId.value = Get.arguments[0];
      taskName.value = Get.arguments[1];
      await callingGetTaskDataApi();
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

  void clickOnSubTaskFilterCard({required int index}) {
    count.value = 0;
    if(filterValueList.contains(subTaskFilterList?[index].taskStatusName)){
      print('11111:::  $filterValueList');
      filterValueList.removeAt(index);
      filterValueList.insert(index, 0);
    }else{
      print('2222::: $filterValueList');
      filterValueList.removeAt(index);
      filterValueList.insert(index, subTaskFilterList?[index].taskStatusName);
    }

    count.value++;
  }

  void clickOnCard({required int index}) {
    Get.toNamed(Routes.ADD_SUB_TASK,arguments: ['Update Sub Task']);
  }

  Future<void> callingGetTaskDataApi() async {
    try {
      apiResValue.value = true;
      getSubTaskFilterDataModal.value = null;
      subTaskFilterList?.clear();
      bodyParamsForGetSubTaskFilter = {
        AK.action: ApiEndPointAction.getTaskStatus,
      };
      getSubTaskFilterDataModal.value = await CAI.getSubTaskFilterDataApi(bodyParams: bodyParamsForGetSubTaskFilter);
      if (getSubTaskFilterDataModal.value != null) {
        subTaskFilterList = getSubTaskFilterDataModal.value?.taskStatus;
        subTaskFilterList?.forEach((element) {
          if(element.taskStatusName == 'Pending'){
            filterValueList.add(element.taskStatusName);
          }else if(element.taskStatusName == 'In Progress'){
            filterValueList.add(element.taskStatusName);
          } else if(element.taskStatusName == 'On Hold'){
            filterValueList.add(element.taskStatusName);
          } else {
            filterValueList.add(count);
          }
        });
      }
    } catch (e) {
      print('get sub task api error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  void clickOnAddNewSubTaskButton() {
    Get.toNamed(Routes.ADD_SUB_TASK,arguments: ['Add Sub Task']);
  }

}



