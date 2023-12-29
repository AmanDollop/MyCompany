import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class JobInfoController extends GetxController {
  final count = 0.obs;

  final designation = ''.obs;
  final employeeID = ''.obs;
  final employeeType = ''.obs;
  final joiningDate = ''.obs;

  final apiResponseValue = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
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

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userDesignation,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      designation.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userDesignation,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeId,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      employeeID.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeId,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeTypeView,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      employeeType.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeTypeView,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.dateOfJoining,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      joiningDate.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.dateOfJoining,tableName: DataBaseConstant.tableNameForJobInfo);
    }

  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditButton() {
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForJobInfo);
    Get.back();
  }

}
