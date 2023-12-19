import 'package:task/common/common_packages/scroll_behavior/scroll_behavior.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CBS {
  static Future<void> commonBottomSheet(
      {required List<Widget> children,
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
      Widget? unScrollWidget}) async {
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
                        children: children,
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
                CBS().commonView(onTap: clickOnTakePhoto ?? () {}, title: C.textTakePhoto),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(onTap: clickOnChooseFromLibrary ?? () {}, title: C.textChooseFromLibrary),
                CW.commonDividerView(
                  height: 0.px,
                  wight: .5.px,
                  color: Col.gray,
                  leftPadding: 10.px,
                  rightPadding: 10.px,
                ),
                CBS().commonView(onTap: clickOnRemovePhoto ?? () {}, title: C.textRemovePhoto),
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

  Widget commonView({required VoidCallback onTap, required String title}) =>
      InkWell(
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
