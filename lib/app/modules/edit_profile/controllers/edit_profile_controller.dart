import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class EditProfileController extends GetxController {

  final count = 0.obs;

  final image = Rxn<File?>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final designationController = TextEditingController();
  final userPic = ''.obs;
  final countryCode = ''.obs;
  final mobileNumber = ''.obs;
  final developerType = ''.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    await setDefaultData();
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

  ImageProvider selectImage() {
    if (image.value != null) {
      return FileImage(image.value!);
    } else if(userPic.value != '' && userPic.value.isNotEmpty){
      return NetworkImage('${AU.baseUrlAllApisImage}${userPic.value}');
    }else {
      return const AssetImage('assets/images/profile.png');
    }
  }

  void clickOnProfileButton() {
    CM.unFocusKeyBoard();
    CBS.commonBottomSheetForImagePicker(
      clickOnTakePhoto: () => clickOnTakePhoto(),
      clickOnChooseFromLibrary: () => clickOnChooseFromLibrary(),
      clickOnRemovePhoto: () => clickOnRemovePhoto(),
    );
  }

  Future<void> clickOnTakePhoto() async {
    Get.back();
    image.value = await IP.pickImage(isCropper: true,);
  }

  Future<void> clickOnChooseFromLibrary() async {
    Get.back();
    image.value = await IP.pickImage(isCropper: true,pickFromGallery: true);
  }

  void clickOnRemovePhoto(){
    Get.back();
    image.value = null;
  }

  void clickOnSaveButton() {
    Get.back();
    Get.back();
  }

  Future<void> setDefaultData() async {
    if(await DataBaseHelper().getParticularData(key: 'user_first_name',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      firstNameController.text = await DataBaseHelper().getParticularData(key: 'user_first_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }
    if(await DataBaseHelper().getParticularData(key: 'user_last_name',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      lastNameController.text = await DataBaseHelper().getParticularData(key: 'user_last_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_profile_pic',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userPic.value = await DataBaseHelper().getParticularData(key: 'user_profile_pic',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_email',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      emailController.text = await DataBaseHelper().getParticularData(key: 'user_email',tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_mobile',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: 'user_mobile',tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'country_code',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      countryCode.value = await DataBaseHelper().getParticularData(key: 'country_code',tableName: DataBaseConstant.tableNameForContactInfo);
    }


    if(await DataBaseHelper().getParticularData(key: 'user_designation',tableName: DataBaseConstant.tableNameForJobInfo) != 'null') {
      designationController.text = await DataBaseHelper().getParticularData(key: 'user_designation',tableName: DataBaseConstant.tableNameForJobInfo);
    }


    if(countryCode.value!='null'&&countryCode.value.isNotEmpty && mobileNumber.value!='null'&&mobileNumber.value.isNotEmpty) {
      mobileNumberController.text = '${countryCode.value} ${mobileNumber.value}';
    }
  }

}
