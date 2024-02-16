import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MenuViewController extends GetxController {

  final count = 0.obs;

  final searchController = TextEditingController();

  final apiResValue = true.obs;

  final companyDetailFromLocalDataBase = ''.obs;
  GetCompanyDetails? getCompanyDetails;

  final companyId = ''.obs;

  final appMenuFromLocalDataBase = ''.obs;
  final menusModal = Rxn<MenusModal>();
  List<GetMenu> getMenuList = [];
  List<GetMenu> getMenuListForSearch = [];
  Map<String, dynamic> bodyParamsForMenusApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await setDefaultData();
      // await callingMenusApi();
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

    appMenuFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.appMenus, tableName: DataBaseConstant.tableNameForAppMenu);

    menusModal.value = MenusModal.fromJson(jsonDecode(appMenuFromLocalDataBase.value));

    getMenuList = menusModal.value?.getMenu??[];

  }

  willPop() {
    selectedBottomNavigationIndex.value = 0;
    count.value++;
  }

 /* Future<void> callingMenusApi() async {
    bodyParamsForMenusApi = {
      AK.action: 'getDashboardMenu',
      AK.companyId: companyId.value
    };
    menusModal.value = await CAI.menusApi(bodyParams: bodyParamsForMenusApi);
    if (menusModal.value != null) {

    }
  }*/

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

  void clickOnCard({required int index}) {
    if(searchController.text.isNotEmpty){
      if (getMenuListForSearch[index].menuClick == 'circular') {
        Get.toNamed(Routes.CIRCULAR, arguments: [getMenuListForSearch[index].menuName]);
      }else if (getMenuListForSearch[index].menuClick == 'attendance') {
        Get.toNamed(Routes.ATTENDANCE_TRACKER, arguments: [getMenuListForSearch[index].menuName]);
      }else if (getMenuListForSearch[index].menuClick == 'task') {
        Get.toNamed(Routes.ALL_TASK, arguments: [getMenuListForSearch[index].menuName]);
      }else if (getMenuListForSearch[index].menuClick == 'penalty') {
        Get.toNamed(Routes.PENALTY, arguments: [getMenuListForSearch[index].menuName]);
      }else if (getMenuListForSearch[index].menuClick == 'holiday') {
        Get.toNamed(Routes.HOLIDAY, arguments: [getMenuListForSearch[index].menuName]);
      } else {
        CM.showSnackBar(message: 'Coming soon');
      }
    }
    else{
      if (getMenuList[index].menuClick == 'circular') {
        Get.toNamed(Routes.CIRCULAR, arguments: [getMenuList[index].menuName]);
      }else if (getMenuList[index].menuClick == 'attendance') {
        Get.toNamed(Routes.ATTENDANCE_TRACKER, arguments: [getMenuList[index].menuName]);
      }else if (getMenuList[index].menuClick == 'task') {
        Get.toNamed(Routes.ALL_TASK, arguments: [getMenuList[index].menuName]);
      }else if (getMenuList[index].menuClick == 'penalty') {
        Get.toNamed(Routes.PENALTY, arguments: [getMenuList[index].menuName]);
      }else if (getMenuList[index].menuClick == 'holiday') {
        Get.toNamed(Routes.HOLIDAY, arguments: [getMenuList[index].menuName]);
      } else {
        CM.showSnackBar(message: 'Coming soon');
      }
    }
  }

}
