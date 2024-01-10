import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MenuViewController extends GetxController {
  final count = 0.obs;

  final searchController = TextEditingController();

  final apiResValue = true.obs;

  final companyDetailFromLocalDataBase = ''.obs;
  GetCompanyDetails? getCompanyDetails;

  final companyId = ''.obs;

  final menusModal = Rxn<MenusModal>();
  List<GetMenu> getMenuList = [];
  List<GetMenu> getMenuListForSearch = [];
  Map<String, dynamic> bodyParamsForMenusApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await setDefaultData();
      await callingMenusApi();
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
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
    companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail, tableName: DataBaseConstant.tableNameForCompanyDetail);

    getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;

    companyId.value = getCompanyDetails?.companyId ?? '';
  }

  willPop() {
    selectedBottomNavigationIndex.value = 0;
  }

  Future<void> callingMenusApi() async {
    bodyParamsForMenusApi = {
      AK.action: 'getDashboardMenu',
      AK.companyId: companyId.value
    };
    menusModal.value = await CAI.menusApi(bodyParams: bodyParamsForMenusApi);
    if (menusModal.value != null) {
      getMenuList = menusModal.value?.getMenu ?? [];
    }
  }

  void searchOnChange({required String value}) {
    apiResValue.value = true;
    getMenuListForSearch.clear();
    if (value.isEmpty) {
      apiResValue.value = false;
      return;
    } else {
      getMenuList.forEach((getMenus) {
        if (getMenus.menuName!.toLowerCase().contains(value.toLowerCase().trim())) {
          if (getMenus.menuName?.toLowerCase().trim().contains(value.toLowerCase().trim()) != null) {
            getMenuListForSearch.add(getMenus);
          } else {
            getMenuListForSearch = [];
          }
        }
      });
      count.value++;
      apiResValue.value = false;
    }
  }
}
