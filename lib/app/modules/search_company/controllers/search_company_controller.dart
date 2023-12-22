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
  List<SearchCompanyList>? searchCompanyList;

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
    if(searchCompanyList?[index].companyId != null && searchCompanyList![index].companyId!.isNotEmpty && searchCompanyList?[index].baseUrl != null && searchCompanyList![index].baseUrl!.isNotEmpty) {

      String apiBaseUrl = searchCompanyList?[index].baseUrl.toString()??'';
      String companyId = searchCompanyList?[index].companyId.toString()??'';
      Get.toNamed(Routes.LOGIN,arguments: [apiBaseUrl,companyId]);
    }else{
      CM.showSnackBar(message: 'Something went wrong!');
    }

  }

  Future<void> searchOnChanged({required String value}) async {
    try{
      apiResponseValue.value = true;
      if (value.length >= 3) {
        searchCompanyList?.clear();
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
      CM.error();
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
      searchCompanyList = searchCompanyModel.value?.data ?? [];
    }
  }


}
