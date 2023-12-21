import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';

class SignUpController extends GetxController {
  final count = 0.obs;

  final image = Rxn<File?>();

  final key = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final selectYourDepartmentController = TextEditingController();
  final selectYourBranchController = TextEditingController();
  final shiftTimeController = TextEditingController();
  final joiningDateController = TextEditingController();
  final designationController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final searchCountryController = TextEditingController();


  final genderText = ['Male', 'Female'].obs;
  final genderIndexValue = '-1'.obs;
  final genderType = ''.obs;

  final getYourBranch = ''.obs;
  final getYourBranchId = ''.obs;

  final getYourDepartment = ''.obs;
  final getYourDepartmentId = ''.obs;

  final getYourShiftTime = ''.obs;
  final getYourShiftTimeId = ''.obs;

  String companyId = '1';

  @override
  void onInit() {
    super.onInit();
    companyId = Get.arguments[0];
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
    CM.unFocusKeyBoard();
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
    image.value = await IP.pickImage(
      isCropper: true,
    );
  }

  Future<void> clickOnChooseFromLibrary() async {
    Get.back();
    image.value = await IP.pickImage(isCropper: true, pickFromGallery: true);
  }

  void clickOnRemovePhoto() {
    Get.back();
    image.value = null;
  }

  Future<void> clickOnSelectYourBranchTextField() async {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.SELECT_BRANCE,
            arguments: [getYourBranch.value, companyId, getYourBranchId.value])
        ?.then((value) {
      if (value != null) {
        getYourBranch.value = value[0];
        getYourBranchId.value = value[1];
        selectYourBranchController.text = getYourBranch.value;
        selectYourDepartmentController.clear();
        getYourDepartment.value = '';
        shiftTimeController.clear();
        getYourShiftTime.value = '';
        count.value++;
      }
    });
  }

  Future<void> clickOnSelectYourDepartmentTextField() async {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.SELECT_DEPARTMENT, arguments: [
      companyId,
      getYourBranchId.value,
      getYourDepartment.value,
      getYourDepartmentId.value
    ])?.then((value) {
      if (value != null) {
        getYourDepartment.value = value[0];
        getYourDepartmentId.value = value[1];
        selectYourDepartmentController.text = getYourDepartment.value;
        count.value++;
      }
    });
  }

  Future<void> clickOnShiftTimeTextField() async {
    CM.unFocusKeyBoard();
    Get.toNamed(Routes.SELECT_SHIFT_TIME, arguments: [
      companyId,
      getYourShiftTime.value,
      getYourShiftTimeId.value
    ])?.then((value) {
      if (value != null) {
        getYourShiftTime.value = value[0];
        getYourShiftTimeId.value = value[1];
        shiftTimeController.text = getYourShiftTime.value;
      }
    });
  }

  Future<void> clickOnJoiningDateTextField() async {
    CM.unFocusKeyBoard();
    DateTime? pickedDate = await CDT.iosPicker(
      context: Get.context!,
    );
    if (pickedDate != null) {
      joiningDateController.text =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
    }
  }

  void clickOnCountryCode() {
    CM.unFocusKeyBoard();
    CBS.commonBottomSheetForCountry(
      child: SizedBox(
        height: 100.px,
        width: double.infinity,
        child: const Center(
          child: Text('No Data Found!.'),
        ),
      ),
      searchController: searchCountryController,
      onChanged: (value) {},
    );
  }

  Future<void> clickOnRegisterButton() async {
    CM.unFocusKeyBoard();
    if (key.currentState!.validate() && genderType.value != '') {
      BottomSheetForOTP.commonBottomSheetForVerifyOtp(
        otp: '123123',
      );
    }
  }
}
