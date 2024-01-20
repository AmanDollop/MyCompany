import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/get_today_attendance_modal.dart';
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
  Map<String, dynamic> bodyParamsForAttendancePunchOutApi = {};

  Map<String, dynamic> bodyParamsForBreakInApi = {};
  Map<String, dynamic> bodyParamsForBreakOutApi = {};

  final getTodayAttendanceModal = Rxn<GetTodayAttendanceModal>();
  GetTodayAttendance? getTodayAttendanceDetail;
  Map<String, dynamic> bodyParamsForGetTodayAttendanceApi = {};

  late DateTime currentTimeForTimer = DateTime(00);
  late DateTime currentTimeForBreakTimer = DateTime(00);
  final currentDateTimeForPunchIn = DateTime(00).obs;
  final currentDateTimeForBreak = DateTime(00).obs;
  late Timer timer;
  late Timer timer1;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      Get.put(DrawerViewController());
      var i = calculateTheLatLongDistanceInMeter(22.7248, 75.8871,22.6845, 75.8645);
      print('i:::: ${i.toDouble()}');
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

  double calculateTheLatLongDistanceInMeter(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Math.PI / 180
    const double earthRadius = 6371.0; // Radius of the Earth in kilometers
    double a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 2 * earthRadius * asin(sqrt(a)) * 1000; // Multiply by 1000 to convert to meters
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

  Location location = Location();

  Future<void> callingGetLatLongMethod() async {
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);

      if (getLatLong != null) {
        print('getLatLong:::::: ${getLatLong?.longitude}    ${getLatLong
            ?.latitude}');
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
    try {
      await companyData();
      await shiftData();
      await appMenusData();
      await callingGetTodayAttendanceApi();
    }catch(e){
      apiResValue.value=false;
    }
    apiResValue.value=false;
  }

  Future<void> companyData() async {
    try {
      companyDetailFromLocalDataBase.value =
      await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail, tableName: DataBaseConstant.tableNameForCompanyDetail);

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
      shiftDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.shiftTime, tableName: DataBaseConstant.tableNameForShiftDetail);
      shiftTime = ShiftTime.fromJson(jsonDecode(shiftDetailFromLocalDataBase.value));
    } catch (e) {
      print('e::::::::::   $e');
    }
  }

  Future<void> appMenusData() async {
    try {
      if (isDatabaseHaveDataForAppMenu.value) {
        await callingMenusApi();
      } else {
        appMenuFromLocalDataBase.value =
        await DataBaseHelper().getParticularData(key: DataBaseConstant.appMenus, tableName: DataBaseConstant.tableNameForAppMenu);
        menusModal.value = MenusModal.fromJson(jsonDecode(appMenuFromLocalDataBase.value));
        menusModal.value?.getMenu?.forEach((element) {
          if (element.isDashboardMenu == '1') {
              isHeadingMenuList.add(element);
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

  void clickOnDrawerButton({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }

  void clickOnNotificationButton() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void startTimer(){
      currentTimeForTimer = DateTime(2022, 1, 1, 0, 0, 0);
      timer = Timer.periodic(const Duration(seconds: 1), updateTimeForTimer);
      count.value++;
  }

  void updateTimeForTimer(Timer timer) {
    if(!breakValue.value) {
      currentTimeForTimer = currentTimeForTimer.add(const Duration(seconds: 1));
    }
    count.value++;
  }

  Future<void> clickOnSwitchButton() async {
    if (await AC.checkFakeLocation()) {
      await CD.commonAndroidFakeLocationDialog();
    }
    else {
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
                style: Theme
                    .of(Get.context!)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Col.primary),
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
                        style: Theme
                            .of(Get.context!)
                            .textTheme
                            .labelMedium,
                      ),
                      SizedBox(width: 5.px),
                      Text(
                        '14:06',
                        style: Theme
                            .of(Get.context!)
                            .textTheme
                            .labelSmall,
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
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .labelLarge,
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
              style: Theme
                  .of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Col.primary),
            ),
            SizedBox(height: 10.px),
            CW.commonTextFieldForMultiline(
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              borderRadius: 4.px,
              maxLines: 3,
              labelText: checkInOrCheckOutValue.value
                  ? 'Late in reason*'
                  : 'Early out reason*',
              hintText: 'Type here',
            ),
          ],
        ),
        leftButtonTitle: 'Close',
        clickOnLeftButton: () {
          Get.back();
        },
        rightButtonTitle: checkInOrCheckOutValue.value
            ? 'Punch In'
            : 'Punch Out',
        clickOnRightButton: checkInOrCheckOutValue.value
            ? () => clickOnPunchInButton()
            : () => clickOnPunchOutButton(),
      );
      count.value++;
    }
  }

  Future<void> clickOnPunchInButton() async {
    Get.back();
    startTimer();
    currentDateTimeForPunchIn.value = await getISTDateTime();
    checkInOrCheckOutValue.value = !checkInOrCheckOutValue.value;
  }

  Future<void> clickOnPunchOutButton() async {
    Get.back();
    timer.cancel();
    currentTimeForTimer = DateTime(2022, 1, 1, 0, 0, 0);
    checkInOrCheckOutValue.value = !checkInOrCheckOutValue.value;
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
    } else {
      breakCheckBoxValue.value = '';
      currentTimeForBreakTimer=DateTime(00);
      print('currentTimeForBreakTimer:::::::::  ${currentTimeForBreakTimer.second}');
      breakValue.value = false;
    }
  }

  void clickOnUpcomingCelebrationsButton() {}

  void clickOnHeadingCards({required int headingCardIndex}) {
    if(isHeadingMenuList[headingCardIndex].menuClick == 'circular'){
      Get.toNamed(Routes.CIRCULAR,arguments: [isHeadingMenuList[headingCardIndex].menuName]);
    }else{
      CM.showSnackBar(message: 'Coming soon');
    }
  }

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
      if (await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForAppMenu)) {
        await DataBaseHelper().insertInDataBase(data: {DataBaseConstant.appMenus: json.encode(menusModal.value)}, tableName: DataBaseConstant.tableNameForAppMenu);
        menusModal.value?.getMenu?.forEach((element) {
          if (element.isDashboardMenu == '1') {
              isHeadingMenuList.add(element);
          }
        });
      } else {
        await DataBaseHelper().upDateDataBase(data: {DataBaseConstant.appMenus: json.encode(menusModal.value)}, tableName: DataBaseConstant.tableNameForAppMenu);
      }
    }
  }

  Future<void> callingGetTodayAttendanceApi() async {
    bodyParamsForGetTodayAttendanceApi = {
      AK.action: 'getTodayAttendance',
    };
    getTodayAttendanceModal.value = await CAI.getTodayAttendanceApi(bodyParams: bodyParamsForGetTodayAttendanceApi);
    if(getTodayAttendanceModal.value != null){
      getTodayAttendanceDetail = getTodayAttendanceModal.value?.getTodayAttendance;
      // checkInOrCheckOutValue.value = getTodayAttendanceDetail?.isPunchIn ?? true;
      print('getTodayAttendanceDetail::::::  ${getTodayAttendanceDetail?.branchGeofenceLatitude}');
    }
  }

  Future<DateTime> getISTDateTime() async {
    final response = await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String utcDateTimeString = data['utc_datetime'];
      final DateTime utcDateTime = DateTime.parse(utcDateTimeString);
      final DateTime istDateTime = utcDateTime.add(const Duration(hours: 5, minutes: 30));
      return istDateTime;
    } else {
      throw Exception('Failed to load IST date and time');
    }
  }

  Future<void> callingAttendancePunchInApi() async {
    apiResValue.value = true;
    print('shiftTime?.shiftType:::::::  ${shiftTime?.shiftType}');
    try {
      bodyParamsForAttendancePunchInApi = {
        AK.action: 'attendancePunchIn',
        AK.lateInReason: '',
        AK.punchInLatitude: '',
        AK.punchInLongitude: '',
        AK.punchInRange: '',
        AK.punchInOutOfRange: '',
        AK.punchInOutOfRangeReason: '',
        AK.shiftType: shiftTime?.shiftType,
      };
      http.Response? response = await CAI.attendancePunchInAndPunchOutApi(
          bodyParams: bodyParamsForAttendancePunchInApi, image: File(''));
      if (response != null) {
        if (response.statusCode == 200) {
          CM.showSnackBar(message: 'Punch In Successful');
        } else {
          CM.error();
        }
      } else {
        CM.error();
      }
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> callingAttendancePunchOutApi() async {
    apiResValue.value = true;
    try {
      bodyParamsForAttendancePunchOutApi = {
        AK.action: 'attendancePunchOut',
        AK.lateInReason: '',
        AK.punchInLatitude: '',
        AK.punchInLongitude: '',
        AK.punchInRange: '',
        AK.punchInOutOfRange: '',
        AK.punchInOutOfRangeReason: '',
        AK.shiftType: shiftTime?.shiftType,
      };
      http.Response? response = await CAI.attendancePunchInAndPunchOutApi(
          bodyParams: bodyParamsForAttendancePunchOutApi, image: File(''));
      if (response != null) {
        if (response.statusCode == 200) {
          CM.showSnackBar(message: 'Punch In Successful');
        } else {
          CM.error();
        }
      } else {
        CM.error();
      }
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> callingBreakInApi() async {
    try{
      bodyParamsForBreakInApi = {
        AK.action: 'breakIn',
        AK.breakTypeId: '',
        AK.breakStartLatitude: '',
        AK.breakEndLongitude: '',
        AK.breakTypeName: '',
        AK.attendanceId: '',
      };
      http.Response? response = await CAI.breakInAndOutApi(bodyParams: bodyParamsForBreakInApi);
      if (response != null && response.statusCode == 200) {
       CM.showSnackBar(message: 'Break In');
      }
      else {
        CM.error();
      }
    }catch(e){
      CM.error();
    }

  }

  Future<void> callingBreakOutApi() async {
    try{
      bodyParamsForBreakInApi = {
        AK.action: 'breakOut',
        AK.breakHistoryId: '',
        AK.breakStartLatitude: '',
        AK.breakEndLongitude: '',
        AK.attendanceId: '',
      };
      http.Response? response = await CAI.breakInAndOutApi(bodyParams: bodyParamsForBreakInApi);
      if (response != null && response.statusCode == 200) {
       CM.showSnackBar(message: 'Break In');
      }
      else {
        CM.error();
      }
    }catch(e){
      CM.error();
    }

  }

  clickOnBreakConfirmButton() {}


}
