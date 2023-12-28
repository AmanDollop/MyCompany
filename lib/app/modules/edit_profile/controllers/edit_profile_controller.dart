import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

class EditProfileController extends GetxController {
  final count = 0.obs;

  final image = Rxn<File?>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();

  final userPic = ''.obs;
  final countryCode = ''.obs;
  final mobileNumber = ''.obs;
  final developerType = ''.obs;

  final genderText = ['Male', 'Female'];
  final genderIndexValue = '-1'.obs;
  final genderType = ''.obs;

  final bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB++',
    'AB--',
  ];
  final bloodGroupValue = ''.obs;

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
    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userFirstName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      firstNameController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userFirstName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userLastName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      lastNameController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userLastName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userProfilePic, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userPic.value = await DataBaseHelper().getParticularData(
          key: DataBaseConstant.userProfilePic,
          tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      emailController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      countryCode.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.countryCode, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (countryCode.value != 'null' && countryCode.value.isNotEmpty && mobileNumber.value != 'null' && mobileNumber.value.isNotEmpty) {
      mobileNumberController.text = '${countryCode.value} ${mobileNumber.value}';
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.gender, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      genderType.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.gender, tableName: DataBaseConstant.tableNameForPersonalInfo);
      print('genderType.value::::  ${genderType.value}');
      if (genderType.value == 'male') {
        genderIndexValue.value = '0';
      } else if (genderType.value == 'female') {
        genderIndexValue.value = '1';
      } else {
        genderIndexValue.value = '-1';
      }
    }
  }

  void clickOnBackButton() {
    Get.back();
  }

  ImageProvider selectImage() {
    if (image.value != null) {
      return FileImage(image.value!);
    } else if (userPic.value != '' && userPic.value.isNotEmpty) {
      return NetworkImage('${AU.baseUrlAllApisImage}${userPic.value}');
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

  void clickOnSaveButton() {
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForPersonalInfo);
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForContactInfo);
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForJobInfo);
    // DataBaseHelper().upDateDataBase(data: data, tableName: DataBaseConstant.tableNameForSocialInfo);
    Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
  }

  Future<void> clickOnDOBTextField() async {
    await CDT.iosPicker(
        context: Get.context!,
        dateController: dobController,
        initialDate: dobController.text.isNotEmpty
            ? DateFormat('dd MMM yyyy').parse(dobController.text)
            : DateTime.now()).whenComplete(() => CM.unFocusKeyBoard(),);
  }

  Future<void> clickOnBloodGroupTextField() async {
    await CBS.commonDraggableBottomSheet(
        initialChildSize:   0.38,
        maxChildSize:  0.50,
      list: Wrap(
        children: List.generate(
          bloodGroupList.length,
              (index) => Obx(() {
            count.value;
            final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
            return SizedBox(
              width: cellWidth,
              child: Padding(
                padding: EdgeInsets.only(left: index % 2 == 0 ? C.margin : C.margin / 2, right: index % 2 == 0 ? C.margin / 2 : C.margin, top: C.margin/2, bottom: 0.px),
                child: Container(
                  height: 46.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.px),
                    color: bloodGroupValue.value == bloodGroupList[index] ? Col.primary.withOpacity(.08) : Colors.transparent,
                    border: Border.all(
                      color: bloodGroupValue.value == bloodGroupList[index] ? Col.primary : Col.darkGray,
                      width: bloodGroupValue.value == bloodGroupList[index] ? 1.5.px : 1.px,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => clickOnBloodGroup(index: index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 10.px),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            bloodGroupList[index],
                            style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: bloodGroupValue.value == bloodGroupList[index] ? 18.px : 16.px,
                            width: bloodGroupValue.value == bloodGroupList[index] ? 18.px : 16.px,
                            padding: EdgeInsets.all(2.px),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: bloodGroupValue.value == bloodGroupList[index]
                                    ? Col.primary
                                    : Col.text,
                                width: 1.5.px,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bloodGroupValue.value == bloodGroupList[index]
                                      ? Col.primary
                                      : Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      children: []
    ).whenComplete(() => CM.unFocusKeyBoard(),);
  }

  void clickOnBloodGroup({required int index}) {
    bloodGroupValue.value = bloodGroupList[index];
    bloodGroupController.text = bloodGroupValue.value;
    Get.back();
  }
}
