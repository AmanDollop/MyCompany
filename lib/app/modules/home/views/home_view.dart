import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(
        // appBar: CW.commonAppBarView(
        //     homeAppBarValue: true,
        //     title: 'Hello, Dollop',
        //     leadingWidth: 60.px,
        //     isLeading: true,
        //     leading: Builder(
        //       builder: (context) => Center(
        //         child: SizedBox(
        //           height: 45.px,
        //           width: 45.px,
        //           child: Center(
        //             child: InkWell(
        //               onTap: () => controller.clickOnDrawerButton(context: context),
        //               borderRadius: BorderRadius.circular(14.px),
        //               child: Ink(
        //                 height: 46.px,
        //                 width: 46.px,
        //                 decoration: BoxDecoration(color: Col.inverseSecondary, borderRadius: BorderRadius.circular(14.px)),
        //                 child: Center(
        //                   child: CW.commonNetworkImageView(
        //                       path: 'assets/icons/drawer_menu_icon.png',
        //                       isAssetImage: true,
        //                       width: 24.px,
        //                       height: 24.px),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     onNotificationPressed: () => controller.clickOnNotificationButton()),
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
            child: ListView(
              controller: controller.scrollController.value,
              padding: EdgeInsets.symmetric(vertical: 16.px,horizontal: 0.px),
              children: [
                breakView(),
                commonSwitchButtonView(),
                SizedBox(height: 16.px),
                bannerView(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 14.px),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: commonCon(
                              imagePath: 'assets/icons/circulars_icon.png',
                              titleText: 'Circulars',
                              onTap: () => controller.clickOnCirculars(),
                            ),
                          ),
                          SizedBox(width: 12.px),
                          Expanded(
                            child: commonCon(
                              imagePath: 'assets/icons/circulars_icon.png',
                              titleText: 'Discussion',
                              onTap: () => controller.clickOnDiscussion(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 14.px),
                      upcomingCelebrationsButtonView(),
                    ],
                  ),
                ),
                headingListView(),
                SizedBox(height: 14.px),
                myTeamListView(),
                SizedBox(height: 14.px),
                yourDepartmentListView(),
                Padding(
                  padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 4.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardTextView(text: 'Gallery', fontSize: 18.px),
                      viewAllTextButtonView(onPressedViewAllButton: () => controller.clickOnGalleryViewAllButton())
                    ],
                  ),
                ),
                galleryListView(),
                SizedBox(height: 10.px),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget breakView() => AnimatedCrossFade(
        crossFadeState: controller.checkInOrCheckOutValue.value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
        firstChild: const SizedBox(),
        secondChild: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.px),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardTextView(text: 'Break time', fontSize: 16.px),
                      cardTextView(text: '10:15 am'),
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
                          decoration: BoxDecoration(
                              color: Col.primary, shape: BoxShape.circle),
                          child: Center(
                            child: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: controller.animationController,
                                color: Col.inverseSecondary,
                                size: 16.px),
                          ),
                        ),
                        cardTextView(
                            text: controller.breakValue.value
                                ? 'Proceed'
                                : 'Take a Break',
                            color: Col.primary),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.px),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200.px,
                      width: 200.px,
                      child: CircularProgressIndicator(
                        strokeWidth: 30.px,
                        value: .8,
                        backgroundColor: Col.gray.withOpacity(.2),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    SizedBox(
                      height: 150.px,
                      width: 150.px,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              commonTextForTimeView(firstText: '10', secondText: 'hours'),
                              commonTextForTimeView(firstText: ':00:', secondText: 'min'),
                              commonTextForTimeView(firstText: '00', secondText: 'sec'),
                            ],
                          ),
                          SizedBox(height: 5.px),
                          Text(
                            'Check In - 09:30am',
                            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            'Thursday, Oct 13',
                            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.px),
            ],
          ),
        ),
      );

  Widget commonSwitchButtonView() => Center(
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            controller.clickOnSwitchButton();
          },
          onTap: () => controller.clickOnSwitchButton(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 192.px,
            height: 54.px,
            alignment: controller.checkInOrCheckOutValue.value
                ? Alignment.centerLeft
                : Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27.px),
              color: Col.primary,
            ),
            child: AnimatedContainer(
              width: 124.px,
              height: 46.px,
              margin: EdgeInsets.all(4.px),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(23.px), color: Col.inverseSecondary),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 6.px),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!controller.checkInOrCheckOutValue.value)
                    Icon(
                        Icons.keyboard_double_arrow_left_rounded,
                        color: Col.primary,
                        size: 22.px,
                      ),
                    Flexible(
                      child: cardTextView(
                          text: controller.checkInOrCheckOutValue.value
                              ? 'Check In'
                              : 'Check Out',
                          color: Col.primary),
                    ),
                    SizedBox(width: 6.px),
                    if (controller.checkInOrCheckOutValue.value)
                    Icon(
                        Icons.keyboard_double_arrow_right_rounded,
                        color: Col.primary,
                        size: 22.px,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget commonTextForTimeView({required String firstText, required String secondText}) => Column(
        children: [
          Text(
            firstText,
            style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(
                  fontSize: 28.px,
                ),
          ),
          Text(secondText,
              style: Theme.of(Get.context!).textTheme.titleSmall,
              textAlign: TextAlign.end),
        ],
      );

  Widget bannerView() => CW.commonBannerView(
        imageList: [
          'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYRNamIIDEJN4sHp3UuQVpYfwhrsNUZEld0aTCqAs4qMG-X9Wb3IGmvN3CbeSnvDzl_4c&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6g3P5972LeN4_5J9Dua6oCYn3cBzjSUGys5dhj4qerMbHQY5-TRyMzrmuRe3m6SPz4WU&usqp=CAU'
        ],
        selectedIndex: controller.bannerIndex.value,
        onPageChanged: (index, reason) {
          controller.bannerIndex.value = index;
          controller.count.value++;
        },
        indicatorHeight: 8.px,
        indicatorWidth: 8.px,
      );

  Widget commonCon({required String imagePath, required String titleText, required GestureTapCallback onTap}) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.px),
        child: Container(
          width: 164.px,
          height: 62.px,
          padding: EdgeInsets.symmetric(horizontal: 8.px),
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            boxShadow: [
              BoxShadow(
                blurRadius: 24.px,
                color: Col.secondary.withOpacity(.1),
              )
            ],
            border: Border.all(color: Col.gray.withOpacity(.5), width: 1.5.px),
            borderRadius: BorderRadius.circular(14.px),
          ),
          child: Row(
            children: [
              Container(
                height: 42.px,
                width: 42.px,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Col.primary.withOpacity(.2),
                ),
                child: Center(
                  child: CW.commonNetworkImageView(
                      path: imagePath,
                      isAssetImage: true,
                      width: 24.px,
                      height: 24.px),
                ),
              ),
              SizedBox(width: 12.px),
              Flexible(child: cardTextView(text: titleText,maxLines: 2),)
            ],
          ),
        ),
      );

  Widget cardTextView({required String text, double? fontSize, Color? color, int? maxLines, TextAlign? textAlign}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
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

  Widget commonCard({required Widget listWidget, required String titleText, bool viewAllButtonValue = false, VoidCallback? onPressedViewAllButton}) => Card(
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
                  top: viewAllButtonValue ? 8.px : 16.px),
              child: Row(
                mainAxisAlignment: viewAllButtonValue
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  cardTextView(text: titleText, fontSize: 18.px),
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
          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget headingListView() => commonCard(
        titleText: 'Heading',
        listWidget: CW.commonGridView(
          externalPadding: EdgeInsets.only(top: C.margin, bottom: 0.px),
          length: controller.titleList.length,
          child: (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
            return SizedBox(
              width: cellWidth - 14.px,
              child: Padding(
                padding: EdgeInsets.only(
                    left: index % 2 == 0 ? C.margin : C.margin / 2,
                    right: index % 2 == 0 ? C.margin / 2 : C.margin ,
                    top: 0,
                    bottom: C.margin
                ),
                child: InkWell(
                  onTap: () => controller.clickOnHeadingCards(headingCardIndex: index),
                  borderRadius: BorderRadius.circular(10.px),
                  child: Ink(
                    height: 114.px,
                    padding: EdgeInsets.only(left: 3.px),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24.px,
                          color: Col.secondary.withOpacity(.05),
                        )
                      ],
                      color: controller.colorList[index],
                      borderRadius: BorderRadius.circular(8.px),
                    ),
                    child: Ink(
                      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
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
                            decoration: BoxDecoration(
                              color: controller.colorList[index],
                              borderRadius: BorderRadius.circular(6.px),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/shoping_light.png',
                                width: 24.px,
                                height: 24.px,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.px),
                          Flexible(
                            child: cardTextView(
                                text: controller.titleList[index], maxLines: 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          height: 114.px,
        ),
      );

  Widget myTeamListView() => commonCard(
        titleText: 'My Team',
        listWidget: CW.commonGridView(
          externalPadding: EdgeInsets.only(top: C.margin, bottom: 0.px),
          length: controller.titleList.length,
          child: (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
            return SizedBox(
              width: cellWidth - 14.px,
              child: Padding(
                padding: EdgeInsets.only(
                    left: index % 2 == 0 ? C.margin : C.margin / 2,
                    right: index % 2 == 0 ? C.margin / 2 : C.margin ,
                    top: 0,
                    bottom: C.margin),
                child: InkWell(
                  onTap: () => controller.clickOnMyTeamCards(myTeamCardIndex: index),
                  borderRadius: BorderRadius.circular(8.px),
                  child: Ink(
                    height: 126.px,
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
                              width: 54.px,
                              height: 54.px,
                              decoration: BoxDecoration(
                                  color: Col.inverseSecondary,
                                  borderRadius: BorderRadius.circular(8.px)),
                              child: Center(
                                  child: CW.commonNetworkImageView(
                                path: 'assets/images/profile.png',
                                isAssetImage: true,
                                fit: BoxFit.fill,
                                width: 50.px,
                                height: 50.px,
                              )),
                            ),
                            Container(
                              width: 10.px,
                              height: 10.px,
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
                              maxLines: 1,
                              fontSize: 14.px),
                        ),
                        SizedBox(height: 2.px),
                        Flexible(
                          child: cardTextView(
                              text: 'Testing',
                              maxLines: 1,
                              fontSize: 12.px,
                              color: Col.gray),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          height: 120.px,
        ),
      );

  Widget yourDepartmentListView() => commonCard(
        titleText: 'Your Department',
        viewAllButtonValue: true,
        onPressedViewAllButton: () =>
            controller.clickOnYourDepartmentViewAllButton(),
        listWidget: SizedBox(
          height: 140.px,
          child: Padding(
            padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 16.px),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.px),
                    child: InkWell(
                      onTap: () => controller.clickOnYourDepartmentCards(yourDepartmentCardIndex: index),
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
                          children: [
                            SizedBox(height: 6.px),
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
                                  maxLines: 2,
                                  fontSize: 14.px,
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
