import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/country_code_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:http/http.dart' as http;

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
  final passwordController = TextEditingController();

  final genderText = ['Male', 'Female'].obs;
  final genderIndexValue = '-1'.obs;
  final genderType = ''.obs;

  final getYourBranch = ''.obs;
  final getYourBranchId = ''.obs;

  final getYourDepartment = ''.obs;
  final getYourDepartmentId = ''.obs;

  final getYourShiftTime = ''.obs;
  final getYourShiftTimeId = ''.obs;

  String companyId = '';
  String countryCode = '+91';
  final countryImagePath = ''.obs;

  final countryCodeModal = Rxn<CountryCodeModal?>();
  List<CountryCodeList>? countryCodeList;
  List<CountryCodeList> countryCodeListSearch = [];


  Map<String, dynamic> bodyParamsRegistration = {};
  final registerButtonValue = false.obs;



  @override
  Future<void> onInit() async {
    super.onInit();
    companyId = Get.arguments[0];
    await callingCountryCodeApi();
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

    await CDT.iosPicker(
        context: Get.context!,
        dateController: joiningDateController,
        initialDate: joiningDateController.text.isNotEmpty
            ? DateFormat('dd MMM yyyy').parse(joiningDateController.text)
            : DateTime.now());
  }

  Future<void> clickOnCountryCode() async {
    CM.unFocusKeyBoard();
    await CBS.commonBottomSheetForCountry(
      searchController: searchCountryController,
      onChanged: (value) {
        countryCodeListSearch.clear();
        if (value.isEmpty) {
          return;
        } else {
          countryCodeList?.forEach((countryCodeAllData) {
            if (countryCodeAllData.countryName!.toLowerCase().contains(value.toLowerCase().trim())) {
              if (countryCodeAllData.countryName?.toLowerCase().trim().contains(value.toLowerCase().trim()) != null) {
                countryCodeListSearch.add(countryCodeAllData);
              } else {
                countryCodeListSearch = [];
              }
            }
          });
          count.value++;
        }

      },
      child: Obx(() {
        count.value;
        return ListView.builder(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.only(bottom: 20.px),
          shrinkWrap: true,
          itemCount: searchCountryController.text.isNotEmpty
              ? countryCodeListSearch.length
              : countryCodeList?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => clickOnCountryDropDownValue(index: index),
              borderRadius: BorderRadius.circular(2.px),
              splashColor: Col.primary.withOpacity(.2),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.px),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.px),
                          child: CW.commonNetworkImageView(
                            path: searchCountryController.text.isNotEmpty
                                ? '${AU.baseUrlForImage1}${countryCodeListSearch[index].flag}'
                                : '${AU.baseUrlForImage1}${countryCodeList?[index].flag}',
                            isAssetImage: false,
                            height: 18.px,
                            width: 28.px,
                          ),
                        ),
                        SizedBox(width: 6.px),
                        Text(
                          searchCountryController.text.isNotEmpty
                              ?'${countryCodeListSearch[index].phonecode}'
                              :'${countryCodeList?[index].phonecode}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(width: 10.px),
                        Flexible(
                          child: Text(
                            searchCountryController.text.isNotEmpty
                                ?'${countryCodeListSearch[index].countryName}'
                                :'${countryCodeList?[index].countryName}',
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CW.commonDividerView(height: 0.px),
                ],
              ),
            );
          },
        );
      }),
    ).whenComplete(() {
      searchCountryController.clear();
      countryCodeListSearch.clear();
    });
  }

  void clickOnCountryDropDownValue({required int index}) {
    if(searchCountryController.text.isNotEmpty){
      countryCode =  countryCodeListSearch[index].phonecode??'';
      countryImagePath.value =  '${AU.baseUrlForImage1}${countryCodeListSearch[index].flag}';
      Get.back();
    }else{
      countryCode =  countryCodeList?[index].phonecode??'';
      countryImagePath.value =  '${AU.baseUrlForImage1}${countryCodeList?[index].flag}';
      Get.back();
    }
  }

  Future<void> clickOnRegisterButton() async {
    CM.unFocusKeyBoard();
    if (key.currentState!.validate() && genderType.value != '' && image.value != null) {
      registerButtonValue.value = true;
      await registrationApiCalling();
    }
  }

  Future<void> registrationApiCalling() async {
    try{
      bodyParamsRegistration = {
        AK.action: 'userRegistration',
        AK.companyId: companyId.toString(),
        AK.branchId: getYourBranchId.toString(),
        AK.departmentId: getYourDepartmentId.toString(),
        AK.shiftId: getYourShiftTimeId.toString(),
        AK.countryCode: countryCode.toString(),
        AK.deviceType: 'android',
        AK.userFirstName: firstNameController.text.trim().toString(),
        AK.userLastName: lastNameController.text.trim().toString(),
        AK.dateOfJoining: joiningDateController.text.trim().toString(),
        AK.userEmail: emailController.text.trim().toString(),
        AK.userDesignation: designationController.text.trim().toString(),
        AK.useMobile: mobileNumberController.text.trim().toString(),
        AK.gender: genderType.toLowerCase().toString(),
        AK.userPassword: '123456',
      };
      http.Response? response = await CAI.registrationApi(
        bodyParams: bodyParamsRegistration,
        imageMap: {AK.userProfilePic:image.value ?? File('')}
      );
      if (response != null && response.statusCode == 200) {
        Get.back();
      }
      else {
        registerButtonValue.value = false;
      }
    }catch(e){
      registerButtonValue.value = false;
      CM.error();
    }
  }

  Future<void> callingCountryCodeApi() async {
    try{
      countryCodeModal.value = await CAI.getCountryCodeApi(bodyParams: {
        AK.action :'getCountryCode',
      });
      if (countryCodeModal.value != null) {
        countryCodeList = countryCodeModal.value?.data ?? [];
        countryCodeList?.forEach((element) {
          if(element.phonecode == '+91'){
            countryCode = element.phonecode ??'';
            countryImagePath.value = "${AU.baseUrlForImage1}${element.flag}";
            print('${AU.baseUrlForImage1}${element.flag}');
          }
        });
      }
    }catch(e){
      CM.error();
    }
  }

}
