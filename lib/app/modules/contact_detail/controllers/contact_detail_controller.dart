import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/country_code_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../api/api_model/user_data_modal.dart';

class ContactDetailController extends GetxController {

  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final contactController = TextEditingController();
  final whatsappController = TextEditingController();
  final companyEmailController = TextEditingController();
  final personalEmailController = TextEditingController();
  final currentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

  final mobileNumber = ''.obs;
  final countryCode = ''.obs;

  final companyDetailFromLocalDataBase = ''.obs;
  GetCompanyDetails? getCompanyDetails;

  final userDataFromLocalDataBase =''.obs;
  UserDetails? userData;
  ContactInfo? contactInfo;


  final countryCodeModal = Rxn<CountryCodeModal?>();
  List<CountryCodeList>? countryCodeList;
  List<CountryCodeList> countryCodeListSearch = [];
  final countryImagePath = ''.obs;
  final searchCountryController = TextEditingController();

  final valueForEditFiled = false.obs;
  final apiResponseValue = true.obs;


  final isUseMyLocationButtonClickedForCurrent = false.obs;
  Map<String, dynamic> googleMapDataCurrent = {};

  final isUseMyLocationButtonClickedForPermanentAddress = false.obs;
  Map<String, dynamic> googleMapDataPermanentAddress = {};

  final permanentAddressCheckBoxValue = false.obs;

  Map<String, dynamic> bodyParamsForContactInfo = {};

  final saveButtonValue = false.obs;


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
    await callingCountryCodeApi();
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
    contactInfo=userData?.contactInfo;

    companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail,tableName: DataBaseConstant.tableNameForCompanyDetail);
    getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;

      mobileNumber.value = contactInfo?.userMobile??'';
      contactController.text = contactInfo?.userMobile??'';

      whatsappController.text =  contactInfo?.whatsappNumber??'';

      companyEmailController.text =  contactInfo?.userEmail??'';

      personalEmailController.text =  contactInfo?.personalEmail??'';

      currentAddressController.text =  contactInfo?.currentAddress??'';

      permanentAddressController.text =  contactInfo?.permanentAddress??'';

  }

  clickOnBackButton() {
      Get.back();
  }

  void clickOnEditViewButton() {
    valueForEditFiled.value = true;
  }

  Future<void> clickOnEditUpdateButton() async {
    if(key.currentState!.validate()){
      saveButtonValue.value = true;
      await callingUpdateContactInfoApi();
      saveButtonValue.value = false;
    }
  }

  Future<void> callingCountryCodeApi() async {
    try{
      countryCodeModal.value = await CAI.getCountryCodeApi(bodyParams: {
        AK.action :ApiEndPointAction.getCountryCode,
      });
      if (countryCodeModal.value != null) {
        countryCodeList = countryCodeModal.value?.countryCode ?? [];
        countryCodeList?.forEach((element) {
          if(element.countryId == getCompanyDetails?.countryId){
            countryCode.value = element.phonecode ??'';
            countryImagePath.value = "${AU.baseUrlAllApisImage}${element.flag}";
            print('countryImagePath.value::::::  ${countryImagePath.value}');
          }
        });
      }
    }catch(e){
      apiResponseValue.value=false;
      CM.error();
    }
  }

  Future<void> clickOnCountryCode() async {
    CM.unFocusKeyBoard();
  }

  void clickOnCountryDropDownValue({required int index}) {
    if(searchCountryController.text.isNotEmpty){
      countryCode.value =  countryCodeListSearch[index].phonecode??'';
      countryImagePath.value =  '${AU.baseUrlAllApisImage}${countryCodeListSearch[index].flag}';
      Get.back();
    }
    else{
      countryCode.value =  countryCodeList?[index].phonecode??'';
      countryImagePath.value =  '${AU.baseUrlAllApisImage}${countryCodeList?[index].flag}';
      Get.back();
    }
  }

  Future<void> clickOnMyLocationCurrentAddressIconButton() async {
    CM.unFocusKeyBoard();
    isUseMyLocationButtonClickedForCurrent.value = true;
    await getDataFromGoogleMapForCurrent();
  }

  Future<void> getDataFromGoogleMapForCurrent() async {
    try{
      googleMapDataCurrent = await MyLocation.getCurrentLocation(context: Get.context!) ?? {};
      setGoogleMapDataInTextField(currentAddress: true);
    }catch(e){
      isUseMyLocationButtonClickedForCurrent.value = false;
      CM.error();
    }
  }

  void setGoogleMapDataInTextField({required bool currentAddress}){
    if(currentAddress){
      currentAddressController.text = '${googleMapDataCurrent[MyAddressKeyConstant.addressDetail]} ${googleMapDataCurrent[MyAddressKeyConstant.area]}';
      isUseMyLocationButtonClickedForCurrent.value = false;
    }
    else{
      permanentAddressController.text = '${googleMapDataPermanentAddress[MyAddressKeyConstant.addressDetail]} ${googleMapDataPermanentAddress[MyAddressKeyConstant.area]}';
      isUseMyLocationButtonClickedForPermanentAddress.value=false;
    }
  }

  Future<void> clickOnMyLocationPermanentAddressIconButton() async {
    CM.unFocusKeyBoard();
    isUseMyLocationButtonClickedForPermanentAddress.value = true;
    await getDataFromGoogleMapForPermanent();
  }

  Future<void> getDataFromGoogleMapForPermanent() async {
    try{
      googleMapDataPermanentAddress = await MyLocation.getCurrentLocation(context: Get.context!) ?? {};
      setGoogleMapDataInTextField(currentAddress: false);
    }catch(e){
      isUseMyLocationButtonClickedForPermanentAddress.value = false;
      CM.error();
    }
  }

  Future<void> callingUpdateContactInfoApi() async {
    try{
      bodyParamsForContactInfo={
        AK.action:ApiEndPointAction.updateContactInfo,
        AK.whatsappCountryCode : countryCode.value,
        AK.whatsappNumber : whatsappController.text.trim().toString(),
        AK.personalEmail : personalEmailController.text.trim().toString(),
        AK.currentAddress : currentAddressController.text.trim().toString(),
        AK.permanentAddress : permanentAddressController.text.trim().toString(),
      };
      http.Response? response =  await CAI.updateUserControllerApi(bodyParams: bodyParamsForContactInfo);
      if(response != null){
        if(response.statusCode ==200){
          await BottomSheetForOTP.callingGetUserDataApi();
          Get.back();
          // CM.showSnackBar(message: 'Contact Info Update Successful');
        }else{
          CM.error();
          saveButtonValue.value = false;
        }
      }else{
        CM.error();
        saveButtonValue.value = false;
      }
    }catch(e){
     CM.error();
     saveButtonValue.value = false;
    }
  }

}
