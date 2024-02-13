import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CD {
  static Future<void> commonIosAlertDialogBox(
      {required String title,
      String? content,
      String? leftButtonTitle,
      String? rightButtonTitle,
      TextStyle? leftTitleStyle,
      TextStyle? rightTitleStyle,
      TextStyle? titleStyle,
      TextStyle? contentStyle,
      VoidCallback? clickOnLeftButton,
      VoidCallback? clickOnRightButton,
      bool isDismiss = true,
      bool isBackOn = true}) async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return isBackOn;
          },
          child: CupertinoAlertDialog(
            title: Text(
              title,
              style:
                  titleStyle ?? Theme.of(Get.context!).textTheme.displayLarge,
            ),
            content: content != null
                ? Text(
                    content,
                    style: contentStyle ??
                        Theme.of(Get.context!).textTheme.labelMedium,
                  )
                : const SizedBox(),
            actions: [
              if (leftButtonTitle != null)
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: clickOnLeftButton,
                  child: Text(
                    leftButtonTitle,
                    style: leftTitleStyle ??
                        Theme.of(Get.context!)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Col.primary),
                  ),
                ),
              if (rightButtonTitle != null)
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: clickOnRightButton,
                  child: Text(
                    rightButtonTitle,
                    style: rightTitleStyle ??
                        Theme.of(Get.context!)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Col.primary),
                  ),
                ),
            ],
            insetAnimationDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      useSafeArea: true,
      barrierDismissible: isDismiss,
    );
  }

  static Future<void> commonIosLogoutDialog(
      {required VoidCallback clickOnCancel,
      required VoidCallback clickOnLogout,
      bool isDismiss = true}) async {
    await CD.commonIosAlertDialogBox(
        title: C.textLogOutDialogTitle,
        content: C.textLogOutDialogContent,
        clickOnLeftButton: clickOnCancel,
        clickOnRightButton: clickOnLogout,
        leftButtonTitle: C.textCancel,
        rightButtonTitle: C.textLogout,
        isDismiss: isDismiss);
  }

  static Future<void> commonIosDeleteConfirmationDialog(
      {required VoidCallback clickOnCancel,
      required VoidCallback clickOnDelete,
      bool isDismiss = true}) async {
    await CD.commonIosAlertDialogBox(
        title: C.textDeleteDialogTitle,
        content: '${C.textDeleteDialogContent}',
        clickOnLeftButton: clickOnCancel,
        clickOnRightButton: clickOnDelete,
        leftButtonTitle: C.textCancel,
        rightButtonTitle: C.textDeleteDialogTitle,
        isDismiss: isDismiss);
  }

  static Future<void> commonIosExitAppDialog(
      {required VoidCallback clickOnCancel,
      required VoidCallback clickOnExit,
      bool isDismiss = true}) async {
    await CD.commonIosAlertDialogBox(
        title: C.textExitDialogTitle,
        content: C.textExitDialogContent,
        clickOnLeftButton: clickOnCancel,
        clickOnRightButton: clickOnExit,
        leftButtonTitle: C.textCancel,
        rightButtonTitle: C.textExit,
        isDismiss: isDismiss);
  }

  static Future<void> commonIosPermissionDialog(
      {required VoidCallback clickOnPermission,
      bool isDismiss = false,
      bool isBackOn = false}) async {
    await CD.commonIosAlertDialogBox(
        title: C.textPermission,
        content: C.textPermissionDialogContent,
        clickOnRightButton: clickOnPermission,
        rightButtonTitle: C.textGivePermission,
        isDismiss: isDismiss,
        isBackOn: isBackOn);
  }

  static Future<void> commonIosPickImageDialog(
      {required VoidCallback clickOnCamera,
      required VoidCallback clickOnGallery,
      bool isDismiss = true}) async {
    await CD.commonIosAlertDialogBox(
        title: C.textSelectImageTitle,
        content: C.textImageDialogContent,
        clickOnLeftButton: clickOnCamera,
        clickOnRightButton: clickOnGallery,
        leftButtonTitle: C.textCamera,
        rightButtonTitle: C.textGallery,
        isDismiss: isDismiss);
  }

  static Future<void> commonAndroidAlertDialogBox({
    Widget? titleWidget,
    String? title,
    WidgetBuilder? builder,
    String? content,
    String? leftButtonTitle,
    String? rightButtonTitle,
    TextStyle? leftTitleStyle,
    TextStyle? rightTitleStyle,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    VoidCallback? clickOnLeftButton,
    VoidCallback? clickOnRightButton,
    String? imagePath,
    double? imageHeight,
    double? imageWidth,
    double? elevation,
    double? borderRadius,
    double? borderWidth,
    Color? borderColor,
    Color? backgroundColor,
    MainAxisAlignment? actionsAlignment,
    AlignmentGeometry? dialogAlignment,
    bool isDismiss = true,
    bool isAssetImage = true,
    bool centerTitle = false,
    bool centerContent = false,
    bool isBackOn = true,
    EdgeInsetsGeometry? iconPadding,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? actionsPadding,
    EdgeInsets? insetPadding,
  }) async {
    await showDialog(
      context: Get.context!,
      builder: builder ?? (context) {
            return WillPopScope(
              onWillPop: () async {
                return isBackOn;
              },
              child: AlertDialog(
                insetPadding: insetPadding ?? EdgeInsets.zero,
                iconPadding: iconPadding ?? EdgeInsets.only(top: C.margin + C.margin, left: C.margin, right: C.margin),
                titlePadding: titlePadding ?? EdgeInsets.only(top: C.margin, left: C.margin, right: C.margin),
                contentPadding: contentPadding ?? EdgeInsets.only(top: C.margin - 6.px, left: C.margin, right: C.margin),
                actionsPadding: actionsPadding ?? EdgeInsets.only(top: C.margin / 2, left: C.margin, right: C.margin, bottom: C.margin / 2),
                backgroundColor: backgroundColor ?? Col.inverseSecondary,
                elevation: elevation ?? 0.px,
                alignment: dialogAlignment ?? Alignment.center,
                actionsAlignment: actionsAlignment ?? MainAxisAlignment.spaceBetween,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
                  side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 1.px),
                ),
                icon: imagePath != null
                    ? Container(
                        child: CW.commonNetworkImageView(
                            path: imagePath,
                            isAssetImage: isAssetImage,
                            height: imageHeight,
                            width: imageWidth),
                      )
                    : null,
                title: titleWidget
                    ?? Text(
                  title ?? '',
                  style: titleStyle ??
                      Theme.of(Get.context!).textTheme.displayLarge,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                ),
                content: content != null
                    ? Text(
                        content,
                        style: contentStyle ??
                            Theme.of(Get.context!).textTheme.labelMedium,
                        textAlign:
                            centerContent ? TextAlign.center : TextAlign.start,
                      )
                    : const SizedBox(),
                actions: [
                  Row(
                    children: [
                      if (leftButtonTitle != null)
                        Expanded(
                          child: CW.commonOutlineButton(
                            onPressed: clickOnLeftButton ?? () {},
                            height: 36.px,
                            borderRadius: 4.px,
                            borderWidth: 1.px,
                            borderColor: Col.darkGray,
                            child: Text(
                              leftButtonTitle,
                              style: leftTitleStyle ?? Theme.of(Get.context!).textTheme.labelLarge?.copyWith(color: Col.darkGray),
                            ),
                          ),
                        ),
                      if (rightButtonTitle != null)
                        SizedBox(width: 10.px),
                      if (rightButtonTitle != null)
                        Expanded(
                          child: CW.commonElevatedButton(
                            borderRadius: 4.px,
                            height: 36.px,
                            onPressed: clickOnRightButton ?? () {},
                            child: Text(
                              rightButtonTitle,
                              style: rightTitleStyle ?? Theme.of(Get.context!).textTheme.labelLarge,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.px),
                ],
              ),
            );
          },
      useSafeArea: true,
      barrierDismissible: isDismiss,
    );
  }

  static Future<void> commonAndroidLogoutDialog(
      {required VoidCallback clickOnCancel,
      required VoidCallback clickOnLogout,
      bool isDismiss = true}) async {
    await CD.commonAndroidAlertDialogBox(
        title: C.textLogOutDialogTitle,
        content: C.textLogOutDialogContent,
        clickOnLeftButton: clickOnCancel,
        clickOnRightButton: clickOnLogout,
        leftButtonTitle: C.textCancel,
        rightButtonTitle: C.textLogout,
        isDismiss: isDismiss);
  }

  static Future<void> commonAndroidExitAppDialog(
      {required VoidCallback clickOnCancel,
      required VoidCallback clickOnExit,
      bool isDismiss = true}) async {
    await CD.commonAndroidAlertDialogBox(
        title: C.textExitDialogTitle,
        content: C.textExitDialogContent,
        clickOnLeftButton: clickOnCancel,
        clickOnRightButton: clickOnExit,
        leftButtonTitle: C.textCancel,
        rightButtonTitle: C.textExit,
        isDismiss: isDismiss);
  }

  static Future<void> commonAndroidPermissionDialog(
      {required VoidCallback clickOnPermission,
      bool isDismiss = false,
      bool isBackOn = false}) async {
    await CD.commonAndroidAlertDialogBox(
        title: C.textPermission,
        content: C.textPermissionDialogContent,
        clickOnRightButton: clickOnPermission,
        rightButtonTitle: C.textGivePermission,
        isDismiss: isDismiss,
        isBackOn: isBackOn);
  }

  static Future<void> commonAndroidPickImageDialog(
      {required VoidCallback clickOnCamera,
      required VoidCallback clickOnGallery,
      bool isDismiss = true}) async {
    await CD.commonAndroidAlertDialogBox(
        title: C.textSelectImageTitle,
        content: C.textImageDialogContent,
        clickOnLeftButton: clickOnCamera,
        clickOnRightButton: clickOnGallery,
        leftButtonTitle: C.textCamera,
        rightButtonTitle: C.textGallery,
        isDismiss: isDismiss);
  }

  static  Future<void> commonAndroidNoInternetDialog({bool isDismiss = true}) async {
    await CD.commonAndroidAlertDialogBox(
      title: C.textWhoops,
      content: C.textNoInternetConnectionFound,
      imagePath: C.iNoInternetDialog,
      imageWidth: 200.px,
      iconPadding: EdgeInsets.only(left: C.margin + C.margin / 2),
      titlePadding: EdgeInsets.zero,
      centerTitle: true,
      centerContent: true,
      isDismiss: false,
      isBackOn: false,
    );
  }

  static  Future<void> commonAndroidFakeLocationDialog({bool isDismiss = true}) async {
    await CD.commonAndroidAlertDialogBox(
      // title: "Location",
      // content: 'Fake Location',
      imagePath: 'assets/images/fake_location_image.jpg',
      imageWidth: 200.px,
      actionsPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      // iconPadding: EdgeInsets.only(left: C.margin + C.margin / 2),
      titlePadding: EdgeInsets.zero,
      centerTitle: true,
      centerContent: true,
      isDismiss: false,
      isBackOn: false,
    );
  }

  ///  Calling Of Country Picker Dialog
  static Future<void> commonCountryPickerDialog({
    double? elevation,
    double? borderRadius,
    double? borderWidth,
    double? height,
    Color? borderColor,
    Color? backgroundColor,
    AlignmentGeometry? dialogAlignment,
    Widget? unScrollableWidget,
    TextEditingController? searchController,
    ValueChanged<String>? onChanged,
    bool isSearchEnable = true,
    required Widget child,
  }) async {
   await  CD.commonAndroidAlertDialogBox(
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
            side: BorderSide(
                width: borderWidth ?? 1.px,
                color: borderColor ?? Colors.transparent),
          ),
          alignment: dialogAlignment,
          elevation: elevation,
          backgroundColor: backgroundColor ?? Col.inverseSecondary,
          child: Padding(
            padding: EdgeInsets.all(C.margin),
            child: SizedBox(
                height: height ?? 500.px,
                child: Column(
                  children: [
                    if (unScrollableWidget != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: C.margin / 2),
                        child: unScrollableWidget,
                      )
                    else if (isSearchEnable)
                      Padding(
                        padding: EdgeInsets.only(bottom: C.margin / 2),
                        child: CW.commonTextField(
                          fillColor: Col.gray.withOpacity(0.3),
                          hintText: "Search Country",
                          controller: searchController,
                          hintStyle: Theme.of(Get.context!).textTheme.bodySmall,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Col.secondary,
                          ),
                          onChanged: onChanged,
                        ),
                      ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ListScrollBehavior(),
                        child: child,
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
