import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class JobInfoController extends GetxController {
  final count = 0.obs;

  final designationController = TextEditingController();
  final employeeIDController = TextEditingController();
  final employeeTypeController = TextEditingController();
  final joiningDateController = TextEditingController();
  final experienceController = TextEditingController();
  final totalExperienceController = TextEditingController();

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
      designationController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userDesignation,tableName: DataBaseConstant.tableNameForJobInfo);
    }
    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeId,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      employeeIDController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeId,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeType,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      employeeTypeController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.employeeType,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.dateOfJoining,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      joiningDateController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.dateOfJoining,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.branchName,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      experienceController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.branchName,tableName: DataBaseConstant.tableNameForJobInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.departmentName,tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      totalExperienceController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.departmentName,tableName: DataBaseConstant.tableNameForJobInfo);
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
