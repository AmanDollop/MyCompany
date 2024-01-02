import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/bank_detail_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class AddBankController extends GetxController {

  final key = GlobalKey<FormState>();

  final count = 0.obs;

  final accountHolderNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankBranchNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final reAccountNoController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final customerIDCRNNoController = TextEditingController();
  final esicNoController = TextEditingController();
  final panCardNoController = TextEditingController();
  final pFUANNoController = TextEditingController();

  final accountTypeText = ['Saving','Current'];
  final accountTypeIndexValue = '0'.obs;
  final accountType = ''.obs;



  final addAccountButtonValue = false.obs;

  Map<String, dynamic> bodyParamsForUpdateBankDetails = {};

  GetBankDetails? getBankDetails;
  String pageType = '';
  String bankId = '';


  @override
  void onInit() {
    super.onInit();
    pageType = Get.arguments[0];
    if(pageType == 'UpDate Bank Detail') {
      getBankDetails = Get.arguments[1];
      setDefaultBankData();
    }
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

  void setDefaultBankData(){
    accountHolderNameController.text = getBankDetails?.accountHoldersName??'Data not found!';
    bankNameController.text = getBankDetails?.bankName??'Data not found!';
    bankBranchNameController.text = getBankDetails?.bankBranchName??'Data not found!';
    accountNoController.text = getBankDetails?.accountNo??'Data not found!';
    reAccountNoController.text = getBankDetails?.accountNo??'Data not found!';
    ifscCodeController.text = getBankDetails?.ifscCode??'Data not found!';
    customerIDCRNNoController.text = getBankDetails?.crnNo??'Data not found!';
    esicNoController.text = getBankDetails?.esicNo??'Data not found!';
    panCardNoController.text = getBankDetails?.panCardNo??'Data not found!';
    pFUANNoController.text = getBankDetails?.pfNo??'Data not found!';
    bankId = getBankDetails?.bankId??'';
    accountType.value = getBankDetails?.accountType??'';
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnAddAccountUpdateButton() async {
    CM.unFocusKeyBoard();
    if(key.currentState!.validate()){
      addAccountButtonValue.value = true;
      await callingAddBankDetailsApi();
      addAccountButtonValue.value = false;
    }
  }

  Future<void> callingAddBankDetailsApi() async {
    try{
      bodyParamsForUpdateBankDetails={
        AK.action:'addBankDetail',
        AK.accountHoldersName : accountHolderNameController.text.trim().toString(),
        AK.bankName : bankNameController.text.trim().toString(),
        AK.bankBranchName : bankBranchNameController.text.trim().toString(),
        AK.accountNo : reAccountNoController.text.trim().toString(),
        AK.ifscCode : ifscCodeController.text.trim().toString(),
        AK.crnNo : customerIDCRNNoController.text.trim().toString(),
        AK.esicNo : esicNoController.text.trim().toString(),
        AK.panCardNo : panCardNoController.text.trim().toString(),
        AK.pfNo : pFUANNoController.text.trim().toString(),
        AK.accountType : accountType.value.toLowerCase(),
        AK.bankId : bankId,
      };
      http.Response? response =  await CAI.updateUserControllerApi(bodyParams: bodyParamsForUpdateBankDetails);
      if(response != null){
        if(response.statusCode ==200){
          Get.back();
        }else{
          CM.error();
          addAccountButtonValue.value = false;
        }
      }else{
        CM.error();
        addAccountButtonValue.value = false;
      }
    }catch(e){
      CM.error();
      addAccountButtonValue.value = false;
    }
  }

}
