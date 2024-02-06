import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/get_break_details_modal.dart';
import 'package:task/api/api_model/get_today_attendance_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/drawer_view/controllers/drawer_view_controller.dart';
import 'package:task/app/modules/home/dialog/break_dialog.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_packages/shimmer/shimmer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:geolocator/geolocator.dart' as geo;
import '../../../../common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final count = 0.obs;
  final apiResValue = true.obs;

  final scrollController = ScrollController().obs;

  final breakValue = false.obs;
  final breakTypeIdCheckBoxValue = ''.obs;
  final breakDialogConfirmButtonValue = false.obs;
  final getBreakDetailsModal = Rxn<GetBreakDetailsModal>();
  List<GetBreakDetails>? getBreakDetailsList;

  final checkInValue = false.obs;

  final checkOutValue = false.obs;

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

  final shiftDetailFromLocalDataBase = ''.obs;
  ShiftDetails? shiftDetails;
  final shiftTimeFromLocalDataBase = ''.obs;
  ShiftTime? shiftTime;
  GetLatLong? getLatLong;

  Map<String, dynamic> bodyParamsForAttendancePunchInApi = {};

  final punchInAndPunchOutRange = 0.0.obs;

  Map<String, dynamic> bodyParamsForAttendancePunchOutApi = {};

  Map<String, dynamic> bodyParamsForBreakInApi = {};
  Map<String, dynamic> bodyParamsForBreakOutApi = {};

  final getTodayAttendanceModal = Rxn<GetTodayAttendanceModal>();
  GetTodayAttendance? getTodayAttendanceDetail;
  Map<String, dynamic> bodyParamsForGetTodayAttendanceApi = {};

  late DateTime currentDateTime = DateTime.now();
  late DateTime currentTimeForTimer = DateTime(0, 0, 0, 0, 0, 0, 0);
  late DateTime currentTimeForBreakTimer = DateTime(0, 0, 0, 0, 0, 0, 0);
  late Timer timer;
  final isTimerStartedValue = false.obs;

  final hours = 0.obs;
  final minutes = 0.obs;
  final seconds = 0.obs;
  final total = 540.obs;
  final workingMinutes = 0.obs;
  final linerValue = 0.0.obs;

  final key = GlobalKey<FormState>();
  final lateInAndLateOutRangeController = TextEditingController();
  final lateInAndLateOutRangeReasonController = TextEditingController();
  final image = Rxn<File?>();
  late AnimationController rotationController;
  String punchInOutOfRange = '0';
  final isLatePunchIn = false.obs;

  final punchInAndPunchOutButtonValue = false.obs;
  final confirmBreakButtonValue = false.obs;

  final isEarlyPunchOut = false.obs;

  final initialPosition = const CameraPosition(target: LatLng(0, 0)).obs;
  final Completer<GoogleMapController> googleController = Completer<GoogleMapController>();


  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      Get.put(DrawerViewController());
      rotationController = AnimationController(duration: const Duration(milliseconds: 30000), vsync: this);
      rotationController.forward(from: 0.0);
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

  double calculateTheLatLongDistanceInMeter({required double lat1, required double lon1, required double lat2, required double lon2}) {
    const double p = 0.017453292519943295; // Math.PI / 180
    const double earthRadius = 6371.0; // Radius of the Earth in kilometers
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 2 *
        earthRadius *
        asin(sqrt(a)) *
        1000; // Multiply by 1000 to convert to meters
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
      currentDateTime = await getInternetDateTime();
      if (getLatLong != null) {
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

  Future<void> getCurrentLocation() async {
    try {
      var currentPosition = await geo.Geolocator.getLastKnownPosition();
      if (currentPosition != null) {
        initialPosition.value = CameraPosition(
          target: LatLng(
            currentPosition.latitude,
            currentPosition.longitude,
          ),
          zoom: 18,
        );

        currentPosition = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);

        CameraPosition cameraPosition = CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude), zoom: 18);
        googleController.future.then((value) => value.animateCamera(CameraUpdate.newCameraPosition(cameraPosition)));

      } else {
        initialPosition.value = const CameraPosition(target: LatLng(20.5937, 78.9629));
      }
    }catch(e){
      if(kDebugMode){
        print("Exception caught $e");
        CM.showToast('Exception caught $e');
      }
    }
  }

  Future<void> setDefaultData() async {
    try {
      await companyData();
      await shiftData();
      await appMenusData();
      await callingGetTodayAttendanceApi();
      await callingGetBreakDetailsApi();
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
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
      await BottomSheetForOTP.callingGetShiftDetailApi();
      shiftDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.shiftDetails, tableName: DataBaseConstant.tableNameForShiftDetail);
      shiftDetails = ShiftDetailsModal.fromJson(jsonDecode(shiftDetailFromLocalDataBase.value)).shiftDetails;
      shiftTimeFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.shiftTime, tableName: DataBaseConstant.tableNameForShiftDetail);
      shiftTime = ShiftTime.fromJson(jsonDecode(shiftTimeFromLocalDataBase.value));
    } catch (e) {
      print('e:::shiftTime:::: :::::::   $e');
    }
  }

  Future<void> appMenusData() async {
    try {
      if (isDatabaseHaveDataForAppMenu.value) {
        await callingMenusApi();
      } else {
        appMenuFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.appMenus, tableName: DataBaseConstant.tableNameForAppMenu);
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

  Future<void> callingGetBreakDetailsApi() async {
    try {
      getBreakDetailsModal.value = await CAI.getBreakDetailsApi(
          bodyParams: {AK.action: ApiEndPointAction.getBreak});
      if (getBreakDetailsModal.value != null) {
        getBreakDetailsList = getBreakDetailsModal.value?.getBreakDetails;
      }
    } catch (e) {
      CM.error();
    }
  }

  Future<void> startTimer() async {
    DateTime punchInDateTime = DateTime.parse("${getTodayAttendanceDetail?.punchInDate} ${getTodayAttendanceDetail?.punchInTime}");

    DateTime currentTime = await getInternetDateTime();

    Duration difference = currentTime.difference(punchInDateTime);

    hours.value = difference.inHours;
    minutes.value = (difference.inMinutes % 60);
    seconds.value = (difference.inSeconds % 60);

    currentTimeForTimer = DateTime(0, 0, 0, hours.value, minutes.value, seconds.value);

    workingMinutes.value = currentTimeForTimer.hour * 3600 + currentTimeForTimer.minute * 60;

    if (!isTimerStartedValue.value) {
      isTimerStartedValue.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), updateTimeForTimer);
    } else {
      timer.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), updateTimeForTimer);
    }
  }

  Future<void> updateTimeForTimer(Timer timer) async {
    if (shiftTime?.totalShiftMinutes != null && shiftTime!.totalShiftMinutes!.isNotEmpty) {
      total.value = int.parse('${shiftTime?.totalShiftMinutes}');
      if (checkInValue.value && checkOutValue.value) {
        // linerValue.value = hours.value * 60  / total.value;
        linerValue.value = workingMinutes.value / (total.value * 60);
      } else {
        workingMinutes.value++;
        linerValue.value = workingMinutes.value / (total.value * 60);
        // print('workingMinutes.value  :::::::  ${workingMinutes.value}      total.value * 60:::::::   ${total.value * 60}');
      }
    }
    currentTimeForTimer = currentTimeForTimer.add(const Duration(seconds: 1));
    if (breakValue.value) {
      DateTime punchInDateTime = DateTime.parse("${getTodayAttendanceDetail?.punchInDate} ${getTodayAttendanceDetail?.breakStartTime}");

      DateTime currentTime = await getInternetDateTime();

      Duration difference = currentTime.difference(punchInDateTime);

      int hoursForBreak = difference.inHours;
      int minutesForBreak = (difference.inMinutes % 60);
      int secondsForBreak = (difference.inSeconds % 60);

      currentTimeForBreakTimer = DateTime(0, 0, 0, hoursForBreak, minutesForBreak, secondsForBreak);
      currentTimeForBreakTimer = currentTimeForBreakTimer.add(const Duration(seconds: 1));

    }
    count.value++;
  }

  Future<void> clickOnSwitchButton() async {
    await punchInAndPunchOutBottomSheetView();
  }

  Future<void> punchInAndPunchOutBottomSheetView() async {
    rotationController.stop();
    getCurrentLocation();

    DateTime currentTimeForPunchIn = await getInternetDateTime();
    String formattedDateForPunchIn = DateFormat("yyyy-MM-dd").format(currentTimeForPunchIn);

    DateTime punchInDateTimeForPunchIn = DateTime.parse("$formattedDateForPunchIn ${shiftTime?.shiftStartTime}");

    punchInDateTimeForPunchIn = punchInDateTimeForPunchIn.add(Duration(minutes: int.parse('${shiftTime?.lateInMinutes}')));

    isLatePunchIn.value = currentTimeForPunchIn.isAfter(punchInDateTimeForPunchIn);

    DateTime currentTimeForPunchOut = await getInternetDateTime();
    String formattedDateForPunchOut = DateFormat("yyyy-MM-dd").format(currentTimeForPunchOut);

    DateTime punchOutDateTimeForPunchOut = DateTime.parse("$formattedDateForPunchOut ${shiftTime?.shiftEndTime}");

    punchOutDateTimeForPunchOut = punchOutDateTimeForPunchOut.subtract(Duration(minutes: int.parse('${shiftTime?.earlyOutMinutes}')));

    isEarlyPunchOut.value = currentTimeForPunchOut.isBefore(punchOutDateTimeForPunchOut);

    CBS.commonBottomSheet(
      showDragHandle: false,
      isDismissible: false,
      isFullScreen: true,
      onTap: () {
        CM.unFocusKeyBoard();
      },
      children: [
        Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               //    initialPosition.value.target.longitude != 0
          //     ? Container(
          // height: 200.px,
          //   decoration: BoxDecoration(
          //     color: Theme.of(Get.context!).colorScheme.onBackground,
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(6.px),
          //     ),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.all(Radius.circular(6.px)),
          //     child: GoogleMap(
          //       mapType: MapType.normal,
          //       buildingsEnabled: true,
          //       compassEnabled: false,
          //       rotateGesturesEnabled: false,
          //       myLocationButtonEnabled: false,
          //       indoorViewEnabled: false,
          //       trafficEnabled: true,
          //       initialCameraPosition: initialPosition.value,
          //       onMapCreated: (mapController) => googleController.complete(mapController),
          //       myLocationEnabled: true,
          //       zoomGesturesEnabled: false,
          //       zoomControlsEnabled: false,
          //     ),
          //   ),
          // )
          //     : CW.commonShimmerViewForImage(height: 200.px),
          //      SizedBox(height: 16.px),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CW.commonNetworkImageView(
                      path: 'assets/icons/location_icon.png',
                      isAssetImage: true,
                      width: 18.px,
                      height: 18.px,
                      color: punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}')
                          ? Col.primary
                          : Col.error),
                  if (punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}'))
                    SizedBox(width: 6.px),
                    Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}')
                              ? 'You are in range'
                              : 'You are out of range: ',
                          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                                  color: punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}') ? Col.primary : Col.error,
                                  fontWeight: FontWeight.w600),
                        ),
                        if (punchInAndPunchOutRange.value > double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}'))
                          Flexible(
                            child: Obx(() {
                              count.value;
                              return Text(
                                '${punchInAndPunchOutRange.value.toInt()} meter',
                                 style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.primary, fontSize: 12.px),
                                 maxLines: 2,
                              );
                            }),
                          ),
                      ],
                    ),
                  ),
                  if (punchInAndPunchOutRange.value > double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}'))
                    CW.commonElevatedButton(
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      height: 30.px,
                      width: 30.px,
                      borderRadius: 4.px,
                      onPressed: () async {
                        rotationController.forward(from: 0.0);
                        await Future.delayed(const Duration(seconds: 2), () async {});
                        getLatLogDistanceInMeterMethod();
                        getCurrentLocation();
                        rotationController.stop();
                      },
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 30.0)
                            .animate(rotationController),
                        child: Icon(Icons.refresh,
                            color: Col.inverseSecondary, size: 20.px),
                      ),
                    ),
                ],
              ),
               SizedBox(height: 16.px),
               Card(
                 elevation: 0,
                margin: EdgeInsets.zero,
                color: Col.gray.withOpacity(.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.px)
                ),
                child: Padding(
                  padding:  EdgeInsets.all(8.px),
                  child: Column(
                    children: [
                      !checkInValue.value
                          ? isLatePunchIn.value
                          ? CW.commonTextFieldForMultiline(
                        contentPadding: EdgeInsets.all(8.px),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        borderRadius: 4.px,
                        controller: lateInAndLateOutRangeController,
                        labelText: shiftDetails?.lateInReasonRequired == '1'
                            ? 'Late in reason*'
                            : 'Late in reason',
                        hintText: shiftDetails?.lateInReasonRequired == '1'
                            ? 'Late in reason*'
                            : 'Late in reason',
                        validator: (value) {
                          if (isLatePunchIn.value) {
                            if (value == null ||
                                value.trim().toString().isEmpty) {
                              return "Please enter late reason";
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                      )
                          : const SizedBox()
                          : isEarlyPunchOut.value
                          ? CW.commonTextFieldForMultiline(
                        contentPadding: EdgeInsets.all(8.px),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        borderRadius: 4.px,
                        controller: lateInAndLateOutRangeController,
                        labelText: shiftDetails?.lateInReasonRequired == '1'
                            ? 'Early out reason*'
                            : 'Early out reason',
                        hintText: shiftDetails?.lateInReasonRequired == '1'
                            ? 'Early out reason*'
                            : 'Early out reason',
                        validator: (value) {
                          if (isEarlyPunchOut.value) {
                            if (value == null ||
                                value.trim().toString().isEmpty) {
                              return "Please enter early out reason";
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                      )
                          : const SizedBox(),
                      if (punchInAndPunchOutRange.value > double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}'))
                        SizedBox(height: 5.px),
                      if (punchInAndPunchOutRange.value > double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}'))
                        CW.commonTextFieldForMultiline(
                            contentPadding: EdgeInsets.all(8.px),
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            borderRadius: 4.px,
                            controller: lateInAndLateOutRangeReasonController,
                            labelText: shiftDetails?.outOfRangeReasonRequired == '1'
                                ? 'Out of range reason*'
                                : 'Out of range reason',
                            hintText: 'Type here',
                            validator: (value) {
                              if (punchInAndPunchOutRange.value >
                                  double.parse(
                                      '${getTodayAttendanceDetail?.branchGeofenceRange}')) {
                                if (value == null || value.trim().toString().isEmpty) {
                                  return "Please enter out of reason";
                                } else {
                                  return null;
                                }
                              } else {
                                return null;
                              }
                            }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.px),
        Row(
          children: [
            Expanded(
              child: CW.commonOutlineButton(
                onPressed: () {
                  Get.back();
                },
                height: 40.px,
                borderRadius: 4.px,
                borderWidth: 1.px,
                borderColor: Col.darkGray,
                child: Text(
                  'Close',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Col.darkGray),
                ),
              ),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Obx(() {
                count.value;
                return CW.commonElevatedButton(
                  borderRadius: 4.px,
                  height: 40.px,
                  onPressed: !checkInValue.value
                      ? punchInAndPunchOutButtonValue.value?() => null : () => clickOnPunchInButton()
                      : punchInAndPunchOutButtonValue.value?() => null : () => clickOnPunchOutButton(),
                  isLoading: punchInAndPunchOutButtonValue.value,
                  progressBarWidth: 20.px,
                  progressBarHeight: 20.px,
                  child: Text(
                    !checkInValue.value ? 'Punch In' : 'Punch out',
                    style: Theme.of(Get.context!).textTheme.labelLarge,
                  ),
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 20.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Auto Close in : ",
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            Countdown(
              seconds: 60,
              build: (_, double time) {
                return Text(
                  "00:${time.toInt()}",
                  style: Theme.of(Get.context!).textTheme.titleLarge,
                );
              },
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                Get.back();
              },
            ),
          ],
        ),
        SizedBox(height: 20.px),
      ],
    ).whenComplete(() {
      punchInAndPunchOutButtonValue.value=false;
      apiResValue.value=false;
      lateInAndLateOutRangeController.clear();
      lateInAndLateOutRangeReasonController.clear();
    });
  }

  Future<void> clickOnPunchInButton() async {
    CM.unFocusKeyBoard();
    if (isLatePunchIn.value) {
      if (key.currentState!.validate()) {
        await callingAttendancePunchInApi();
      }
    } else {
      await callingAttendancePunchInApi();
    }
  }

  Future<void> clickOnPunchOutButton() async {
    CM.unFocusKeyBoard();
    if (isEarlyPunchOut.value) {
      if (key.currentState!.validate()) {
        await callingAttendancePunchOutApi();
      }
    } else {
      await callingAttendancePunchOutApi();
    }
  }

  Future<void> clickOnTakeBreakButton() async {
    if (getBreakDetailsModal.value != null) {
      if (getBreakDetailsList != null && getBreakDetailsList!.isNotEmpty) {
        breakTypeIdCheckBoxValue.value = '';
        await showDialog(
            context: Get.context!,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: const BreakDialog(),
              );
            });
      } else {
        CM.showSnackBar(message: 'Break not found!');
      }
    } else {
      CM.showSnackBar(message: 'Break not found!');
    }
  }

  Future<void> clickOnConfirmBreakButton() async {
    breakDialogConfirmButtonValue.value = true;
    confirmBreakButtonValue.value = true;
    await callingBreakInApi();
  }

  Future<void> clickOnBreakEndButton() async {
    await callingBreakOutApi();
  }

  void clickOnUpcomingCelebrationsButton() {}

  void clickOnHeadingCards({required int headingCardIndex}) {
    if (isHeadingMenuList[headingCardIndex].menuClick == 'circular') {
      Get.toNamed(Routes.CIRCULAR,
          arguments: [isHeadingMenuList[headingCardIndex].menuName]);
    } else if (isHeadingMenuList[headingCardIndex].menuClick == 'attendance') {
      Get.toNamed(Routes.ATTENDANCE_TRACKER,
          arguments: [isHeadingMenuList[headingCardIndex].menuName]);
    } else {
      CM.showSnackBar(message: 'Coming soon');
    }
  }

  void clickOnMyTeamCards({required int myTeamCardIndex}) {}

  void clickOnYourDepartmentViewAllButton() {}

  void clickOnYourDepartmentCards({required int yourDepartmentCardIndex}) {}

  void clickOnGalleryViewAllButton() {}

  Future<void> callingMenusApi() async {
    bodyParamsForMenusApi = {
      AK.action: ApiEndPointAction.getDashboardMenu,
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
        await DataBaseHelper().upDateDataBase(
            data: {DataBaseConstant.appMenus: json.encode(menusModal.value)},
            tableName: DataBaseConstant.tableNameForAppMenu);
      }
    }
  }

  Future<DateTime> getInternetDateTime() async {
    final response =
        await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String utcDateTimeString = data['utc_datetime'];
      final DateTime utcDateTime = DateTime.parse(utcDateTimeString);
      final DateTime istDateTime =
          utcDateTime.add(const Duration(hours: 5, minutes: 30));

      DateTime currentTime = DateTime.parse(
          DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(istDateTime));

      return currentTime;
    } else {
      throw Exception('Failed to load IST date and time');
    }
  }

  Future<void> callingGetTodayAttendanceApi() async {
    bodyParamsForGetTodayAttendanceApi = {
      AK.action: ApiEndPointAction.getTodayAttendance,
    };
    getTodayAttendanceModal.value = await CAI.getTodayAttendanceApi(bodyParams: bodyParamsForGetTodayAttendanceApi);
    if (getTodayAttendanceModal.value != null) {
      getTodayAttendanceDetail = getTodayAttendanceModal.value?.getTodayAttendance;
      checkOutValue.value = getTodayAttendanceDetail?.isPunchOut ?? false;
      checkInValue.value = getTodayAttendanceDetail?.isPunchIn ?? false;
      breakValue.value = getTodayAttendanceDetail?.isBreak ?? false;
      if (checkInValue.value && checkOutValue.value) {
        DateTime punchInDateTime = DateTime.parse("${getTodayAttendanceDetail?.punchInDate} ${getTodayAttendanceDetail?.punchInTime}");
        DateTime punchOutDateTime = DateTime.parse("${getTodayAttendanceDetail?.punchOutDate} ${getTodayAttendanceDetail?.punchOutTime}");
        Duration difference = punchOutDateTime.difference(punchInDateTime);
        hours.value = difference.inHours;
        minutes.value = (difference.inMinutes % 60);
        seconds.value = (difference.inSeconds % 60);
        timer.cancel();
      }

      else {
        if (checkInValue.value) {
          startTimer();
        }
      }
      getLatLogDistanceInMeterMethod();
      print('i:::: ${punchInAndPunchOutRange.value}');
    }
  }

  Future<void> callingAttendancePunchInApi() async {
    punchInAndPunchOutButtonValue.value = true;
    apiResValue.value = true;
    getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
    if (punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}')) {
      punchInOutOfRange = '1';
    }
    try {
      bodyParamsForAttendancePunchInApi = {
        AK.action: ApiEndPointAction.attendancePunchIn,
        AK.lateInReason: lateInAndLateOutRangeController.text.trim().toString(),
        AK.punchInLatitude: '${getLatLong?.latitude}',
        AK.punchInLongitude: '${getLatLong?.longitude}',
        AK.punchInRange: '${punchInAndPunchOutRange.value}',
        AK.punchInOutOfRange: punchInOutOfRange,

        AK.punchLateIn: isLatePunchIn.value?'1':'0',
        AK.punchInOutOfRangeReason: lateInAndLateOutRangeReasonController.text.trim().toString(),
        AK.shiftType: shiftTime?.shiftType ?? '',
      };
      http.Response? response = await CAI.attendancePunchInAndPunchOutApi(
          bodyParams: bodyParamsForAttendancePunchInApi,
          userProfileImageKey: AK.punchInImage,
          image: image.value);
      if (response != null) {
        if (response.statusCode == 200) {
          CM.showSnackBar(message: 'Punch In Successful');
          // currentDateTimeForPunchIn.value = await getInternetDateTime();
          await callingGetTodayAttendanceApi();
          Get.back();
        } else {
          CM.error();
          await callingGetTodayAttendanceApi();
          Get.back();
        }
      } else {
        CM.error();
        await callingGetTodayAttendanceApi();
        Get.back();
      }
    } catch (e) {
      punchInAndPunchOutButtonValue.value = false;
      apiResValue.value = false;
      Get.back();
    }
    punchInAndPunchOutButtonValue.value = false;
    apiResValue.value = false;
    Get.back();
  }

  Future<void> callingAttendancePunchOutApi() async {
    punchInAndPunchOutButtonValue.value = true;
    apiResValue.value = true;

    getLatLong = await MyLocation.getUserLatLong(context: Get.context!);

    if (punchInAndPunchOutRange.value < double.parse('${getTodayAttendanceDetail?.branchGeofenceRange}')) {
      punchInOutOfRange = '1';
    }

    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      bodyParamsForAttendancePunchOutApi = {
        AK.action: ApiEndPointAction.attendancePunchOut,
        AK.attendanceId: getTodayAttendanceDetail?.attendanceId ?? "",
        AK.punchOutLatitude: '${getLatLong?.latitude}',
        AK.punchOutLongitude: '${getLatLong?.longitude}',
        AK.punchOutOutOfRange: lateInAndLateOutRangeReasonController.text.trim().toString(),
        AK.punchOutOutOfRangeReason: punchInOutOfRange,
        AK.earlyOutReason: lateInAndLateOutRangeController.text.trim().toString(),
        AK.punchOutRange: '${punchInAndPunchOutRange.value}',
        AK.earlyOut: isEarlyPunchOut.value ? '1' : '0',
      };
      http.Response? response = await CAI.attendancePunchInAndPunchOutApi(
          bodyParams: bodyParamsForAttendancePunchOutApi,
          userProfileImageKey: AK.punchOutImage,
          image: image.value);
      if (response != null) {
        if (response.statusCode == 200) {
          CM.showSnackBar(message: 'Punch Out Successful');
          Get.back();
          timer.cancel();
          currentTimeForTimer = DateTime(0, 0, 0, 0, 0, 0);
          await callingGetTodayAttendanceApi();
          Get.back();
        } else {
          CM.error();
          Get.back();
        }
      } else {
        CM.error();
        Get.back();
      }
    } catch (e) {
      punchInAndPunchOutButtonValue.value = false;
      apiResValue.value = false;
      Get.back();
    }
    punchInAndPunchOutButtonValue.value = false;
    apiResValue.value = false;
    Get.back();
  }

  Future<void> callingBreakInApi() async {
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      bodyParamsForBreakInApi = {
        AK.action: ApiEndPointAction.breakIn,
        AK.breakTypeId: breakTypeIdCheckBoxValue.value,
        AK.breakStartLatitude: '${getLatLong?.latitude}',
        AK.breakStartLongitude: '${getLatLong?.longitude}',
        AK.attendanceId: getTodayAttendanceDetail?.attendanceId ?? '',
      };
      http.Response? response = await CAI.breakInAndOutApi(bodyParams: bodyParamsForBreakInApi);
      if (response != null && response.statusCode == 200) {
        confirmBreakButtonValue.value=false;
        await callingGetTodayAttendanceApi();
        Get.back();
      } else {
        confirmBreakButtonValue.value=false;
        CM.error();
        Get.back();
      }
    } catch (e) {
      confirmBreakButtonValue.value=false;
      CM.error();
      Get.back();
    }
  }

  Future<void> callingBreakOutApi() async {
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      bodyParamsForBreakInApi = {
        AK.action: ApiEndPointAction.breakOut,
        AK.breakHistoryId: getTodayAttendanceDetail?.breakHistoryId ?? '',
        AK.breakEndLatitude: '${getLatLong?.latitude}',
        AK.breakEndLongitude: '${getLatLong?.longitude}',
        AK.attendanceId: getTodayAttendanceDetail?.attendanceId ?? '',
      };
      http.Response? response =
          await CAI.breakInAndOutApi(bodyParams: bodyParamsForBreakInApi);
      if (response != null && response.statusCode == 200) {
        await callingGetTodayAttendanceApi();
      } else {
        CM.error();
        await callingGetTodayAttendanceApi();
      }
    } catch (e) {
      CM.error();
    }
  }

  void getLatLogDistanceInMeterMethod() {
    punchInAndPunchOutRange.value = calculateTheLatLongDistanceInMeter(
      lat1: double.parse('${getTodayAttendanceDetail?.branchGeofenceLatitude}'),
      lon1: double.parse('${getTodayAttendanceDetail?.branchGeofenceLongitude}'),
      lat2: double.parse('${getLatLong?.latitude}'),
      lon2: double.parse('${getLatLong?.longitude}'),
    );
  }

}
