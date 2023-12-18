import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';

class EditProfileController extends GetxController {

  final count = 0.obs;

  final image = Rxn<File?>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final designationController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
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
    } else {
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
  }


}
