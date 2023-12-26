import 'dart:async';
import 'dart:convert';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
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
  static Future<void> commonBottomSheet({
    required List<Widget> children,
    bool enableDrag = true,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool isFullScreen = false,
    bool showDragHandle = true,
    bool isCloseOnBack = true,
    Color? backGroundColor,
    Color? barrierColor,
    double? elevation,
    double? cornerRadius,
    double? horizontalPadding,
    BorderSide borderSide = BorderSide.none,
    Widget? unScrollWidget,
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: showDragHandle,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: isFullScreen,
      useSafeArea: useSafeArea,
      backgroundColor: backGroundColor ?? Colors.white,
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
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            bottom: horizontalPadding ?? C.margin / 2),
                        child: unScrollWidget,
                      ),
                    Flexible(
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: horizontalPadding ?? C.margin,
                            right: horizontalPadding ?? C.margin,
                            top: showDragHandle ? 0.px : C.margin,
                            bottom: horizontalPadding ?? C.margin / 2),
                        shrinkWrap: true,
                        children: children ?? [],
                      ),
                    ),
                  ],
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
      backgroundColor: backGroundColor ?? Colors.white,
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
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      Flexible(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          expand: false,
          initialChildSize: initialChildSize ?? 0.5,
          minChildSize: minChildSize ?? 0.3,
          //initial child size must be grate then minimum child size
          maxChildSize: maxChildSize ?? 0.75,
        );
      },
    );
  }

  static Future<void> commonBottomSheetForImagePicker({
    VoidCallback? clickOnTakePhoto,
    VoidCallback? clickOnChooseFromLibrary,
    VoidCallback? clickOnRemovePhoto,
    VoidCallback? clickOnCancel,
  }) async {
    await CBS.commonBottomSheet(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.px, bottom: 10.px),
          child: Ink(
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.circular(20.px),
              border: Border.all(color: Col.secondary, width: 1.px),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.px),
                  child: Text(
                    C.textSelectImageTitle,
                    style: Theme.of(Get.context!).textTheme.displayLarge,
                  ),
                ),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(
                    onTap: clickOnTakePhoto ?? () {}, title: C.textTakePhoto),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(
                    onTap: clickOnChooseFromLibrary ?? () {},
                    title: C.textChooseFromLibrary),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(
                    onTap: clickOnRemovePhoto ?? () {},
                    title: C.textRemovePhoto),
                SizedBox(height: 10.px),
              ],
            ),
          ),
        ),
        InkWell(
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
                  style: Theme.of(Get.context!)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Col.primary),
                ),
              ),
            ),
          ),
        ),
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

  Widget commonView({required VoidCallback onTap, required String title}) => InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                child: textViewTitle(title: title)),
          ],
        ),
      );

  Widget textViewTitle({required String title}) => Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      );

  ///  Calling Of Country Picker BottomSheet
  static Future<void> commonBottomSheetForCountry({
    required Widget child,
    required TextEditingController searchController,
    required ValueChanged<String> onChanged,
    bool isSearchEnable = true,
    Widget? unScrollableWidget,
  }) async {
    await CBS.commonBottomSheet(
      unScrollWidget: unScrollableWidget ??
          (isSearchEnable
              ? CW.commonTextField(
                  fillColor: Col.gray.withOpacity(0.3),
                  hintText: "Search Country",
                  controller: searchController,
                  hintStyle: Theme.of(Get.context!).textTheme.bodySmall,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Col.secondary,
                  ),
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
  static final otpController = TextEditingController();
  static final timer = false.obs;
  static final count = 0.obs;
  static final userDataModal = Rxn<UserDataModal?>();
  static UserDetails? userData;
  static PersonalInfo? personalInfo;
  static ContactInfo? contactInfo;
  static JobInfo? jobInfo;
  static SocialInfo? socialInfo;

  static Map<String, dynamic> bodyParamsSendOtp = {};
  static Map<String, dynamic> otpApiResponseMap = {};

  static Map<String, dynamic> bodyParamsMatchOtp = {};

  static Future<void> sendOtpApiCalling({required String email}) async {
    timer.value = !timer.value;
    try {
      otpController.text = '';
      otpController.clear();
      bodyParamsSendOtp = {
        AK.action: 'userSentOtp',
        AK.userEmail: email,
      };
      http.Response? response =
          await CAI.sendOtpApi(bodyParams: bodyParamsSendOtp);
      if (response != null && response.statusCode == 200) {
        otpApiResponseMap = jsonDecode(response.body);
        Future.delayed(
          const Duration(seconds: 2),
          () => otpController.text = otpApiResponseMap['otp'].toString(),
        );
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
    }
  }

  static Future<void> matchOtpApiCalling({required String email, required String otp}) async {
    try {
      bodyParamsMatchOtp = {
        AK.action: 'matchOtp',
        AK.otp: otp,
        AK.userEmail: email,
      };
      userDataModal.value =
          await CAI.matchOtpApi(bodyParams: bodyParamsMatchOtp);
      if (userDataModal.value != null) {
          userData = userDataModal.value?.userDetails;
        if (userData?.token != null && userData!.token!.isNotEmpty ||
            userData?.personalInfo != null || userData?.contactInfo != null || userData?.jobInfo != null || userData?.socialInfo != null) {

          personalInfo = userData?.personalInfo;
          contactInfo = userData?.contactInfo;
          jobInfo = userData?.jobInfo;
          socialInfo = userData?.socialInfo;

            DataBaseHelper().insertInDataBase(data: personalInfo!.toJson(),tableName: DataBaseConstant.tableNameForPersonalInfo);

            DataBaseHelper().insertInDataBase(data: contactInfo!.toJson(),tableName: DataBaseConstant.tableNameForContactInfo);

            DataBaseHelper().insertInDataBase(data: jobInfo!.toJson(),tableName: DataBaseConstant.tableNameForJobInfo);

            DataBaseHelper().insertInDataBase(data: socialInfo!.toJson(),tableName: DataBaseConstant.tableNameForSocialInfo);

            DataBaseHelper().insertInDataBase(data: {'token':userData?.token},tableName: DataBaseConstant.tableNameForUserToken);

          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
          CM.showSnackBar(message: 'LogIn Successfully');

        }
      } else {
        verifyButtonValue.value = false;
        CM.error();
      }
    } catch (e) {
      verifyButtonValue.value = false;
      CM.error();
    }
    verifyButtonValue.value = false;
  }

  static Future<void> commonBottomSheetForVerifyOtp({required String otp, required String email}) async {
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      elevation: 0.px,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.px),
          topRight: Radius.circular(20.px),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Obx(() {
              count.value;
              if (otp.isNotEmpty) {
                Future.delayed(
                  const Duration(seconds: 2),
                  () => otpController.text = otp,
                );
              }
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        bottom: 34.px, left: 18.px, right: 18.px),
                    children: [
                      Text(
                        'OTP Verification',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Col.text),
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
                            child: CW.commonNetworkImageView(
                                isAssetImage: true,
                                path: 'assets/images/logo.png',
                                height: 24.px,
                                width: 24.px),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.px),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.px),
                        child: CW.commonOtpView(
                            autoFocus: false,
                            controller: otpController,
                            shape: PinCodeFieldShape.box,
                            length: 6,
                            readOnly: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          timer.value
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(Get.context!)
                                          .colorScheme
                                          .background),
                                  onPressed: () {},
                                  child: Text("Resend OTP",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    otp = '';
                                    await sendOtpApiCalling(email: email);
                                  },
                                  child: Text("Resend OTP",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                ),
                          timer.value
                              ? Countdown(
                                  seconds: 10,
                                  build: (_, double time) {
                                    return Text(
                                      " in 00:${time.toInt()}",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CW.commonOutlineButton(
                                onPressed: () {
                                  Get.back();
                                },
                                buttonText: 'Back',
                                // width: 174.px,
                                height: 42.px,
                                borderRadius: C.radius),
                          ),
                          SizedBox(width: 10.px),
                          Expanded(
                            child: CW.commonElevatedButton(
                                onPressed: () async {
                                  if (otpController.text.isNotEmpty) {
                                    verifyButtonValue.value = true;
                                    await matchOtpApiCalling(
                                        email: email,
                                        otp: otpController.text
                                            .trim()
                                            .toString());
                                  }
                                },
                                isLoading: verifyButtonValue.value,
                                buttonText: 'Verify',
                                height: 42.px),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      },
    ).whenComplete(() {
      CM.unFocusKeyBoard();
      otpController.clear();
      otp = '';
      timer.value = false;
      verifyButtonValue.value = false;
    });
  }
}
