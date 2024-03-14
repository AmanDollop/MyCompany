import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/blood_group_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final image = Rxn<File?>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final hobbiesAndInterestController = TextEditingController();
  final skillsController = TextEditingController();
  final languageKnownController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();

  final userFullName = ''.obs;
  final userShortName = ''.obs;
  final userPic = ''.obs;
  final countryCode = ''.obs;
  final mobileNumber = ''.obs;
  final dob = ''.obs;
  final skill = ''.obs;
  final userDesignation = ''.obs;

  final genderText = ['Male', 'Female'];
  final genderIndexValue = '-1'.obs;
  final genderType = ''.obs;

  final apiResponseValue = true.obs;
  final saveButtonValue = false.obs;

  final userDataFromLocalDataBase = ''.obs;
  UserDetails? userData;
  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  JobInfo? jobInfo;

  Map<String, dynamic> bodyParamsForGetUserDate = {};

  Map<String, dynamic> bodyParamsForUpdateProfile = {};

  final bloodGroupModal = Rxn<BloodGroupModal>();
  String? bloodGroup;
  final bloodGroupList = [];
  final bloodGroupValue = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingBloodGroupApi();
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
    userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(
        key: DataBaseConstant.userDetail,
        tableName: DataBaseConstant.tableNameForUserDetail);

    userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;

    personalInfo = userData?.personalInfo;
    contactInfo = userData?.contactInfo;
    jobInfo = userData?.jobInfo;

    userFullName.value = personalInfo?.userFullName ?? '';

    userShortName.value = personalInfo?.shortName ?? '';

    firstNameController.text = personalInfo?.userFirstName ?? '';

    lastNameController.text = personalInfo?.userLastName ?? '';

    userPic.value = personalInfo?.userProfilePic ?? '';

    genderType.value = personalInfo?.gender ?? '';
    if (genderType.value == 'Male') {
      genderIndexValue.value = '0';
    } else if (genderType.value == 'Female') {
      genderIndexValue.value = '1';
    } else {
      genderIndexValue.value = '-1';
    }

    hobbiesAndInterestController.text = personalInfo?.hobbiesAndInterest ?? '';

    dob.value = personalInfo?.memberDateOfBirth ?? '';
    if (dob.value.isNotEmpty) {
      String formattedDate =
          CMForDateTime.dateFormatForDateMonthYear(date: dob.value);
      dobController.text = formattedDate.toString();
    }

    skillsController.text = personalInfo?.skills ?? '';

    languageKnownController.text = personalInfo?.languageKnown ?? '';

    bloodGroupController.text = personalInfo?.bloodGroup ?? '';
    bloodGroupValue.value = personalInfo?.bloodGroup ?? '';

    emailController.text = contactInfo?.userEmail ?? '';

    mobileNumber.value = contactInfo?.userMobile ?? '';

    countryCode.value = contactInfo?.countryCode ?? '';

    if (countryCode.value != 'null' &&
        countryCode.value.isNotEmpty &&
        mobileNumber.value != 'null' &&
        mobileNumber.value.isNotEmpty) {
      mobileNumberController.text = '${countryCode.value} ${mobileNumber.value}';
    }
    userDesignation.value = jobInfo?.userDesignation ?? '';
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

  Future<void> clickOnSaveButton() async {
    if (key.currentState!.validate()) {
      saveButtonValue.value = true;
      await callingUpDateProfileApi();
      saveButtonValue.value = false;
    }
  }

  Future<void> clickOnDOBTextField() async {
    print('dobController.text:::: ${dobController.text}');
    await CDT.iosPicker1(
            context: Get.context!,
            dateController: dobController,
            initialDate: dobController.text.isNotEmpty
                ? DateFormat('dd MMM yyyy').parse(dobController.text)
                : DateTime.now(),
           // firstDate:  dobController.text.isNotEmpty
           //     ? DateFormat('dd MMM yyyy').parse(dobController.text)
           //     : DateTime(DateTime.now().year - 18),
          lastDate: dobController.text.isNotEmpty
           ? DateTime(DateFormat('dd MMM yyyy').parse(dobController.text).year+5)
           : DateTime(DateTime.now().year + 5),
    ).whenComplete(
          () => CM.unFocusKeyBoard(),
        );
  }

  Future<void> clickOnBloodGroupTextField() async {
    await CBS.commonBottomSheet(
        // initialChildSize: 0.38,
        // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        children: [
          Center(
            child: Text(
              'Blood Group',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              bloodGroupList.length,
              (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: bloodGroupValue.value == bloodGroupList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: bloodGroupValue.value == bloodGroupList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: bloodGroupValue.value == bloodGroupList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => clickOnBloodGroup(index: index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bloodGroupList[index],
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              /*Container(
                                height:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                width:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                padding: EdgeInsets.all(2.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bloodGroupValue.value ==
                                        bloodGroupList[index]
                                        ? Col.primary
                                        : Col.text,
                                    width: 1.5.px,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bloodGroupValue.value ==
                                          bloodGroupList[index]
                                          ? Col.primary
                                          : Colors.transparent),
                                ),
                              ),*/
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
          SizedBox(height: 30.px)
        ]).whenComplete(
      () => CM.unFocusKeyBoard(),
    );
  }

  void clickOnBloodGroup({required int index}) {
    bloodGroupValue.value = bloodGroupList[index];
    bloodGroupController.text = bloodGroupValue.value;
    Get.back();
  }

  Future<void> callingUpDateProfileApi() async {
    try {
      bodyParamsForUpdateProfile = {
        AK.action: ApiEndPointAction.updatePersonalInfo,
        AK.userFirstName: firstNameController.text.trim(),
        AK.userLastName: lastNameController.text.trim(),
        AK.memberDateOfBirth: dobController.text.trim(),
        AK.hobbiesAndInterest: hobbiesAndInterestController.text.trim(),
        AK.skills: skillsController.text.trim(),
        AK.languageKnown: languageKnownController.text.trim(),
        AK.bloodGroup: bloodGroupController.text.trim(),
        AK.gender: genderType.value,
      };
      http.Response? response = await CAI.updateProfileApi(
        bodyParams: bodyParamsForUpdateProfile,
        image: image.value,
      );
      if (response != null) {
        if (response.statusCode == 200) {
          Map<String, dynamic> mapRes = {};
          mapRes = jsonDecode(response.body);
          CM.showSnackBar(message: mapRes['message']);
          await BottomSheetForOTP.callingGetUserDataApi();
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        }
      } else {
        apiResponseValue.value = false;
        saveButtonValue.value = false;
      }
    } catch (e) {
      apiResponseValue.value = false;
      saveButtonValue.value = false;
      CM.error();
    }
  }

  Future<void> callingBloodGroupApi() async {
    try {
      bloodGroupModal.value = await CAI.getBloodGroupApi(
          bodyParams: {AK.action: ApiEndPointAction.getBloodGroup});
      if (bloodGroupModal.value != null) {
        bloodGroup = bloodGroupModal.value?.bloodGroup;
        Map<String, dynamic> bloodGroupData = jsonDecode(bloodGroup ?? '');
        bloodGroupList.addAll(bloodGroupData.values.toList());
      }
    } catch (e) {
      apiResponseValue.value = false;
    }
  }
}
