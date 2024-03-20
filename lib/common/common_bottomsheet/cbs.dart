import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/menus_modal.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:http/http.dart' as http;

class CBS {
  static Future<void> commonBottomSheet(
      {required List<Widget> children,
      bool enableDrag = true,
      bool isDismissible = true,
      bool useSafeArea = true,
      bool isFullScreen = false,
      bool showDragHandle = false,
      bool isCloseOnBack = true,
      Color? backGroundColor,
      Color? barrierColor,
      double? elevation,
      double? cornerRadius,
      double? horizontalPadding,
      BorderSide borderSide = BorderSide.none,
      Widget? unScrollWidget,
      GestureTapCallback? onTap}) async {
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: showDragHandle,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: isFullScreen,
      useSafeArea: useSafeArea,
      backgroundColor: backGroundColor ?? Colors.transparent,
      barrierColor: barrierColor,
      elevation: elevation ?? 0.px,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius ?? 20.px),
          topRight: Radius.circular(cornerRadius ?? 20.px),
        ),
        borderSide: borderSide,
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return isCloseOnBack;
          },
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        borderRadius: BorderRadius.circular(17.px),
                        child: Container(
                          width: 34.px,
                          height: 34.px,
                          decoration: BoxDecoration(
                            // color: Col.inverseSecondary,
                            shape: BoxShape.circle,
                            gradient: CW.commonLinearGradientForButtonsView()
                          ),
                          child: Center(
                              child: CW.commonNetworkImageView(
                                  path: 'assets/icons/cancel_white_icon.png',
                                  isAssetImage: true,
                                  height: 10.px,
                                  width: 10.px,
                                  color: Col.text
                              ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cornerRadius ?? 20.px),
                            topRight: Radius.circular(cornerRadius ?? 20.px),
                          ),
                          gradient: CW.commonLinearGradientView()
                        ),
                        child: SingleChildScrollView(
                          child: ClipRRect(
                            borderRadius: showDragHandle
                                ? BorderRadius.zero
                                : BorderRadius.only(
                                    topLeft: Radius.circular(cornerRadius ?? 20.px),
                                    topRight: Radius.circular(cornerRadius ?? 20.px),
                                  ),
                            child: ScrollConfiguration(
                              behavior: ListScrollBehavior(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (unScrollWidget != null)
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: showDragHandle ? 0.px : C.margin,
                                          left: horizontalPadding ?? C.margin,
                                          right: horizontalPadding ?? C.margin,
                                          bottom: horizontalPadding ??
                                              C.margin / 2),
                                      child: unScrollWidget,
                                    ),
                                  Flexible(
                                    child: ListView(
                                      padding: EdgeInsets.only(
                                          left: horizontalPadding ?? C.margin,
                                          right: horizontalPadding ?? C.margin,
                                          top: showDragHandle ? 0.px : C.margin,
                                          bottom: horizontalPadding ??
                                              C.margin / 2),
                                      shrinkWrap: true,
                                      children: children,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> commonDraggableBottomSheet(
      {required List<Widget> children,
      Widget? list,
      bool enableDrag = true,
      bool isDismissible = true,
      bool useSafeArea = true,
      bool isDragOn = true,
      bool showDragHandle = true,
      bool isCloseOnBack = true,
      Color? backGroundColor,
      Color? barrierColor,
      double? elevation,
      double? initialChildSize,
      double? minChildSize,
      double? maxChildSize,
      double? cornerRadius,
      double? horizontalPadding,
      BorderSide borderSide = BorderSide.none,
      Widget? unScrollWidget}) async {
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: showDragHandle,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: isDragOn,
      useSafeArea: useSafeArea,
      backgroundColor: backGroundColor ?? Colors.transparent,
      barrierColor: barrierColor,
      elevation: elevation ?? 0.px,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius ?? 20.px),
          topRight: Radius.circular(cornerRadius ?? 20.px),
        ),
        borderSide: borderSide,
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (context, scrollController) => WillPopScope(
            onWillPop: () async {
              return isCloseOnBack;
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ScrollConfiguration(
                behavior: ListScrollBehavior(),
                child: Column(

                  children: [
                    if (unScrollWidget != null)
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(17.px),
                      child: Container(
                        width: 34.px,
                        height: 34.px,
                        decoration: BoxDecoration(
                          // color: Col.inverseSecondary,
                          shape: BoxShape.circle,
                            gradient: CW.commonLinearGradientForButtonsView()
                        ),
                        child: Center(
                          child: CW.commonNetworkImageView(
                              path: 'assets/icons/cancel_white_icon.png',
                              isAssetImage: true,
                              height: 10.px,
                              width: 10.px,
                              color: Col.text
                          ),
                        ),
                      ),
                    ),
                    if (unScrollWidget != null)
                    SizedBox(height: 10.px),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: CW.commonLinearGradientView(),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cornerRadius ?? 20.px),
                              topRight: Radius.circular(cornerRadius ?? 20.px),
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (unScrollWidget != null)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: showDragHandle ? 0.px : C.margin,
                                    left: horizontalPadding ?? C.margin,
                                    right: horizontalPadding ?? C.margin,
                                    bottom: horizontalPadding ?? C.margin / 2),
                                child: unScrollWidget,
                              ),
                            if (children.isNotEmpty)
                              Expanded(
                                child: ListView(
                                  controller: isDragOn ? scrollController : null,
                                  padding: EdgeInsets.only(
                                      top: showDragHandle ? 0.px : C.margin,
                                      left: horizontalPadding ?? C.margin,
                                      right: horizontalPadding ?? C.margin,
                                      bottom: horizontalPadding ?? C.margin / 2),
                                  shrinkWrap: true,
                                  children: children,
                                ),
                              ),
                            list ?? const SizedBox()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          expand: false,
          initialChildSize: initialChildSize ?? 0.6,
          minChildSize: minChildSize ?? 0.6,
          //initial child size must be grate then minimum child size
          maxChildSize: maxChildSize ?? 0.75,
        );
      },
    );
  }

  static Future<void> commonBottomSheetForImagePicker({
    VoidCallback? clickOnTakePhoto,
    VoidCallback? clickOnChooseFromLibrary,
    // VoidCallback? clickOnRemovePhoto,
    VoidCallback? clickOnCancel,
  }) async {
    await CBS.commonBottomSheet(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.px),
          child: Ink(
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.circular(20.px),
              border: Border.all(color: Col.secondary, width: 1.px),
            ),
            child: Column(
              children: [
                Text(
                  C.textSelectImageTitle,
                  style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.inverseSecondary),
                ),
                SizedBox(height: 20.px),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(onTap: clickOnTakePhoto ?? () {}, title: C.textTakePhoto,textColor: Col.inverseSecondary),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(onTap: clickOnChooseFromLibrary ?? () {}, title: C.textChooseFromLibrary,textColor: Col.inverseSecondary),
                // CW.commonDividerView(
                //   height: 0.px,
                //   wight: .5.px,
                //   color: Col.gray,
                //   leftPadding: 10.px,
                //   rightPadding: 10.px,
                // ),
                // CBS().commonView(onTap: clickOnRemovePhoto ?? () {}, title: C.textRemovePhoto,textColor: Col.inverseSecondary),
              ],
            ),
          ),
        ),
        Center(child: CW.myOutlinedButton(onPressed: clickOnCancel ?? () => Get.back(),buttonText:  C.textCancel,radius: 6.px,width: 350.px,height: 40.px)),
        /*InkWell(
          onTap: clickOnCancel ??
              () {
                Get.back();
              },
          borderRadius: BorderRadius.circular(25.px),
          child: Ink(
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.circular(25.px),
              border: Border.all(color: Col.secondary, width: 1.px),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.px),
              child: Center(
                child: Text(
                  C.textCancel,
                  style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                ),
              ),
            ),
          ),
        ),*/
        SizedBox(height: 20.px)
      ],
      backGroundColor: Colors.transparent,
      showDragHandle: false,
    );
  }

  Widget dividerView() => CW.commonDividerView(
        height: 0.px,
        wight: 2.px,
        color: Col.onSecondary,
        leftPadding: 10.px,
        rightPadding: 10.px,
      );

  Widget commonView({required VoidCallback onTap, required String title,Color? textColor}) => InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10.px), child: textViewTitle(title: title,textColor: textColor)),
          ],
        ),
      );

  Widget textViewTitle({required String title,Color? textColor}) => Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color:textColor),
      );

  ///  Calling Of Country Picker BottomSheet
  static Future<void> commonBottomSheetForCountry({
    required Widget child,
    required TextEditingController searchController,
    required FocusNode focusNode,
    required ValueChanged<String> onChanged,
    bool isSearchEnable = true,
    Widget? unScrollableWidget,
  }) async {
    await CBS.commonDraggableBottomSheet(
      showDragHandle: false,
      unScrollWidget: unScrollableWidget ??
          (isSearchEnable
              ? CW.commonTextField(
                  focusNode: focusNode,
                  hintText: "Search Country",
                  controller: searchController,
                  prefixIconPath: 'assets/icons/search_icon.png',
                  onChanged: onChanged,
                )
              : const SizedBox()),
      children: [
        child,
        SizedBox(
          height: MediaQuery.of(Get.context!).viewInsets.top,
        )
      ],
    );
  }

}

