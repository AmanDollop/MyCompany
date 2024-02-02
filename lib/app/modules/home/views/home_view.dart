import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/shimmer/shimmer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(
        backgroundColor: Col.inverseSecondary,
        body: Obx(() {
          controller.count.value;
          return NotificationListener(
            onNotification: (scrollNotification) {
              /* if (scrollNotification is ScrollEndNotification) {
                 scrollPositionBottomNavigationValue.value = controller.scrollController.value.position.pixels;
                   controller.count.value++;
              }*/
              return false;
            },
            child: CW.commonRefreshIndicator(
              onRefresh: () async {
                controller.apiResValue.value = true;
                controller.isHeadingMenuList.clear();
                await controller.onInit();
              },
              child: ModalProgress(
                inAsyncCall: controller.apiResValue.value,
                child: ListView(
                  controller: controller.scrollController.value,
                  padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 0.px),
                  children: [
                    punchInAndPunchOutView(),
                    controller.apiResValue.value
                        ? menusListViewForShimmer()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.hideBanner.value) SizedBox(
                            height: 16.px),
                        if (controller.hideBanner.value) bannerView(),
                        if (controller.hideUpcomingCelebration.value)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.px, vertical: 14.px),
                            child: upcomingCelebrationsButtonView(),
                          ),
                        appMenusListView(),
                        if (controller.hideMyTeam.value) SizedBox(
                            height: 14.px),
                        if (controller.hideMyTeam.value) myTeamListView(),
                        if (controller.hideMyDepartment.value)
                          SizedBox(height: 14.px),
                        if (controller.hideMyDepartment.value)
                          yourDepartmentListView(),
                        if (controller.hideGallery.value)
                          Padding(
                            padding: EdgeInsets.only(
                                left: 12.px, right: 12.px, bottom: 4.px),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardTextView(text: 'Gallery', fontSize: 16.px),
                                viewAllTextButtonView(
                                    onPressedViewAllButton: () =>
                                        controller
                                            .clickOnGalleryViewAllButton())
                              ],
                            ),
                          ),
                        if (controller.hideGallery.value) galleryListView(),
                        SizedBox(height: 10.px),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget punchInAndPunchOutView() {
    DateTime breakStartTime = controller.getTodayAttendanceDetail
        ?.breakStartTime != null &&
        controller.getTodayAttendanceDetail!.breakStartTime!.isNotEmpty
        ? DateFormat('HH:mm:ss').parse(
        '${controller.getTodayAttendanceDetail?.breakStartTime}')
        : DateTime(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.breakValue.value)
          Padding(
            padding: EdgeInsets.only(right: 12.px, left: 12.px),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.px)),
              color: Col.primary.withOpacity(.1),
              child: Padding(
                padding: EdgeInsets.all(4.px),
                child: SizedBox(
                  width: double.infinity,
                  child: cardTextView(
                      text: controller.currentTimeForBreakTimer.hour != 0
                          ? '${controller.getTodayAttendanceDetail
                          ?.breakTypeName} (${DateFormat('HH:mm:ss').format(
                          controller.currentTimeForBreakTimer)})'
                          : '${controller.getTodayAttendanceDetail
                          ?.breakTypeName} (${DateFormat('mm:ss').format(
                          controller.currentTimeForBreakTimer)})',
                      maxLines: 2,
                      fontSize: 12.px,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 180.px,
                    width: 180.px,
                    child: CustomPaint(
                      painter: MyClockPainter(
                          currentTime: controller.currentTimeForTimer),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 120.px,
                        width: 120.px,
                        child: circularProgressIndicatorView(),
                      ),
                      Container(
                        height: 110.px,
                        width: 110.px,
                        decoration: BoxDecoration(
                            color: Col.inverseSecondary,
                            shape: BoxShape.circle),
                        child: circularProgressIndicatorTextView(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12.px),
                child: Column(
                  children: [
                    commonSwitchButtonView(),
                    SizedBox(height: 14.px),
                    controller.checkInValue.value &&
                        controller.checkOutValue.value
                        ? CW.commonElevatedButton(
                      onPressed: () {
                        CM.showSnackBar(
                            message: 'You have already performed punch in and punch out this day.');
                      },
                      buttonText: 'Take a Break',
                      // width: 150.px,
                      height: 38.px,
                      borderRadius: 20.px,
                      buttonColor: Col.primary.withOpacity(.5),
                    )
                        : controller.breakValue.value
                        ? Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            cardTextView(text: 'Break time'),
                            cardTextView(
                                text: DateFormat('hh:mm:ss a')
                                    .format(breakStartTime),
                                fontSize: 12.px),
                          ],
                        ),
                        InkWell(
                          onTap: () =>
                              controller.clickOnBreakEndButton(),
                          borderRadius: BorderRadius.circular(4.px),
                          child: Column(
                            children: [
                              Container(
                                height: 24.px,
                                width: 24.px,
                                decoration: BoxDecoration(
                                    color: Col.primary,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.play_arrow,
                                    color: Col.inverseSecondary,
                                    size: 16.px),
                              ),
                              cardTextView(
                                  text: 'End', color: Col.primary),
                            ],
                          ),
                        ),
                      ],
                    )
                        : CW.commonElevatedButton(
                        onPressed: !controller.checkInValue.value
                            ? () => null
                            : () => controller.clickOnTakeBreakButton(),
                        buttonText: 'Take a Break',
                        // width: 150.px,
                        height: 38.px,
                        borderRadius: 20.px,
                        buttonColor: !controller.checkInValue.value
                            ? Col.primary.withOpacity(.5)
                            : Col.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget circularProgressIndicatorView() {
    if (controller.linerValue.value.isNaN) {
      return commonCircularProgressBar(value: 0.0);
    } else {
      return commonCircularProgressBar(value: controller.linerValue.value);
    }
  }

  Widget commonCircularProgressBar({required double value}) {
    return CircularProgressIndicator(
      strokeWidth: 8.px,
      value: value,
      backgroundColor: Col.primary.withOpacity(.2),
      strokeCap: StrokeCap.round,
    );
  }

  Widget circularProgressIndicatorTextView() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circularProgressIndicatorCheckInTextView(
              firstText: 'Check In', fontSize: 8.px),
          if (controller.checkInValue.value)
            circularProgressIndicatorCheckInTextView(
                firstText: '(${DateFormat('hh:mm:ss a').format(DateTime.parse(
                    '2024-01-22 ${controller.getTodayAttendanceDetail
                        ?.punchInTime}'))})', fontSize: 8.px),
          SizedBox(height: 2.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                controller.count;
                return circularProgressIndicatorTimeTextView(
                  firstText: controller.checkInValue.value &&
                      controller.checkOutValue.value
                      ? '${formatWithLeadingZeros(
                      controller.hours.value)}:${formatWithLeadingZeros(
                      controller.minutes.value)}:${formatWithLeadingZeros(
                      controller.seconds.value)}'
                      : formatTime(controller.currentTimeForTimer),
                );
              })
            ],
          ),
          SizedBox(height: 4.px),
          circularProgressIndicatorCheckInTextView(
              firstText: DateFormat('EE, MMM dd').format(
                  controller.currentDateTime), fontSize: 10.px),
        ],
      );

  String formatWithLeadingZeros(int value) {
    // Use padLeft to add leading zeros
    return value.toString().padLeft(2, '0');
  }

  String formatTime(DateTime dateTime) {
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }

  Widget circularProgressIndicatorTimeTextView({required String firstText}) =>
      Text(
        firstText,
        style: Theme
            .of(Get.context!)
            .textTheme
            .headlineLarge
            ?.copyWith(fontSize: 18.px),
      );

  Widget circularProgressIndicatorCheckInTextView({required String firstText, double? fontSize}) =>
      Text(
        firstText,
        style: Theme
            .of(Get.context!)
            .textTheme
            .labelLarge
            ?.copyWith(
            fontWeight: FontWeight.w500,
            color: Col.primary,
            fontSize: fontSize),
      );

  Widget commonSwitchButtonView() {
    if (controller.checkInValue.value && controller.checkOutValue.value) {
      return GestureDetector(
        onHorizontalDragStart: (details) {
          CM.showSnackBar(
              message: 'You have already performed punch in and punch out this day.');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          // width: 150.px,
          height: 40.px,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.px),
            color: Col.primary.withOpacity(.5),
          ),
          child: AnimatedContainer(
            width: 90.px,
            height: 32.px,
            margin: EdgeInsets.all(4.px),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.px),
                color: Col.inverseSecondary),
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 6.px),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: cardTextView(
                        text: 'Check In',
                        fontSize: 10.px,
                        color: Col.primary.withOpacity(.5)),
                  ),
                  SizedBox(width: 6.px),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: Col.primary.withOpacity(.5),
                    size: 18.px,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onHorizontalDragStart: (details) {
          controller.clickOnSwitchButton();
        },
        onTap: () => controller.clickOnSwitchButton(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          // width: 150.px,
          height: 40.px,
          alignment: controller.checkInValue.value
              ? Alignment.centerRight
              : Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.px),
            color: Col.primary,
          ),
          child: AnimatedContainer(
            width: 90.px,
            height: 32.px,
            margin: EdgeInsets.all(4.px),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.px),
                color: Col.inverseSecondary),
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 6.px),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (controller.checkInValue.value)
                    Icon(
                      Icons.keyboard_double_arrow_left_rounded,
                      color: Col.primary,
                      size: 18.px,
                    ),
                  Flexible(
                    child: cardTextView(
                        text: !controller.checkInValue.value
                            ? 'Check In'
                            : 'Check Out',
                        fontSize: 10.px,
                        color: Col.primary),
                  ),
                  SizedBox(width: 6.px),
                  if (!controller.checkInValue.value)
                    Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Col.primary,
                      size: 18.px,
                    )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget bannerView() => CW.commonBannerView(
        imageList: controller.bannerList,
        selectedIndex: controller.bannerIndex.value,
        onPageChanged: (index, reason) {
          controller.bannerIndex.value = index;
          // print('index::::$index');
          // print('controller.bannerIndex.value::::${controller.bannerIndex.value}');
          controller.count.value++;
        },
        indicatorHeight: 4.px,
        indicatorWidth: 12.px,
      );

  Widget cardTextView({required String text, double? fontSize, Color? color, int? maxLines, FontWeight? fontWeight, TextAlign? textAlign}) => Text(
        text,
        style: Theme
            .of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 14.px,
            color: color),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      );

  Widget upcomingCelebrationsButtonView() => CW.commonElevatedButton(
        onPressed: () => controller.clickOnUpcomingCelebrationsButton(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardTextView(
                text: 'Upcoming Celebrations', color: Col.inverseSecondary),
            cardTextView(text: 'View', color: Col.inverseSecondary),
          ],
        ),
      );

  Widget commonCard({required Widget listWidget, required String titleText, bool viewAllButtonValue = false, VoidCallback? onPressedViewAllButton}) =>
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0.px),
        color: Col.inverseSecondary,
        shadowColor: Col.secondary.withOpacity(.1),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Col.gray.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 12.px,
                  right: 12.px,
                  top: viewAllButtonValue ? 8.px : 10.px),
              child: Row(
                mainAxisAlignment: viewAllButtonValue
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  cardTextView(text: titleText, fontSize: 16.px),
                  if (viewAllButtonValue)
                    viewAllTextButtonView(
                        onPressedViewAllButton: onPressedViewAllButton ?? () {})
                ],
              ),
            ),
            listWidget
          ],
        ),
      );

  Widget viewAllTextButtonView({required VoidCallback onPressedViewAllButton}) => CW.commonTextButton(
        onPressed: onPressedViewAllButton,
        child: Text(
          'View All',
          style: Theme
              .of(Get.context!)
              .textTheme
              .titleLarge
              ?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget appMenusListView() {
    if (controller.isHeadingMenuList.isNotEmpty) {
      return commonCard(
        titleText: 'App Menu',
        listWidget: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.px),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.isHeadingMenuList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
          ),
          itemBuilder: (context, index) {
            Color convertedColor = stringToColor(
                colorString:
                '${controller.isHeadingMenuList[index].backgroundColor}');
            return InkWell(
              onTap: () =>
                  controller.clickOnHeadingCards(headingCardIndex: index),
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                height: 100.px,
                padding: EdgeInsets.only(left: 3.px),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24.px,
                      color: Col.secondary.withOpacity(.05),
                    )
                  ],
                  color: convertedColor,
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Ink(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
                  decoration: BoxDecoration(
                    color: Col.inverseSecondary,
                    borderRadius: BorderRadius.circular(6.px),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.px,
                        height: 40.px,
                        padding: EdgeInsets.all(2.px),
                        decoration: BoxDecoration(
                          color: convertedColor,
                          borderRadius: BorderRadius.circular(6.px),
                        ),
                        child: Center(
                          child:
                          controller.isHeadingMenuList[index].menuImage ==
                              null &&
                              controller.isHeadingMenuList[index]
                                  .menuImage!.isEmpty
                              ? CW.commonNetworkImageView(
                            path: 'assets/images/default_image.jpg',
                            isAssetImage: true,
                            width: 44.px,
                            height: 44.px,
                          )
                              : CW.commonNetworkImageView(
                            isAssetImage: false,
                            path:
                            '${AU.baseUrlForSearchCompanyImage}${controller
                                .isHeadingMenuList[index].menuImage}',
                            width: 22.px,
                            height: 22.px,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Flexible(
                        child: Text(
                          '${controller.isHeadingMenuList[index].menuName}',
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 10.px),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return controller.apiResValue.value ?
      const SizedBox() : CW.commonNoDataFoundText(text: 'Menus not found!');
    }
  }

  Color stringToColor({required String colorString}) {
    // Remove the '#' from the color code
    String formattedColor =
    colorString.startsWith('#') ? colorString.substring(1) : colorString;

    // Parse the hexadecimal value and create a Color object
    return Color(int.parse('0xFF$formattedColor'));
  }

  Widget myTeamListView() =>
      commonCard(
        titleText: 'My Team',
        listWidget: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.px),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () =>
                  controller.clickOnMyTeamCards(myTeamCardIndex: index),
              borderRadius: BorderRadius.circular(8.px),
              child: Ink(
                height: 132.px,
                padding: EdgeInsets.only(left: 3.px),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24.px,
                      color: Col.secondary.withOpacity(.05),
                    )
                  ],
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 44.px,
                          height: 44.px,
                          decoration: BoxDecoration(
                              color: Col.inverseSecondary,
                              borderRadius: BorderRadius.circular(8.px)),
                          child: Center(
                            child: CW.commonNetworkImageView(
                              path: 'assets/images/profile.png',
                              isAssetImage: true,
                              fit: BoxFit.fill,
                              width: 40.px,
                              height: 40.px,
                            ),
                          ),
                        ),
                        Container(
                          width: 8.px,
                          height: 8.px,
                          decoration: BoxDecoration(
                            color: Col.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.px),
                    Flexible(
                      child: cardTextView(
                          text: 'Testing Dollop',
                          maxLines: 2,
                          fontSize: 10.px,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700),
                    ),
                    // SizedBox(height: 2.px),
                    Flexible(
                      child: cardTextView(
                          text: 'Testing',
                          maxLines: 2,
                          fontSize: 10.px,
                          color: Col.darkGray,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget yourDepartmentListView() =>
      commonCard(
        titleText: 'Your Department',
        viewAllButtonValue: true,
        onPressedViewAllButton: () =>
            controller.clickOnYourDepartmentViewAllButton(),
        listWidget: SizedBox(
          height: 120.px,
          child: Padding(
            padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 16.px),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.px),
                    child: InkWell(
                      onTap: () =>
                          controller.clickOnYourDepartmentCards(
                              yourDepartmentCardIndex: index),
                      borderRadius: BorderRadius.circular(8.px),
                      child: Ink(
                        height: 106.px,
                        width: 100.px,
                        padding: EdgeInsets.only(left: 3.px),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 24.px,
                              color: Col.secondary.withOpacity(.05),
                            )
                          ],
                          color: Col.inverseSecondary,
                          borderRadius: BorderRadius.circular(8.px),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(height: 6.px),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(27.px),
                              child: CW.commonNetworkImageView(
                                path: 'assets/images/profile.png',
                                isAssetImage: true,
                                width: 54.px,
                                height: 54.px,
                              ),
                            ),
                            SizedBox(height: 6.px),
                            Flexible(
                              child: cardTextView(
                                  text: 'Testing Dollop',
                                  fontWeight: FontWeight.w700,
                                  maxLines: 2,
                                  fontSize: 10.px,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                physics: const ScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal),
          ),
        ),
      );

  Widget galleryListView() => SizedBox(
        height: 180.px,
        child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.px),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8.px),
                  child: Ink(
                    height: 180.px,
                    width: 300.px,
                    padding: EdgeInsets.only(left: 3.px),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24.px,
                          color: Col.secondary.withOpacity(.05),
                        )
                      ],
                      color: Col.inverseSecondary,
                      borderRadius: BorderRadius.circular(8.px),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.px),
                      child: CW.commonNetworkImageView(
                        path: 'assets/images/gallery_list_image.png',
                        isAssetImage: true,
                        width: 300.px,
                        height: 180.px,
                      ),
                    ),
                  ),
                ),
              );
            },
            physics: const ScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal),
      );

  Widget menusListViewForShimmer() {
    return commonCard(
      titleText: 'App Menu',
      listWidget: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.px),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.px,
          mainAxisSpacing: 10.px,
        ),
        itemBuilder: (context, index) {
          return CW.commonShimmerViewForImage(height: 100.px);
        },
      ),
    );
  }

}

class MyClockPainter extends CustomPainter {
  final DateTime currentTime;

  const MyClockPainter({required this.currentTime});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    // final radius = (min(width, height) / 2) + 4;
    final radius = height / 2;
    final centerOffset = Offset(width / 2, height / 2);
    const totalNumberOfTicks = 60;

    const rotatedAngle = 2 * pi / totalNumberOfTicks;

    Paint minutesTicksPaint = Paint()
      ..color = Col.gray
      ..strokeWidth = 1.6;
    Paint minutesTicksPaint1 = Paint()
      ..color = Col.primary
      ..strokeWidth = 1.6;

    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);

    for (var i = 0; i < totalNumberOfTicks; i++) {
      if (i == currentTime.second) {
        if (selectedBottomNavigationIndex.value == 0) {
          canvas.drawColor(Col.primary1, BlendMode.softLight);
        }
        canvas.drawLine(Offset(0, -radius + 16), Offset(0, -radius + 23),
            minutesTicksPaint1);
      } else {
        canvas.drawLine(Offset(0, -radius + 16), Offset(0, -radius + 23),
            minutesTicksPaint);
      }
      canvas.rotate(rotatedAngle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(MyClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MyClockPainter oldDelegate) => true;
}
