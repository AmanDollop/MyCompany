import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/country_code_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:http/http.dart' as http;

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
  final countryId = ''.obs;
  final countryCode = ''.obs;

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
    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo);
      contactController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.whatsappNumber,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      whatsappController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.whatsappNumber,tableName: DataBaseConstant.tableNameForContactInfo);
    }


    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      companyEmailController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.personalEmail,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      personalEmailController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.personalEmail,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.currentAddress,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      currentAddressController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.currentAddress,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.permanentAddress,tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      permanentAddressController.text = await DataBaseHelper().getParticularData(key: DataBaseConstant.permanentAddress,tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.countryId,tableName: DataBaseConstant.tableNameForCompanyDetail) != 'null') {
      countryId.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.countryId,tableName: DataBaseConstant.tableNameForCompanyDetail);
      print('countryId.value:::::  ${countryId.value}');
    }

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
        AK.action :'getCountryCode',
      });
      if (countryCodeModal.value != null) {
        countryCodeList = countryCodeModal.value?.countryCode ?? [];
        countryCodeList?.forEach((element) {
          if(element.countryId == countryId.value){
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
    // await CBS.commonBottomSheetForCountry(
    //   searchController: searchCountryController,
    //   onChanged: (value) {
    //     countryCodeListSearch.clear();
    //     if (value.isEmpty) {
    //       return;
    //     } else {
    //       countryCodeList?.forEach((countryCodeAllData) {
    //         if (countryCodeAllData.countryName!.toLowerCase().contains(value.toLowerCase().trim())) {
    //           if (countryCodeAllData.countryName?.toLowerCase().trim().contains(value.toLowerCase().trim()) != null) {
    //             countryCodeListSearch.add(countryCodeAllData);
    //           } else {
    //             countryCodeListSearch = [];
    //           }
    //         }
    //       });
    //       count.value++;
    //     }
    //   },
    //   child: Obx(() {
    //     count.value;
    //     return ListView.builder(
    //       physics: const ScrollPhysics(),
    //       padding: EdgeInsets.only(bottom: 20.px),
    //       shrinkWrap: true,
    //       itemCount: searchCountryController.text.isNotEmpty
    //           ? countryCodeListSearch.length
    //           : countryCodeList?.length,
    //       itemBuilder: (context, index) {
    //         return InkWell(
    //           onTap: () => clickOnCountryDropDownValue(index: index),
    //           borderRadius: BorderRadius.circular(2.px),
    //           splashColor: Col.primary.withOpacity(.2),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.symmetric(vertical: 5.px),
    //                 child: Row(
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.all(5.px),
    //                       child: CW.commonNetworkImageView(
    //                         path: searchCountryController.text.isNotEmpty
    //                             ? '${AU.baseUrlAllApisImage}${countryCodeListSearch[index].flag}'
    //                             : '${AU.baseUrlAllApisImage}${countryCodeList?[index].flag}',
    //                         isAssetImage: false,
    //                         height: 18.px,
    //                         width: 28.px,
    //                       ),
    //                     ),
    //                     SizedBox(width: 6.px),
    //                     Text(
    //                       searchCountryController.text.isNotEmpty
    //                           ?'${countryCodeListSearch[index].phonecode}'
    //                           :'${countryCodeList?[index].phonecode}',
    //                       style: Theme.of(context).textTheme.labelSmall,
    //                     ),
    //                     SizedBox(width: 10.px),
    //                     Flexible(
    //                       child: Text(
    //                         searchCountryController.text.isNotEmpty
    //                             ?'${countryCodeListSearch[index].countryName}'
    //                             :'${countryCodeList?[index].countryName}',
    //                         style: Theme.of(context).textTheme.titleSmall,
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               CW.commonDividerView(height: 0.px),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // ).whenComplete(() {
    //   searchCountryController.clear();
    //   countryCodeListSearch.clear();
    // });
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
        AK.action:'updateContactInfo',
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
