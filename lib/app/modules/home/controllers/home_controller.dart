import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/drawer_view/controllers/drawer_view_controller.dart';
import 'package:task/app/modules/home/dialog/break_dialog.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import '../../../../common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

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

  final hideUpcomingCelebration = false.obs;
  final hideMyDepartment = false.obs;
  final hideGallery = false.obs;
  final hideBanner = false.obs;
  final hideMyTeam = false.obs;

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

  final shiftDetailFromLocalDataBase = ''.obs;

  ShiftDetails? shiftDetails;
  ShiftTime? shiftTime;


  GetLatLong? getLatLong;
  Map<String, dynamic> bodyParamsForAttendancePunchInApi = {};


  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      Get.put(DrawerViewController());
      animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 450));
      await callingGetLatLongMethod();
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

        print('getLatLong:::::: ${getLatLong?.longitude}    ${getLatLong?.latitude}');

        // location.onLocationChanged.listen((event) {
        //   getLatLong?.latitude = event.latitude;
        //   print('getLatLong?.latitude::::::  ${getLatLong?.latitude}');
        //   getLatLong?.longitude = event.longitude;
        //   print('getLatLong?.longitude::::::::  ${getLatLong?.longitude}');
        // });
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
    await companyData();
    await shiftData();
    await appMenusData();
  }

  Future<void> companyData() async {
    try {
      companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail, tableName: DataBaseConstant.tableNameForCompanyDetail);

      getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;

      companyId.value = getCompanyDetails?.companyId ?? '';
      hideUpcomingCelebration.value = getCompanyDetails?.hideUpcomingCelebration ?? false;
      hideMyDepartment.value = getCompanyDetails?.hideMyDepartment ?? false;
      hideGallery.value = getCompanyDetails?.hideGallery ?? false;
      hideBanner.value = getCompanyDetails?.hideBanner ?? false;
      hideMyTeam.value = getCompanyDetails?.hideMyTeam ?? false;
    } catch (e) {}
  }

  Future<void> shiftData() async {
    try {
      shiftDetailFromLocalDataBase.value = await DataBaseHelper()
          .getParticularData(
              key: DataBaseConstant.shiftTime,
              tableName: DataBaseConstant.tableNameForShiftDetail);
      shiftTime =
          ShiftTime.fromJson(jsonDecode(shiftDetailFromLocalDataBase.value));
    } catch (e) {
      print('e::::::::::   $e');
    }
  }

  Future<void> appMenusData() async {
    try {
      if (isDatabaseHaveDataForAppMenu.value) {
        await callingMenusApi();
      } else {
        appMenuFromLocalDataBase.value = await DataBaseHelper()
            .getParticularData(
                key: DataBaseConstant.appMenus,
                tableName: DataBaseConstant.tableNameForAppMenu);

        menusModal.value =
            MenusModal.fromJson(jsonDecode(appMenuFromLocalDataBase.value));

        menusModal.value?.getMenu?.forEach((element) {
          if (element.isDashboardMenu == '1') {
            if (element.isLargeMenu == '1') {
              isLargeMenuList.add(element);
            } else {
              isHeadingMenuList.add(element);
            }
          }
        });

        await callingMenusApi();
      }
    } catch (e) {}
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
    CD.commonAndroidAlertDialogBox(
      contentPadding: EdgeInsets.zero,
      isDismiss: false,
      isBackOn: false,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Location Dialog',
              style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(color: Col.primary),
            ),
          ),
          SizedBox(height: 16.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'GPS Accuracy:',
                      style: Theme.of(Get.context!).textTheme.labelMedium,
                    ),
                    SizedBox(width: 5.px),
                    Text(
                      '14:06',
                      style: Theme.of(Get.context!).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.px),
              Expanded(
                child: CW.commonElevatedButton(
                  padding: EdgeInsets.symmetric(horizontal: 8.px),
                  height: 30.px,
                  borderRadius: 4.px,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.refresh,
                          color: Col.inverseSecondary, size: 18.px),
                      SizedBox(width: 6.px),
                      Text(
                        'Refresh Location',
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.px),
          Text(
            'You are in range: Indore',
            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.primary),
          ),
          SizedBox(height: 10.px),
          CW.commonTextFieldForMultiline(
            textInputAction: TextInputAction.newline,keyboardType: TextInputType.multiline,
            borderRadius: 4.px,
            maxLines: 3,
            labelText: checkInOrCheckOutValue.value?'Late in reason*':'Early out reason*',
            hintText: 'Type here',
          ),
        ],
      ),
      leftButtonTitle: 'Close',
      clickOnLeftButton: (){
        Get.back();
      },
      rightButtonTitle: checkInOrCheckOutValue.value?'Punch In':'Punch Out',
      clickOnRightButton:(){
        Get.back();
        checkInOrCheckOutValue.value = !checkInOrCheckOutValue.value;
      },
    );

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

  void clickOnLargeMenus({required int largeMenusIndex}) {
    if (isLargeMenuList[largeMenusIndex].menuClick == 'circular') {
      Get.toNamed(Routes.CIRCULAR,
          arguments: [isLargeMenuList[largeMenusIndex].menuName]);
    }
  }

  void clickOnUpcomingCelebrationsButton() {}

  void clickOnHeadingCards({required int headingCardIndex}) {}

  void clickOnMyTeamCards({required int myTeamCardIndex}) {}

  void clickOnYourDepartmentViewAllButton() {}

  void clickOnYourDepartmentCards({required int yourDepartmentCardIndex}) {}

  void clickOnGalleryViewAllButton() {}

  Future<void> callingMenusApi() async {
    bodyParamsForMenusApi = {
      AK.action: 'getDashboardMenu',
      AK.companyId: companyId.value
    };
    menusModal.value = await CAI.menusApi(bodyParams: bodyParamsForMenusApi);
    if (menusModal.value != null) {
      if (await DataBaseHelper().isDatabaseHaveData(
          db: DataBaseHelper.dataBaseHelper,
          tableName: DataBaseConstant.tableNameForAppMenu)) {
        await DataBaseHelper().insertInDataBase(
            data: {DataBaseConstant.appMenus: json.encode(menusModal.value)},
            tableName: DataBaseConstant.tableNameForAppMenu);
        menusModal.value?.getMenu?.forEach((element) {
          if (element.isDashboardMenu == '1') {
            if (element.isLargeMenu == '1') {
              isLargeMenuList.add(element);
            } else {
              isHeadingMenuList.add(element);
            }
          }
        });
      } else {
        await DataBaseHelper().upDateDataBase(
            data: {DataBaseConstant.appMenus: json.encode(menusModal.value)},
            tableName: DataBaseConstant.tableNameForAppMenu);
      }
    }
  }

  Future<void> callingAttendancePunchInApi() async {
    apiResValue.value = true;
    try{
      bodyParamsForAttendancePunchInApi={
        AK.action:'attendancePunchIn',
        AK.lateInReason:'',
        AK.punchInLatitude:'',
        AK.punchInLongitude:'',
        AK.punchInRange:'',
        AK.punchInOutOfRange:'',
        AK.punchInOutOfRangeReason:'',
      };
      http.Response? response = await  CAI.attendancePunchInApi(bodyParams: bodyParamsForAttendancePunchInApi,image: File(''));
      if(response!=null){
        if(response.statusCode==200){
          CM.showSnackBar(message: 'Punch In Successful');
        }else{
          CM.error();
        }
      }else{
        CM.error();
      }
    }catch(e){
      apiResValue.value=false;
    }
    apiResValue.value=false;
  }

}
