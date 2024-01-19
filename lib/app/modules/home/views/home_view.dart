import 'dart:math';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
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
                    if (controller.hideBanner.value)
                      SizedBox(height: 16.px),
                    if (controller.hideBanner.value) bannerView(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.px, vertical: 14.px),
                      child: Column(
                        children: [
                          if (controller.hideUpcomingCelebration.value)
                            SizedBox(height: 14.px),
                          if (controller.hideUpcomingCelebration.value)
                            upcomingCelebrationsButtonView(),
                        ],
                      ),
                    ),
                    headingListView(),
                    if (controller.hideMyTeam.value) SizedBox(height: 14.px),
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
                                    controller.clickOnGalleryViewAllButton())
                          ],
                        ),
                      ),
                    if (controller.hideGallery.value) galleryListView(),
                    SizedBox(height: 10.px),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget punchInAndPunchOutView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: 198.px,
            height: 198.px,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 164.px,
                  width: 164.px,
                  decoration: const BoxDecoration(
                    // color: Col.primary.withOpacity(.1),
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        circularProgressIndicatorView(),
                        circularProgressIndicatorTextView(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 198.px,
                  width: 198.px,
                  child: CustomPaint(
                    painter: MyClockPainter(currentTime: controller.currentDateAndTime.value),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right: 12.px),
            child: Column(
              children: [
                commonSwitchButtonView(),
                SizedBox(height: 14.px),
                controller.breakValue.value
                    ? SizedBox(
                      width: 150.px,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardTextView(text: 'Break time',),
                                cardTextView(text: '10:15 am',fontSize: 12.px),
                              ],
                            ),
                            InkWell(
                              onTap: () => controller.clickOnBreakButton(),
                              borderRadius: BorderRadius.circular(4.px),
                              child: Column(
                                children: [
                                  Container(
                                    height: 24.px,
                                    width: 24.px,
                                    decoration: BoxDecoration(color: Col.primary, shape: BoxShape.circle),
                                    child: Icon(Icons.play_arrow, color: Col.inverseSecondary, size: 16.px),
                                  ),
                                  cardTextView(text: 'End', color: Col.primary),
                                ],
                              ),
                            ),
                          ],
                        ),
                    )
                    : CW.commonElevatedButton(
                        onPressed: controller.checkInOrCheckOutValue.value?() => null:() => controller.clickOnBreakButton(),
                        buttonText: 'Take a Break',
                        width: 150.px,
                        height: 38.px,
                        borderRadius: 20.px,
                        buttonColor: controller.checkInOrCheckOutValue.value?Col.primary.withOpacity(.5):Col.primary),
              ],
            ),
          ),
        ],
      ),
    ],
  );

  Widget circularProgressIndicatorView() => SizedBox(
        height: 130.px,
        width: 130.px,
        child: CircularProgressIndicator(
          strokeWidth: 12.px,
          value: .8,
          backgroundColor: Col.primary.withOpacity(.2),
          strokeCap: StrokeCap.round,
        ),
      );

  Widget circularProgressIndicatorTextView() => Container(
        height: 118.px,
        width: 118.px,
        decoration: BoxDecoration(
          color: Col.inverseSecondary,
         shape: BoxShape.circle
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circularProgressIndicatorCheckInTextView(firstText: 'Check In', fontSize: 8.px),
            circularProgressIndicatorCheckInTextView(firstText: '09:30 AM', fontSize: 10.px),
            SizedBox(height: 2.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                circularProgressIndicatorTimeTextView(firstText: '10'),
                circularProgressIndicatorTimeTextView(firstText: ':00:'),
                circularProgressIndicatorTimeTextView(firstText: '00'),
              ],
            ),
            SizedBox(height: 4.px),
            circularProgressIndicatorCheckInTextView(firstText: 'Thursday, Oct 13', fontSize: 10.px),
          ],
        ),
      );

  Widget circularProgressIndicatorTimeTextView({required String firstText}) =>
      Text(
        firstText,
        style: Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(fontSize: 18.px),
      );

  Widget circularProgressIndicatorCheckInTextView({required String firstText, double? fontSize}) =>
      Text(
        firstText,
        style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: Col.primary,
            fontSize: fontSize),
      );

  Widget commonSwitchButtonView() => GestureDetector(
        onHorizontalDragStart: (details) {
          controller.clickOnSwitchButton();
        },
        onTap: () => controller.clickOnSwitchButton(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 150.px,
          height: 40.px,
          alignment: controller.checkInOrCheckOutValue.value
              ? Alignment.centerLeft
              : Alignment.centerRight,
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
                  if (!controller.checkInOrCheckOutValue.value)
                    Icon(
                      Icons.keyboard_double_arrow_left_rounded,
                      color: Col.primary,
                      size: 18.px,
                    ),
                  Flexible(
                    child: cardTextView(
                        text: controller.checkInOrCheckOutValue.value
                            ? 'Check In'
                            : 'Check Out',
                        fontSize: 10.px,
                        color: Col.primary),
                  ),
                  SizedBox(width: 6.px),
                  if (controller.checkInOrCheckOutValue.value)
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

  Widget commonContainerForLargeMenus({required String imagePath, required String titleText, required GestureTapCallback onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.px),
        child: Container(
          // width: 164.px,
          // height: 62.px,
          padding: EdgeInsets.symmetric(horizontal: 8.px),
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            boxShadow: [
              BoxShadow(
                blurRadius: 24.px,
                color: Col.secondary.withOpacity(.1),
              )
            ],
            border: Border.all(color: Col.gray.withOpacity(.8), width: 1.px),
            borderRadius: BorderRadius.circular(12.px),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: CW.commonNetworkImageView(
                    path: imagePath,
                    isAssetImage: false,
                    width: 36.px,
                    height: 36.px),
              ),
              SizedBox(width: 6.px),
              Flexible(
                child: cardTextView(text: titleText, maxLines: 2),
              ),
              SizedBox(width: 12.px),
            ],
          ),
        ),
      );

  Widget viewAllTextButtonView({required VoidCallback onPressedViewAllButton}) =>
      CW.commonTextButton(
        onPressed: onPressedViewAllButton,
        child: Text(
          'View All',
          style: Theme.of(Get.context!)
              .textTheme
              .titleLarge
              ?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget headingListView() {
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
                          child: CW.commonCachedNetworkImageView(
                            path: '${AU.baseUrlForSearchCompanyImage}${controller.isHeadingMenuList[index].menuImage}',
                            width: 22.px,
                            height: 22.px,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Flexible(
                        child: Text(
                          '${controller.isHeadingMenuList[index].menuName}',
                          style: Theme.of(Get.context!)
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
      return CW.commonNoDataFoundText(text: controller.apiResValue.value ? '' : 'Menus not found!');
    }
  }

  Color stringToColor({required String colorString}) {
    // Remove the '#' from the color code
    String formattedColor =
        colorString.startsWith('#') ? colorString.substring(1) : colorString;

    // Parse the hexadecimal value and create a Color object
    return Color(int.parse('0xFF$formattedColor'));
  }

  Widget myTeamListView() => commonCard(
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

  Widget yourDepartmentListView() => commonCard(
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
                      onTap: () => controller.clickOnYourDepartmentCards(
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
}

class MyClockPainter extends CustomPainter {
  final DateTime currentTime;
  const MyClockPainter({required this.currentTime});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width-2;
    final height = size.height-2;
    final radius = min(width, height) / 2;
    final centerOffset = Offset(width / 2, height / 2);
    const totalNumberOfTicks = 60;

    const rotatedAngle = 2 * pi / totalNumberOfTicks;

    Paint minutesTicksPaint = Paint()..color = Col.gray ..strokeWidth = 2;


    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);

    for (var i = 0; i < totalNumberOfTicks; i++) {

      if(i==currentTime.second) {
        Path linePath = Path();
          linePath.moveTo(0, -radius * 0.95);
          linePath.lineTo(-radius * 0.013, -radius * 0.9);
          linePath.lineTo(-radius * 0.01, 0);
          linePath.lineTo(radius * 0.01, 0);
          linePath.lineTo(radius * 0.013, -radius * 0.9);
          linePath.lineTo(0, -radius * 0.95);
        canvas.drawColor(Col.primary,BlendMode.color);
      }else{
        canvas.drawLine(Offset(0, -radius + 18), Offset(0, -radius + 25), minutesTicksPaint);
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