import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/drawer_view/controllers/drawer_view_controller.dart';
import 'package:task/app/modules/home/dialog/break_dialog.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import '../../../../common/common_methods/cm.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;

  final count = 0.obs;
  final apiResValue = true.obs;

  final scrollController = ScrollController().obs;

  final breakValue = false.obs;

  final breakDialogConfirmButtonValue = false.obs;

  final checkInOrCheckOutValue = true.obs;

  final breakCheckBoxValue = ''.obs;

  final bannerIndex = 0.obs;

  final companyDetailFromLocalDataBase = ''.obs;

  GetCompanyDetails? getCompanyDetails;
  final companyId = ''.obs;

  final hideUpcomingCelebration = ''.obs;
  final hideMyDepartment = ''.obs;
  final hideGallery = ''.obs;
  final hideBanner = ''.obs;
  final hideMyTeam = ''.obs;


  final appMenuFromLocalDataBase = ''.obs;
  final isDatabaseHaveDataForAppMenu = true.obs;

  final menusModal = Rxn<MenusModal>();
  List<GetMenu> isLargeMenuList = [];
  List<GetMenu> isHeadingMenuList = [];
  Map<String, dynamic> bodyParamsForMenusApi = {};

  final bannerList = [
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYRNamIIDEJN4sHp3UuQVpYfwhrsNUZEld0aTCqAs4qMG-X9Wb3IGmvN3CbeSnvDzl_4c&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6g3P5972LeN4_5J9Dua6oCYn3cBzjSUGys5dhj4qerMbHQY5-TRyMzrmuRe3m6SPz4WU&usqp=CAU'
  ];

  final breakTitleList = [
    'Lunch Break',
    'Tea Break',
    'Personal Break',
    'Dinner Break',
  ].obs;

  GetLatLong? getLatLong;

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      Get.put(DrawerViewController());
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
        await callingGetLatLongMethod();
    }catch(e){
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

  @override
  void dispose() {
    scrollController.value.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  Location location = Location();

  Future<void> callingGetLatLongMethod() async {
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);

      if (getLatLong != null) {
        // location.onLocationChanged.listen((event) {
        //   getLatLong?.latitude = event.latitude;
        //   print('getLatLong?.latitude::::::  ${getLatLong?.latitude}');
        //   getLatLong?.longitude = event.longitude;
        //   print('getLatLong?.longitude::::::::  ${getLatLong?.longitude}');
        // });
        // await callingApi();
        isDatabaseHaveDataForAppMenu.value = await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForAppMenu);
        await setDefaultData();
      } else {
        if (AC.isConnect.value) {
          locationAlertDialog();
        }
      }
    } catch (e) {
      CM.error();
    }
  }

  Future<void> setDefaultData() async {

    companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail, tableName: DataBaseConstant.tableNameForCompanyDetail);

    getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;

    companyId.value = getCompanyDetails?.companyId ?? '';
    hideUpcomingCelebration.value = getCompanyDetails?.hideUpcomingCelebration ?? '';
    hideMyDepartment.value = getCompanyDetails?.hideMyDepartment ?? '';
    hideGallery.value = getCompanyDetails?.hideGallery ?? '';
    hideBanner.value = getCompanyDetails?.hideBanner ?? '';
    hideMyTeam.value = getCompanyDetails?.hideMyTeam ?? '';

    if(isDatabaseHaveDataForAppMenu.value) {
      await callingMenusApi();
    }else{
      appMenuFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.appMenus, tableName: DataBaseConstant.tableNameForAppMenu);

      menusModal.value = MenusModal.fromJson(jsonDecode(appMenuFromLocalDataBase.value));

      menusModal.value?.getMenu?.forEach((element) {
        if(element.isDashboardMenu == '1') {
          if(element.isLargeMenu == '1'){
            isLargeMenuList.add(element);
          }else{
            isHeadingMenuList.add(element);
          }
        }
      });

      await callingMenusApi();
    }


  }

  locationAlertDialog() async {
    await CD.commonIosPermissionDialog(clickOnPermission: () async {
      Get.back();
      await onInit();
    });
  }

  willPop() {
    CD.commonIosExitAppDialog(
      clickOnCancel: () {
        Get.back();
      },
      clickOnExit: () {
        exit(0);
      },
    );
  }

  void clickOnDrawerButton({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }

  void clickOnNotificationButton() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void clickOnSwitchButton() {
    breakCheckBoxValue.value = '';
    breakValue.value = false;
    animationController.forward();
    checkInOrCheckOutValue.value = !checkInOrCheckOutValue.value;
    count.value++;
  }

  Future<void> clickOnBreakButton() async {
    if (!breakValue.value) {
      await showDialog(
          context: Get.context!,
          builder: (context) {
            return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: const BreakDialog());
          });
      if (breakCheckBoxValue.value != '' &&
          breakDialogConfirmButtonValue.value) {
        animationController.reverse();
      }
    } else {
      breakCheckBoxValue.value = '';
      breakValue.value = false;
      animationController.forward();
    }
  }

  void clickOnLargeMenus({required int largeMenusIndex}) {}

  void clickOnDiscussion() {}

  void clickOnUpcomingCelebrationsButton() {}

  void clickOnHeadingCards({required int headingCardIndex}) {}

  void clickOnMyTeamCards({required int myTeamCardIndex}) {}

  void clickOnYourDepartmentViewAllButton() {}

  void clickOnYourDepartmentCards({required int yourDepartmentCardIndex}) {}

  void clickOnGalleryViewAllButton() {}

  Future<void> callingMenusApi() async {
    bodyParamsForMenusApi = {AK.action: 'getDashboardMenu',AK.companyId:companyId.value};
    menusModal.value = await CAI.menusApi(bodyParams: bodyParamsForMenusApi);
    if(menusModal.value!= null){
      if(await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForAppMenu)) {
        await DataBaseHelper().insertInDataBase(data: {DataBaseConstant.appMenus:json.encode(menusModal.value)}, tableName: DataBaseConstant.tableNameForAppMenu);
        menusModal.value?.getMenu?.forEach((element) {
          if(element.isDashboardMenu == '1') {
            if(element.isLargeMenu == '1'){
              isLargeMenuList.add(element);
            }else{
              isHeadingMenuList.add(element);
            }
          }
        });
      }
      else{
        await DataBaseHelper().upDateDataBase(data: {DataBaseConstant.appMenus:json.encode(menusModal.value)}, tableName: DataBaseConstant.tableNameForAppMenu);
      }
    }
  }

}