class BottomSheetForOTP extends GetxController {
  static final verifyButtonValue = false.obs;
  static final deviceChangeRequestButtonValue = false.obs;
  static final otpController = TextEditingController();
  static final timer = false.obs;
  static final count = 0.obs;

  static final userDataModal = Rxn<UserDataModal?>();
  static UserDetails? userData;
  static PersonalInfo? personalInfo;
  static ContactInfo? contactInfo;
  static JobInfo? jobInfo;
  static SocialInfo? socialInfo;

  static final companyDetailsModal = Rxn<CompanyDetailsModal?>();
  static GetCompanyDetails? getCompanyDetails;

  static final shiftDetailsModal = Rxn<ShiftDetailsModal>();

  static ShiftDetails? shiftDetails;
  static List<ShiftTime>? shiftTimeList;
  static ShiftTime? shiftTimeForSingleData;
  static final dayValue = ''.obs;

  static final deviceId = ''.obs;
  static final deviceType = ''.obs;
  static final fcmId = ''.obs;

  static Map<String, dynamic> bodyParamsForShiftDetail = {};

  static Map<String, dynamic> bodyParamsSendOtp = {};
  static Map<String, dynamic> otpApiResponseMap = {};

  static Map<String, dynamic> bodyParamsMatchOtp = {};

