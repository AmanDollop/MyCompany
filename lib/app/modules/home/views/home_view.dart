import 'dart:math';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
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
      child: CW.commonScaffoldBackgroundColor(
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
              child: SafeArea(
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
                      // padding: EdgeInsets.symmetric(vertical: 0.px, horizontal: 0.px),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.px,bottom: 6.px, left: 12.px,right: 6.px),
                          child: CW.myAppBarView(
                            padding: EdgeInsets.zero,
                            title: 'Hello, ${controller.userData?.personalInfo?.userFullName != null && controller.userData!.personalInfo!.userFullName!.isNotEmpty ? controller.userData?.personalInfo?.userFullName : 'Employee Name'}',
                            onLeadingPressed: () {Scaffold.of(context).openDrawer();},
                            homeValue: true,
                            actionValue: true,
                            actionButtonImagePath: 'assets/icons/notification_icon.png',
                            onActionButtonPressed: () => controller.clickOnNotificationButton(),
                          ),
                        ),
                        SizedBox(height: 10.px),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.px),
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Col.gCardColor,
                            borderRadius: BorderRadius.circular(10.px),
                            border: Border.all(color: Col.primary, width: .3.px),
                          ),
                          child: punchInAndPunchOutView(),
                        ),
                        controller.apiResValue.value
                            ? Padding(
                                padding: EdgeInsets.only(top: 16.px),
                                child: menusListViewForShimmer(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.hideBanner.value)
                                    SizedBox(height: 16.px),
                                  if (controller.hideBanner.value) bannerView(),
                                  SizedBox(height: 16.px),
                                  appMenusListView(),
                                  if (AC.isConnect.value)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (controller.hideUpcomingCelebration.value)
                                          // SizedBox(height: 16.px),
                                          if (controller.hideUpcomingCelebration.value)
                                            upcomingCelebrationsButtonView(),
                                        if (controller.hideMyTeam.value)
                                          if (controller.myTeamMemberList != null && controller.myTeamMemberList!.isNotEmpty)
                                            SizedBox(height: 14.px),
                                        if (controller.hideMyTeam.value)
                                          if (controller.myTeamMemberList != null && controller.myTeamMemberList!.isNotEmpty)
                                            myTeamListView(),
                                        if (controller.hideMyReportingPerson.value)
                                          if (controller.myReportingTeamList != null && controller.myReportingTeamList!.isNotEmpty)
                                            SizedBox(height: 14.px),
                                        if (controller.hideMyReportingPerson.value)
                                          if (controller.myReportingTeamList != null && controller.myReportingTeamList!.isNotEmpty)
                                            reportingPersonListView(),
                                        if (controller.hideMyDepartment.value)
                                          if (controller.getDepartmentEmployeeList != null && controller.getDepartmentEmployeeList!.isNotEmpty)
                                            // SizedBox(height: 14.px),
                                            if (controller.hideMyDepartment.value)
                                              if (controller.getDepartmentEmployeeList != null && controller.getDepartmentEmployeeList!.isNotEmpty)
                                                yourDepartmentListView(),
                                        if (controller.hideGallery.value)
                                          Padding(
                                            padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 4.px),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                cardTextView(text: 'Gallery', fontSize: 16.px),
                                                viewAllTextButtonView(onPressedViewAllButton: () => controller.clickOnGalleryViewAllButton())
                                              ],
                                            ),
                                          ),
                                        if (controller.hideGallery.value)
                                          galleryListView(),
                                        SizedBox(height: 10.px),
                                      ],
                                    )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget punchInAndPunchOutView() {
    DateTime breakStartTime = controller.getTodayAttendanceDetail?.breakStartTime != null && controller.getTodayAttendanceDetail!.breakStartTime!.isNotEmpty
            ? DateFormat('HH:mm:ss').parse('${controller.getTodayAttendanceDetail?.breakStartTime}')
            : DateTime(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.breakValue.value)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
          child: SizedBox(
            width: double.infinity,
            child: cardTextView(
                text: controller.currentTimeForBreakTimer.hour != 0
                    ? '${controller.getTodayAttendanceDetail?.breakTypeName} (${DateFormat('HH:mm:ss').format(controller.currentTimeForBreakTimer)})'
                    : '${controller.getTodayAttendanceDetail?.breakTypeName} (${DateFormat('mm:ss').format(controller.currentTimeForBreakTimer)})',
                maxLines: 2,
                fontSize: 12.px,
                fontWeight: FontWeight.w600,
                color: Col.inverseSecondary),
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
                      painter: MyClockPainter(currentTime: controller.currentTimeForTimer),
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
                      InkWell(
                        onTap: controller.checkInAndCheckOutButtonValue.value
                            ? () => null
                            : () => controller.clickOnSwitchButton(),
                        child: Container(
                          // height: 120.px,
                          // width: 120.px,
                          height: 104.px,
                          width: 104.px,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.8],
                                tileMode: TileMode.decal,
                                colors: [
                                  Col.primary,
                                  Col.primaryColor,
                                ],
                              ),
                              shape: BoxShape.circle),
                          // child: circularProgressIndicatorTextView(),
                          child: Center(
                            child: CW.commonNetworkImageView(
                                path: controller.checkInValue.value
                                    ? 'assets/images/finger_print_image.png'
                                    : 'assets/images/b_finger_print_image.png',
                                isAssetImage: true,
                                width: 50.px,
                                height: 50.px),
                          ),
                        ),
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
                    // commonSwitchButtonView(),
                    circularProgressIndicatorTextView(),
                    SizedBox(height: 16.px),
                    controller.checkInValue.value && controller.checkOutValue.value
                        ? CW.myOutlinedButton(
                            onPressed: () {
                              CM.showSnackBar(message: 'You have already performed punch in and punch out this day.');
                            },
                            buttonText: 'Take a Break',
                            // width: 150.px,
                            height: 38.px,
                            // borderRadius: 20.px,
                            // buttonColor: Col.primary.withOpacity(.5),
                          )
                        : controller.breakValue.value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      cardTextView(
                                          text: 'Break time',
                                          color: Col.inverseSecondary),
                                      cardTextView(
                                          text: DateFormat('hh:mm:ss a').format(breakStartTime),
                                          fontSize: 12.px,
                                          color: Col.inverseSecondary),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => controller.clickOnBreakEndButton(),
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
                            : CW.myOutlinedButton(
                                onPressed: !controller.checkInValue.value
                                    ? () => null
                                    : () => controller.clickOnTakeBreakButton(),
                                buttonText: 'Take a Break',
                                // width: 150.px,
                                height: 38.px,
                                /*borderRadius: 20.px,
                                buttonColor: !controller.checkInValue.value
                                    ? Col.primary.withOpacity(.5)
                                    : Col.primary*/
                              ),
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
      strokeWidth: 6.px,
      value: value,
      backgroundColor: Col.primary.withOpacity(.2),
      color: Col.primary,
      strokeCap: StrokeCap.round,
    );
  }

  Widget circularProgressIndicatorTextView() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                controller.count;
                // print('::::test:::${formatWithLeadingZeros(controller.hours.value)}');
                return circularProgressIndicatorTimeTextView(
                  firstText: controller.checkInValue.value &&
                          controller.checkOutValue.value
                      ? '${formatWithLeadingZeros(controller.hours.value)}:${formatWithLeadingZeros(controller.minutes.value)}:${formatWithLeadingZeros(controller.seconds.value)}'
                      : formatTime(controller.currentTimeForTimer),
                );
              })
            ],
          ),
          SizedBox(height: 4.px),
          circularProgressIndicatorCheckInTextView(
            firstText: DateFormat('EEEE, MMM dd').format(controller.currentDateTime),
            fontSize: 10.px,
          ),
          SizedBox(height: 2.px),
          if (controller.checkInValue.value)
            circularProgressIndicatorCheckInTextView(
                firstText: 'Check In - (${DateFormat('hh:mm:ss a').format(DateTime.parse('2024-01-22 ${controller.getTodayAttendanceDetail?.punchInTime}'))})',
                fontSize: 8.px),
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

  Widget circularProgressIndicatorTimeTextView({required String firstText}) => Text(
        firstText,
        style: Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(fontSize: 18.px,color: Col.inverseSecondary),
      );

  Widget circularProgressIndicatorCheckInTextView({required String firstText, double? fontSize}) => Text(
        firstText,
        style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: Col.inverseSecondary,
            fontSize: fontSize),
      );

  Widget commonSwitchButtonView() {
    if (controller.checkInValue.value && controller.checkOutValue.value) {
      return GestureDetector(
        onHorizontalDragStart: (details) {
          CM.showSnackBar(
              message:
                  'You have already performed punch in and punch out this day.');
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
        onHorizontalDragStart: controller.checkInAndCheckOutButtonValue.value
            ? (details) => null
            : (details) => controller.clickOnSwitchButton(),
        onTap: controller.checkInAndCheckOutButtonValue.value
            ? () => null
            : () => controller.clickOnSwitchButton(),
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
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 14.px,
            color: color),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      );

  // Widget upcomingCelebrationsButtonView() => CW.commonElevatedButton(
  //       onPressed: () => controller.clickOnUpcomingCelebrationsButton(),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           cardTextView(
  //               text: 'Upcoming Celebrations', color: Col.inverseSecondary),
  //           cardTextView(text: 'View', color: Col.inverseSecondary),
  //         ],
  //       ),
  //     );

  void showOverlay({required BuildContext context, required String imagePath, required String userShortName}) {
    controller.overlayEntry = CW.showOverlay(
        context: context,
        imagePath: imagePath,
        userShortName: userShortName,
        height: 200.px,
        width: 200.px,
        borderRadius: 100.px);
  }

  Widget upcomingCelebrationsButtonView() {
    return commonCard(
      titleText: 'Upcoming Celebrations',
      viewAllButtonValue: true,
      onPressedViewAllButton: () => controller.clickOnUpcomingCelebrationsButton(),
      listWidget: controller.upcomingCelebrationList != null && controller.upcomingCelebrationList!.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.px,
                  mainAxisSpacing: 0.px,
                  childAspectRatio: .8),
              itemCount: controller.upcomingCelebrationList?.length,
              itemBuilder: (context, index) {
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                final cardWidth = (screenWidth - 30) / 2; // Adjust as needed
                final cardHeight = cardWidth * 0.8; // Adjust the aspect ratio as needed

                return Container(
                  width: cardWidth,
                  height: cardHeight,
                  // margin:  EdgeInsets.only(left: index % 2 == 0 ? 6.px : 2.px,right: index % 2 == 0 ? 2.px : 6.px),
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.px),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CW.commonNetworkImageView(
                          path: /*controller.upcomingCelebrationList?[index].celebrationType == 'Birthday'
                                       ? 'assets/images/birthday_background_image.png'
                                       : 'assets/images/work_anniversary_background_image.png'*/'assets/images/upcoming_celebrations.png',
                          isAssetImage: true,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          width: cardWidth,
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0),
                          margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(height: 6.px),
                              Container(
                                width: 50.px,
                                height: 50.px,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: Col.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25.px),
                                          child: CW.commonNetworkImageView(
                                            path: '${AU.baseUrlAllApisImage}${controller.upcomingCelebrationList?[index].userProfilePic}',
                                            isAssetImage: false,
                                            errorImage: 'assets/images/profile.png',
                                            userShortName: controller.upcomingCelebrationList?[index].shortName != null && controller.upcomingCelebrationList![index].shortName!.isNotEmpty
                                                ? '${controller.upcomingCelebrationList?[index].shortName}'
                                                : '?',
                                            errorImageValue: true,
                                            width: 50.px,
                                            height: 50.px,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 6.px),
                              cardTextView(
                                  text: controller.upcomingCelebrationList?[index].userFullName != null && controller.upcomingCelebrationList![index].userFullName!.isNotEmpty
                                      ? '${controller.upcomingCelebrationList?[index].userFullName}'
                                      : '?',
                                  fontWeight: FontWeight.w700,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  fontSize: 12.px,
                                   color: Col.inverseSecondary
                              ),
                              SizedBox(height: 2.px),
                              cardTextView(
                                  text: controller.upcomingCelebrationList?[index].userDesignation != null && controller.upcomingCelebrationList![index].userDesignation!.isNotEmpty
                                      ? '${controller.upcomingCelebrationList?[index].userDesignation}'
                                      : '?',
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1,
                                  fontSize: 8.px,
                                  textAlign: TextAlign.center,color: Col.inverseSecondary),
                              SizedBox(height: 2.px),
                              cardTextView(
                                  text: controller.upcomingCelebrationList?[index].branchName != null && controller.upcomingCelebrationList![index].branchName!.isNotEmpty
                                      ? '${controller.upcomingCelebrationList?[index].branchName} - ${controller.upcomingCelebrationList?[index].departmentName}'
                                      : '?',
                                  fontWeight: FontWeight.w500,
                                  maxLines: 2,
                                  fontSize: 8.px,
                                  textAlign: TextAlign.center,color: Col.inverseSecondary),
                              SizedBox(height: 2.px),
                              cardTextView(
                                  text: controller.upcomingCelebrationList?[index].celebrationYear != null && controller.upcomingCelebrationList![index].celebrationYear!.isNotEmpty
                                      ? '(${controller.upcomingCelebrationList?[index].celebrationYear})'
                                      : '?',
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  fontSize: 10.px,color: Col.inverseSecondary),
                              SizedBox(height: 2.px),
                              cardTextView(
                                  text: controller.upcomingCelebrationList?[index].celebrationDate != null && controller.upcomingCelebrationList![index].celebrationDate!.isNotEmpty
                                      ? '${controller.upcomingCelebrationList?[index].celebrationDate}'
                                      : '?',
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  fontSize: 10.px,color: Col.inverseSecondary),
                              SizedBox(height: 8.px),
                              CW.myElevatedButton(onPressed: () {},buttonText: 'Send wishes',height: 30.px,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : SizedBox(height: 0.px),
    );
  }

  Widget commonCard({required Widget listWidget, required String titleText, bool viewAllButtonValue = false, VoidCallback? onPressedViewAllButton}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 12.px,
                right: 12.px,
                top: viewAllButtonValue ? 6.px : 10.px),
            child: Row(
              mainAxisAlignment: viewAllButtonValue
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                cardTextView(
                    text: titleText,
                    fontSize: 16.px,
                    color: Col.inverseSecondary,
                    fontWeight: FontWeight.w600),
                if (viewAllButtonValue)
                  viewAllTextButtonView(
                      onPressedViewAllButton: onPressedViewAllButton ?? () {})
              ],
            ),
          ),
          listWidget
        ],
      );

  Widget viewAllTextButtonView({required VoidCallback onPressedViewAllButton}) =>
      CW.commonTextButton(
        onPressed: onPressedViewAllButton,
        child: Text(
          'View All',
          style: Theme.of(Get.context!)
              .textTheme
              .labelSmall
              ?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget appMenusListView() {
    return Obx(() {
      controller.count.value;
      if (controller.menusModal.value != null) {
        if (controller.isHeadingMenuList.isNotEmpty) {
          return commonCard(
            titleText: 'App Menu',
            listWidget: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.px),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.isHeadingMenuList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.px,
                mainAxisSpacing: 10.px,
              ),
              itemBuilder: (context, index) {
                Color convertedColor = CW.apiColorConverterMethod(colorString: '${controller.isHeadingMenuList[index].backgroundColor}');
                return InkWell(
                  onTap: () => controller.clickOnHeadingCards(headingCardIndex: index),
                  borderRadius: BorderRadius.circular(10.px),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
                    decoration: BoxDecoration(
                      color: Col.gCardColor,
                      borderRadius: BorderRadius.circular(6.px),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: controller.isHeadingMenuList[index].menuImage == null && controller.isHeadingMenuList[index].menuImage!.isEmpty
                                  ? CW.commonNetworkImageView(
                                      path: 'assets/images/default_image.jpg',
                                      isAssetImage: true,
                                      width: 26.px,
                                      height: 26.px,
                                    )
                                  : SizedBox(
                                      width: 26.px,
                                      height: 26.px,
                                      child: CW.commonCachedNetworkImageView(
                                        path:
                                            '${AU.baseUrlForSearchCompanyImage}${controller.isHeadingMenuList[index].menuImage}',
                                        imageColor: Col.primary,
                                      ),
                                    ),
                        ),
                        SizedBox(height: 5.px),
                        Flexible(
                          child: Text(
                            '${controller.isHeadingMenuList[index].menuName}',
                            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 10.px, color: Col.inverseSecondary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return controller.apiResValue.value
              ? const SizedBox()
              : CW.commonNoDataFoundText(text: 'Menus not found!');
        }
      } else {
        return controller.apiResValue.value
            ? const SizedBox()
            : CW.commonNoDataFoundText(text: 'Menus not found!');
      }
    });
  }

  Widget yourDepartmentListView() {
    return commonCard(
      titleText: 'Your Department',
      viewAllButtonValue: true,
      onPressedViewAllButton: () =>
          controller.clickOnYourDepartmentViewAllButton(),
      listWidget: GridView.builder(
        padding: EdgeInsets.only(right: 10.px, bottom: 10.px, left: 10.px),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.px,
          mainAxisSpacing: 10.px,
        ),
        physics: const ScrollPhysics(),
        itemCount: controller.getDepartmentEmployeeList!.length >= 3
            ? 3
            : controller.getDepartmentEmployeeList?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.clickOnYourDepartmentCards(
                yourDepartmentCardIndex: index),
            onLongPress: () {
              // Show overlay entry
              showOverlay(
                context: context,
                userShortName: controller
                                .getDepartmentEmployeeList?[index].shortName !=
                            null &&
                        controller.getDepartmentEmployeeList![index].shortName!
                            .isNotEmpty
                    ? '${controller.getDepartmentEmployeeList?[index].shortName}'
                    : '?',
                imagePath:
                    '${AU.baseUrlAllApisImage}${controller.getDepartmentEmployeeList?[index].userProfilePic}',
              );
            },
            onLongPressCancel: () {
              controller.overlayEntry.remove();
            },
            onLongPressEnd: (details) {
              controller.overlayEntry.remove();
            },
            child: Container(
              height: 106.px,
              width: 100.px,
              padding: EdgeInsets.only(left: 3.px),
              decoration: BoxDecoration(
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 6.px),
                  Container(
                    width: 40.px,
                    height: 40.px,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Col.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(27.px),
                        child: CW.commonNetworkImageView(
                            path:
                                '${AU.baseUrlAllApisImage}${controller.getDepartmentEmployeeList?[index].userProfilePic}',
                            isAssetImage: false,
                            errorImage: 'assets/images/profile.png',
                            width: 40.px,
                            height: 40.px,
                            errorImageValue: true,
                            userShortName: controller
                                            .getDepartmentEmployeeList?[index]
                                            .shortName !=
                                        null &&
                                    controller.getDepartmentEmployeeList![index]
                                        .shortName!.isNotEmpty
                                ? '${controller.getDepartmentEmployeeList?[index].shortName}'
                                : '?'),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.px),
                  cardTextView(
                      text: controller.getDepartmentEmployeeList?[index]
                                      .userFullName !=
                                  null &&
                              controller.getDepartmentEmployeeList![index]
                                  .userFullName!.isNotEmpty
                          ? '${controller.getDepartmentEmployeeList?[index].userFullName}'
                          : '?',
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                      fontSize: 12.px,
                      color: Col.inverseSecondary,
                      textAlign: TextAlign.center),
                  cardTextView(
                      text: controller.getDepartmentEmployeeList?[index]
                                      .userDesignation !=
                                  null &&
                              controller.getDepartmentEmployeeList![index]
                                  .userDesignation!.isNotEmpty
                          ? '${controller.getDepartmentEmployeeList?[index].userDesignation}'
                          : '?',
                      maxLines: 2,
                      fontSize: 10.px,
                      color: Col.gray,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget myTeamListView() {
    return commonCard(
      titleText: 'My Team',
      listWidget: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.px),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.myTeamMemberList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
            childAspectRatio: 2.2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.clickOnMyTeamCards(myTeamCardIndex: index),
            onLongPress: () {
              // Show overlay entry
              showOverlay(
                context: context,
                userShortName:
                    controller.myTeamMemberList?[index].shortName != null &&
                            controller
                                .myTeamMemberList![index].shortName!.isNotEmpty
                        ? '${controller.myTeamMemberList?[index].shortName}'
                        : '?',
                imagePath:
                    '${AU.baseUrlAllApisImage}${controller.myTeamMemberList?[index].userProfilePic}',
              );
            },
            onLongPressCancel: () {
              controller.overlayEntry.remove();
            },
            onLongPressEnd: (details) {
              controller.overlayEntry.remove();
            },
            child: Ink(
              height: 132.px,
              padding: EdgeInsets.only(left: 10.px),
              decoration: BoxDecoration(
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 44.px,
                    height: 44.px,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Col.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22.px),
                        child: CW.commonNetworkImageView(
                          path: '${AU.baseUrlAllApisImage}${controller.myTeamMemberList?[index].userProfilePic}',
                          isAssetImage: false,
                          fit: BoxFit.fill,
                          width: 40.px,
                          height: 40.px,
                          userShortName: controller.myTeamMemberList?[index].shortName != null && controller.myTeamMemberList![index].shortName!.isNotEmpty
                              ? '${controller.myTeamMemberList?[index].shortName}'
                              : '?',
                          errorImageValue: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.px),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardTextView(
                            text: controller.myTeamMemberList?[index].userFullName != null && controller.myTeamMemberList![index].userFullName!.isNotEmpty
                                ? '${controller.myTeamMemberList?[index].userFullName}'
                                : '?',
                            maxLines: 2,
                            fontSize: 12.px,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,color: Col.inverseSecondary),
                        // SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.myTeamMemberList?[index].userDesignation != null && controller.myTeamMemberList![index].userDesignation!.isNotEmpty
                                ? '${controller.myTeamMemberList?[index].userDesignation}'
                                : '?',
                            maxLines: 2,
                            fontSize: 10.px,
                            color: Col.gray,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget reportingPersonListView() {
    return commonCard(
      titleText: 'Reporting Person',
      listWidget: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.px),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.myReportingTeamList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
            childAspectRatio: 2.2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.clickOnReportingPersonCard(
                reportingPersonIndex: index),
            onLongPress: () {
              // Show overlay entry
              showOverlay(
                context: context,
                userShortName:
                    controller.myReportingTeamList?[index].shortName != null && controller.myReportingTeamList![index].shortName!.isNotEmpty
                        ? '${controller.myReportingTeamList?[index].shortName}'
                        : '?',
                imagePath: '${AU.baseUrlAllApisImage}${controller.myReportingTeamList?[index].userProfilePic}',
              );
            },
            onLongPressCancel: () {
              controller.overlayEntry.remove();
            },
            onLongPressEnd: (details) {
              controller.overlayEntry.remove();
            },
            child: Ink(
              height: 132.px,
              padding: EdgeInsets.only(left: 10.px),
              decoration: BoxDecoration(
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 44.px,
                    height: 44.px,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Col.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22.px),
                        child: CW.commonNetworkImageView(
                          path: '${AU.baseUrlAllApisImage}${controller.myReportingTeamList?[index].userProfilePic}',
                          isAssetImage: false,
                          errorImage: 'assets/images/profile.png',
                          fit: BoxFit.fill,
                          width: 40.px,
                          height: 40.px,
                          userShortName: controller.myReportingTeamList?[index].shortName != null && controller.myReportingTeamList![index].shortName!.isNotEmpty
                              ? '${controller.myReportingTeamList?[index].shortName}'
                              : '?',
                          errorImageValue: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.px),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardTextView(
                            text: controller.myReportingTeamList?[index].userFullName != null && controller.myReportingTeamList![index].userFullName!.isNotEmpty
                                ? '${controller.myReportingTeamList?[index].userFullName}'
                                : '?',
                            maxLines: 2,
                            fontSize: 12.px,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            color: Col.inverseSecondary),
                        // SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.myReportingTeamList?[index].userDesignation != null && controller.myReportingTeamList![index].userDesignation!.isNotEmpty
                                ? '${controller.myReportingTeamList?[index].userDesignation}'
                                : '?',
                            maxLines: 2,
                            fontSize: 10.px,
                            color: Col.gray,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
    return Column(
      children: [
        commonCard(
          titleText: 'App Menu',
          listWidget: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return Container(
                  height: 100.px,
                  padding: EdgeInsets.symmetric(horizontal: 8.px),
                  decoration: BoxDecoration(
                      color: Col.gCardColor,
                      borderRadius: BorderRadius.circular(6.px)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.commonShimmerViewForImage(height: 36.px, width: 36.px),
                      SizedBox(height: 6.px),
                      CW.commonShimmerViewForImage(
                          height: 10.px, width: 80.px, radius: 2.px),
                    ],
                  ));
            },
          ),
        ),
        commonCard(
            titleText: 'Upcoming Celebration',
            listWidget: SizedBox(height: 4.px),
            viewAllButtonValue: true),
        commonCard(
          titleText: 'My Team',
          viewAllButtonValue: true,
          onPressedViewAllButton: () {},
          listWidget: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.px,
                mainAxisSpacing: 10.px,
                childAspectRatio: 2.4),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.clickOnReportingPersonCard(
                    reportingPersonIndex: index),
                borderRadius: BorderRadius.circular(8.px),
                child: Ink(
                  height: 132.px,
                  padding: EdgeInsets.only(left: 10.px),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24.px,
                        color: Col.secondary.withOpacity(.05),
                      )
                    ],
                    color: Col.gCardColor,
                    borderRadius: BorderRadius.circular(8.px),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CW.commonShimmerViewForImage(
                          height: 44.px, width: 44.px, radius: 22.px),
                      SizedBox(width: 6.px),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CW.commonShimmerViewForImage(
                                height: 10.px, width: 80.px, radius: 2.px),
                            SizedBox(height: 2.px),
                            CW.commonShimmerViewForImage(
                                height: 10.px, width: 60.px, radius: 2.px),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

/*class MyClockPainter extends CustomPainter {
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

    Paint minutesTicksPaint = Paint()..color = Col.gray..strokeWidth = 1.6;
    Paint minutesTicksPaint1 = Paint()..color = Col.primary..strokeWidth = 1.6;

    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);

    for (var i = 0; i < totalNumberOfTicks; i++) {
      if (i == currentTime.second) {
        if (selectedBottomNavigationIndex.value == 0) {
          canvas.drawColor(Col.primary, BlendMode.softLight);
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
}*/

class MyClockPainter extends CustomPainter {
  final DateTime currentTime;
  final int totalNumberOfTicks;

  const MyClockPainter({
    required this.currentTime,
    this.totalNumberOfTicks = 60,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final radius = height / 2;
    final centerOffset = Offset(size.width / 2, height / 2);
    final rotatedAngle = 2 * pi / totalNumberOfTicks;

    Paint minutesTicksPaint = Paint()
      ..color = Col.primary
      ..strokeWidth = 1.6.px;
    Paint currentSecondTickPaint = Paint()
      ..color = Col.primary
      ..strokeWidth = 1.6.px; // Color for current second tick
    Paint belowCurrentSecondTickPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.6; // Color for ticks below current second

    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);

    for (var i = 0; i < totalNumberOfTicks; i++) {
      if (i == currentTime.second) {
        if (i == 0) {
          canvas.drawCircle(Offset(0, -radius + 20), 2,
              currentSecondTickPaint); // Draw filled circle for the first tick
        } else {
          canvas.drawLine(
            Offset(0, -radius + 16),
            Offset(0, -radius + 23),
            currentSecondTickPaint,
          ); // Draw filled arc for other ticks
        }
      } else if (i > currentTime.second) {
        // Ticks below current second
        canvas.drawLine(
          Offset(0, -radius + 16),
          Offset(0, -radius + 23),
          belowCurrentSecondTickPaint,
        );
      } else {
        // Ticks above current second
        canvas.drawLine(
          Offset(0, -radius + 16),
          Offset(0, -radius + 23),
          minutesTicksPaint,
        );
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
