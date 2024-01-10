import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

import '../../../../api/api_model/user_data_modal.dart';

class JobInfoController extends GetxController {
  final count = 0.obs;

  final userDataFromLocalDataBase =''.obs;

  UserDetails? userData;

  JobInfo? jobInfo;

  final designation = ''.obs;
  final employeeID = ''.obs;
  final employeeType = ''.obs;
  final joiningDate = ''.obs;

  final apiResponseValue = true.obs;


  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
    await setDefaultData();
    apiResponseValue.value = false;
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

  Future<void> setDefaultData() async {

    userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

    userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;

    jobInfo=userData?.jobInfo;
    
      designation.value = jobInfo?.userDesignation??'';

      employeeID.value = jobInfo?.employeeId??'';

      employeeType.value = jobInfo?.employeeTypeView??'';

      joiningDate.value = jobInfo?.dateOfJoining??'';

  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditButton() {
    Get.back();
  }

}
