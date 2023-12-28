import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class ContactDetailController extends GetxController {

  final count = 0.obs;

  final contactController = TextEditingController();
  final emergencyController = TextEditingController();
  final companyEmailController = TextEditingController();
  final personalEmailController = TextEditingController();
  final currentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

  final mobileNumber = ''.obs;
  final countryCode = ''.obs;

  final valueForEditFiled = false.obs;
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
    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      countryCode.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    contactController.text = '${countryCode.value} ${mobileNumber.value}';

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      // emergencyController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo);
      emergencyController.text = contactController.text;
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      companyEmailController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      personalEmailController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.currentAddress,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      currentAddressController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.currentAddress,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.permanentAddress,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      permanentAddressController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.permanentAddress,tableName: DataBaseConstant.tableNameForContactInfo);
    }


  }

  clickOnBackButton() {
      Get.back();
  }

  void clickOnEditViewButton() {
    valueForEditFiled.value = true;
  }

  void clickOnEditUpdateButton() {
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForContactInfo);
    // valueForEditFiled.value=false;
    Get.back();
  }



}