  static Map<String, dynamic> bodyParamsUpdateFcmId = {};

  static final menusModal = Rxn<MenusModal>();
  static List<GetMenu> isHeadingMenuList = [];
  static Map<String, dynamic> bodyParamsForMenusApi = {};

  static final companyDetailFromLocalDataBase = ''.obs;

  static Future<void> getIdsMethod() async {
    deviceId.value = await CM.getDeviceId();
    deviceType.value = CM.getDeviceType();
    if (Platform.isAndroid) {
      fcmId.value = await FirebaseMessaging.instance.getToken() ?? '';
    } else if (Platform.isIOS) {
      fcmId.value = await CM.generateRandomString();
    }
  }

  static Future<void> sendOtpApiCalling({required String email}) async {
    timer.value = !timer.value;
    try {
      await getIdsMethod();
      otpController.text = '';
      otpController.clear();
      bodyParamsSendOtp = {
        AK.action: ApiEndPointAction.userSentOtp,
        AK.userEmail: email,
        AK.fcmId: fcmId.value,
        AK.deviceId: deviceId.value,
        AK.deviceType: deviceType.value,
      };
      http.Response? response = await CAI.sendOtpApi(bodyParams: bodyParamsSendOtp);
      if (response != null) {
        if (response.statusCode == 200) {
          otpApiResponseMap = jsonDecode(response.body);
          Future.delayed(
            const Duration(seconds: 2),
            () => otpController.text = otpApiResponseMap['otp'].toString(),
          );
        } else {
          CM.error();
        }
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
    }
  }

  static Future<void> matchOtpApiCalling({required String email, required String otp}) async {
    try {
      await getIdsMethod();
      bodyParamsMatchOtp = {
        AK.action: ApiEndPointAction.matchOtp,
        AK.otp: otp,
        AK.userEmail: email,
        AK.fcmId: fcmId.value,
        AK.deviceId: deviceId.value,
        AK.deviceType: deviceType.value,
      };
      userDataModal.value =
          await CAI.matchOtpApi(bodyParams: bodyParamsMatchOtp);
      if (userDataModal.value != null) {
        userData = userDataModal.value?.userDetails;
        await DataBaseHelper().insertInDataBase(data: {
          DataBaseConstant.userDetail: json.encode(userDataModal.value)
        }, tableName: DataBaseConstant.tableNameForUserDetail);
        await BottomSheetForOTP.callingGetCompanyDetailApi();
        companyDetailFromLocalDataBase.value = await DataBaseHelper()
            .getParticularData(
                key: DataBaseConstant.companyDetail,
                tableName: DataBaseConstant.tableNameForCompanyDetail);
        getCompanyDetails = CompanyDetailsModal.fromJson(
                jsonDecode(companyDetailFromLocalDataBase.value))
            .getCompanyDetails;
        await BottomSheetForOTP.callingGetShiftDetailApi();
        await callingMenusApi(companyId: getCompanyDetails?.companyId ?? '');
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        CM.showSnackBar(message: 'LogIn Successfully');
      } else {
        verifyButtonValue.value = false;
        CM.error();
      }
    } catch (e) {
      print('matchOtpApiCalling ::::: error:::: $e');
      verifyButtonValue.value = false;
      CM.error();
    }
    verifyButtonValue.value = false;
  }

  static Future<void> commonBottomSheetForVerifyOtp({required String otp, required String email, required String companyLogo}) async {
    await CBS.commonBottomSheet(
      elevation: 0.px,
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return Obx(() {
              count.value;
              if (otp.isNotEmpty) {
                otpController.text = otp;
              }
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 20.px),
                    children: [
                      Text(
                        'OTP Verification',
                        style: Theme.of(Get.context!).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.px),
                      Center(
                        child: Container(
                          height: 50.px,
                          width: 50.px,
                          decoration: BoxDecoration(
                            color: Col.primary,
                            borderRadius: BorderRadius.circular(8.px),
                          ),
                          child: Center(
                            child:CW.commonNetworkImageView(
                                isAssetImage: companyLogo.isNotEmpty?false:true,
                                path: companyLogo.isNotEmpty
                                    ? '${AU.baseUrlForSearchCompanyImage}$companyLogo'
                                    : 'assets/images/logo.png',
                                height: 50.px,
                                width: 50.px),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.px),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.px),
                        child: CW.commonOtpView(
                          autoFocus: false,
                          controller: otpController,
                          shape: PinCodeFieldShape.box,
                          length: 6,
                          readOnly: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          timer.value
                              ? TextButton(
                              style: TextButton.styleFrom(foregroundColor: Theme.of(Get.context!).colorScheme.background),
                              onPressed: () {},
                              child: Text(
                              "Resend OTP",
                              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
                            ),
                          )
                              : TextButton(
                            onPressed: () async {
                              otp = '';
                              await sendOtpApiCalling(email: email);
                            },
                            child: Text(
                              "Resend OTP",
                              style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
                            ),
                          ),
                          timer.value
                              ? Countdown(
                              seconds: 30,
                              build: (_, double time) {
                              return Text(" in 00:${time.toInt()}",
                                style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                              );
                            },
                            interval: const Duration(milliseconds: 100),
                            onFinished: () {
                              setState(() {
                                timer.value = !timer.value;
                              });
                            },
                          )
                              : const SizedBox(),
                        ],
                      ),
                      SizedBox(height: 12.px),
                      CW.myElevatedButton(
                          onPressed: verifyButtonValue.value
                              ? () => null
                              : () async {
                            if (otpController.text.isNotEmpty) {
                              verifyButtonValue.value = true;
                              await matchOtpApiCalling(email: email, otp: otpController.text.trim().toString());
                              verifyButtonValue.value = false;
                              // await BottomSheetForOTP.callingGetShiftDetailApi();
                            }
                          },
                          isLoading: verifyButtonValue.value,
                          buttonText: 'Verify',
                          height: 42.px),
                    ],
                  ),
                ),
              );
            });
          },
        )
      ],
    ).whenComplete(() {
      CM.unFocusKeyBoard();
      otpController.clear();
      otp = '';
      timer.value = false;
      verifyButtonValue.value = false;
    });
  }

  static Future<void> callingGetCompanyDetailApi() async {
    try {
      companyDetailsModal.value = await CAI.getCompanyDetailsApi(
          bodyParams: {AK.action: ApiEndPointAction.getCompanyDetail});
      if (companyDetailsModal.value != null) {
        getCompanyDetails = companyDetailsModal.value?.getCompanyDetails;
        if (getCompanyDetails != null) {
          if (await DataBaseHelper().isDatabaseHaveData(
              db: DataBaseHelper.dataBaseHelper,
              tableName: DataBaseConstant.tableNameForCompanyDetail)) {
            await DataBaseHelper().insertInDataBase(data: {
              DataBaseConstant.companyDetail:
                  json.encode(companyDetailsModal.value)
            }, tableName: DataBaseConstant.tableNameForCompanyDetail);
          } else {
            await DataBaseHelper().upDateDataBase(data: {
              DataBaseConstant.companyDetail:
                  json.encode(companyDetailsModal.value)
            }, tableName: DataBaseConstant.tableNameForCompanyDetail);
          }
        }
      }
    } catch (e) {
      CM.error();
    }
  }

  static Future<void> callingGetUserDataApi() async {
    final userDataFromLocalDataBase = ''.obs;
    try {
      userDataModal.value = await CAI.getUserDataApi(
          bodyParams: {AK.action: ApiEndPointAction.getUserDetails});
      if (userDataModal.value != null) {
        userData = userDataModal.value?.userDetails;

        userDataFromLocalDataBase.value = await DataBaseHelper()
            .getParticularData(
                key: DataBaseConstant.userDetail,
                tableName: DataBaseConstant.tableNameForUserDetail);
        userData =
            UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value))
                .userDetails;
        userDataModal.value?.userDetails?.token = userData?.token;
        await DataBaseHelper().upDateDataBase(data: {
          DataBaseConstant.userDetail: json.encode(userDataModal.value)
        }, tableName: DataBaseConstant.tableNameForUserDetail);
      }
    } catch (e) {
      CM.error();
    }
  }

  static void day() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;

    switch (currentDay) {
      case DateTime.monday:
        dayValue.value = '1';
        break;
      case DateTime.tuesday:
        dayValue.value = '2';
        break;
      case DateTime.wednesday:
        dayValue.value = '3';
        break;
      case DateTime.thursday:
        dayValue.value = '4';
        break;
      case DateTime.friday:
        dayValue.value = '5';
        break;
      case DateTime.saturday:
        dayValue.value = '6';
        break;
      case DateTime.sunday:
        dayValue.value = '0';
        break;
      default:
        print('Failed to determine the current day');
        break;
    }
  }

  static Future<void> callingGetShiftDetailApi() async {
    bodyParamsForShiftDetail = {AK.action: ApiEndPointAction.getShiftDetail};
    shiftDetailsModal.value =
        await CAI.getShiftDetailApi(bodyParams: bodyParamsForShiftDetail);
    if (shiftDetailsModal.value != null) {
      shiftDetails = shiftDetailsModal.value?.shiftDetails;
      shiftTimeList = shiftDetails?.shiftTime;
      day();
      shiftTimeList?.forEach((element) {
        if (dayValue.value == element.shiftDay) {
          shiftTimeForSingleData = element;
        }
      });
      if (await DataBaseHelper().isDatabaseHaveData(
          db: DataBaseHelper.dataBaseHelper,
          tableName: DataBaseConstant.tableNameForShiftDetail)) {
        await DataBaseHelper().insertInDataBase(data: {
          DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value),
          DataBaseConstant.shiftTime: json.encode(shiftTimeForSingleData)
        }, tableName: DataBaseConstant.tableNameForShiftDetail);
      } else {
        await DataBaseHelper().upDateDataBase(data: {
          DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value),
          DataBaseConstant.shiftTime: json.encode(shiftTimeForSingleData)
        }, tableName: DataBaseConstant.tableNameForShiftDetail);
      }
    }
  }

  static Future<void> callingMenusApi({required String companyId}) async {
    bodyParamsForMenusApi = {
      AK.action: ApiEndPointAction.getDashboardMenu,
      AK.companyId: companyId
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

  static Future<void> callingUpdateFcmIdApi({bool forLogOutFcmId = false}) async {
    try {
      if (forLogOutFcmId) {
        fcmId.value = '';
        deviceType.value = CM.getDeviceType();
      } else {
        await getIdsMethod();
      }
      bodyParamsUpdateFcmId = {
        AK.action: ApiEndPointAction.updateFcmId,
        AK.fcmId: fcmId.value,
        AK.deviceType: deviceType.value,
      };
      http.Response? res =
          await CAI.updateFcmIdApi(bodyParams: bodyParamsUpdateFcmId);
      if (res != null && res.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(res.body);
        CM.showSnackBar(message: '${responseMap['message']}');
      }
    } catch (e) {
      CM.error();
    }
  }

  static Future<void> changeDeviceRequestApi({required String id}) async {
    try {
      await getIdsMethod();
      bodyParamsSendOtp = {
        AK.action: ApiEndPointAction.deviceChangeRequest,
        AK.userId: id,
        AK.fcmId: fcmId.value,
        AK.deviceId: deviceId.value,
        AK.deviceType: deviceType.value,
      };
      http.Response? response = await CAI.sendOtpApi(bodyParams: bodyParamsSendOtp);
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
        } else {
          CM.error();
        }
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
      deviceChangeRequestButtonValue.value = false;
    }
    deviceChangeRequestButtonValue.value = false;
  }

  static Future<void> deviceChangeRequestBottomSheetView({required String message, required String id}) async {
    await CBS.commonBottomSheet(
      elevation: 0.px,
      children: [
        Obx(() {
        count.value;
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20.px),
              children: [
                Center(
                  child: CW.commonNetworkImageView(isAssetImage: true, path:  'assets/images/change_device__request_image.png', height: 100.px, width: 100.px),
                ),
                SizedBox(height: 16.px),
                Text(
                  'Change Device Request',
                  style: Theme.of(Get.context!).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.px),
                Text(message,style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary)),
                SizedBox(height: 24.px),
                CW.myElevatedButton(
                    onPressed: deviceChangeRequestButtonValue.value
                        ? () => null
                        : () async {
                      deviceChangeRequestButtonValue.value = true;
                      await changeDeviceRequestApi(id:id);
                    },
                    isLoading: deviceChangeRequestButtonValue.value,
                    buttonText: 'Send Request',
                    height: 42.px,
                ),
              ],
            ),
          ),
        );
      }),
      ]
    ).whenComplete(() {
      verifyButtonValue.value = false;
    });
  }
}
