import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/search_company_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class SearchCompanyController extends GetxController {

  final count = 0.obs;
  final searchController = TextEditingController();

  Map<String, dynamic> bodyParams = {};
  final searchCompanyModel = Rxn<SearchCompanyModal?>();
  final searchCompanyList =<SearchCompanyList>[].obs;

  final apiResponseValue = false.obs;


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

  void clickOnCompany({required int index}) {
    CM.unFocusKeyBoard();
    if(searchCompanyList.value[index].companyId != null && searchCompanyList.value[index].companyId!.isNotEmpty && searchCompanyList.value[index].baseUrl != null && searchCompanyList.value[index].baseUrl!.isNotEmpty) {

      String apiBaseUrl = searchCompanyList.value[index].baseUrl.toString();
      print('apiBaseUrl::::::   $apiBaseUrl');
      String companyId = searchCompanyList.value[index].companyId.toString();
      print('companyId:::::::   $companyId');
      Get.toNamed(Routes.LOGIN,arguments: [apiBaseUrl,companyId]);
    }else{
      CM.showSnackBar(message: 'Something went wrong!');
    }

  }

  Future<void> searchOnChanged({required String value}) async {
    try{
      apiResponseValue.value = true;
      if (value.length >= 3) {
        searchCompanyList.value.clear();
        await searchCompanyApiCalling();
        count.value++;
      } else if(value.isEmpty){
        count.value++;
        return;
      }else{
        count.value++;
        return;
      }
    } catch(e){
      CM.showSnackBar(message: 'Something went wrong!');
      apiResponseValue.value = false;
    }
    apiResponseValue.value = false;
  }

  Future<void> searchCompanyApiCalling() async {
    bodyParams = {
      AK.action: 'getCompanies',
      AK.searchString: searchController.text.trim().toString(),
    };
    searchCompanyModel.value = await CAI.searchCompanyApi(bodyParams: bodyParams);
    if (searchCompanyModel.value != null) {
      searchCompanyList.value = searchCompanyModel.value?.data ?? [];
    }
  }


}
