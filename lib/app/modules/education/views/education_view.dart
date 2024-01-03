import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CW.commonOutlineButton(
                        onPressed: () => controller.clickOnAchievementsTab(),
                        buttonText: 'Achievement',
                        height: 40.px,
                        borderRadius: 20.px,
                        buttonTextColor:
                            controller.tabBarValue.value == 'Achievement'
                                ? Col.primary
                                : Col.secondary,
                        borderColor:
                            controller.tabBarValue.value == 'Achievement'
                                ? Col.primary
                                : Col.secondary,
                        borderWidth:
                            controller.tabBarValue.value == 'Achievement'
                                ? 1.5.px
                                : 1.px),
                  ),
                  SizedBox(width: 8.px),
                  Expanded(
                    child: CW.commonOutlineButton(
                        onPressed: () => controller.clickOnEducationTab(),
                        buttonText: 'Education',
                        height: 40.px,
                        borderRadius: 20.px,
                        buttonTextColor:
                            controller.tabBarValue.value == 'Education'
                                ? Col.primary
                                : Col.secondary,
                        borderColor: controller.tabBarValue.value == 'Education'
                            ? Col.primary
                            : Col.secondary,
                        borderWidth: controller.tabBarValue.value == 'Education'
                            ? 1.5.px
                            : 1.px),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.px),
                  child: AnimatedCrossFade(
                    crossFadeState:
                        controller.tabBarValue.value == 'Achievement'
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 1000),
                    firstCurve: Curves.fastOutSlowIn,
                    secondCurve: Curves.fastOutSlowIn,
                    firstChild: educationListView(),
                    secondChild: achievementsListView(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ///TODO Education View

  Widget educationListView() => ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.px),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                educationImageView(),
                SizedBox(width: 16.px),
                Flexible(
                  child: Stack(
                    children: [
                      backgroundCardViewForEducation(),
                      triangleCardViewForEducation(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget backgroundCardViewForEducation() => Container(
        padding: EdgeInsets.all(14.px),
        margin: EdgeInsets.only(left: 10.px),
        decoration: BoxDecoration(
          color: const Color(0xffF1F0FD),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4.px),
            bottomRight: Radius.circular(4.px),
            bottomLeft: Radius.circular(4.px),
            topLeft: Radius.circular(2.5.px),
          ),
          border: Border.all(
            color: const Color(0xffE9E3F4),
            width: 1.px,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            cardTitleTextView(
                text:
                    'Devi Ahilya Devi Ahilya Devi Ahilya  Devi Ahilya   Vishwavidyalaya'),
            SizedBox(height: 2.px),
            cardSubTitleTextView(text: 'BSC'),
            cardSubTitleTextView(text: '2019 - 2022'),
          ],
        ),
      );

  Widget triangleCardViewForEducation() => Positioned(
        top: 3.8.px, // Adjust positioning if needed
        left: 1.px, // Adjust positioning if needed
        child: Transform.rotate(
          angle: 45 * (pi / 180), // Convert degrees to radians
          child: ClipPath(
            clipper: TriangleClipperForEducation(),
            child: Container(
              width: 20.px,
              height: 20.px,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffE9E3F4),
                  width: 1.px,
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(2.px),
                    topRight: Radius.circular(2.px)),
                color: const Color(0xffF1F0FD),
              ),
            ),
          ),
        ),
      );

  Widget educationImageView() => Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
            // color:Color(0xffF1F0FD),
            shape: BoxShape.circle),
        child: Center(
            child: Image.asset('assets/images/education_image.png',
                height: 36.px, width: 36.px)),
      );

  ///TODO Achievements View

  Widget achievementsListView() =>  ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.px),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Stack(
                      children: [
                        backgroundCardViewForAchievements(index:index),
                        triangleCardViewForAchievements(),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.px),
                  achievementsImageView()
                ],
              ),
            );
          },
        );

  Widget backgroundCardViewForAchievements({required int index}) => Container(
        padding: EdgeInsets.all(14.px),
        margin: EdgeInsets.only(right: 10.px),
        decoration: BoxDecoration(
          color: const Color(0xffE9F9F0),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(2.5.px),
            bottomRight: Radius.circular(4.px),
            bottomLeft: Radius.circular(4.px),
            topLeft: Radius.circular(4.px),
          ),
          border: Border.all(
            color: const Color(0xffC1EDD5),
            width: 1.px,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            cardTitleTextView(
                text:
                    'Devi Ahilya Devi Ahilya Devi Ahilya  Devi Ahilya   Vishwavidyalaya'),
            SizedBox(height: 2.px),
            cardSubTitleTextView(text: 'BSC'),
            cardSubTitleTextView(text: '2019 - 2022'),
          ],
        ),
      );

  Widget triangleCardViewForAchievements() => Positioned(
        top: 3.8.px, // Adjust positioning if needed
        right: 1.px, // Adjust positioning if needed
        child: Transform.rotate(
          angle: 45 * (pi / 180), // Convert degrees to radians
          child: ClipPath(
            clipper: TriangleClipperForAchievements(),
            child: Container(
              width: 20.px,
              height: 20.px,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffC1EDD5),
                  width: 1.px,
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(2.px),
                    topRight: Radius.circular(2.px)),
                color: const Color(0xffE9F9F0),
              ),
            ),
          ),
        ),
      );

  Widget achievementsImageView() => Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
            color: Color(0xffE9F9F0), shape: BoxShape.circle),
        child: Center(
            child: Image.asset('assets/images/achievements_image.png',
                height: 18.px, width: 18.px)),
      );

  Widget cardTitleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      );

  Widget cardSubTitleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall,
      );
}

class TriangleClipperForAchievements extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width - 20.0, 0.0); // Adjust the length of the triangle
    path.lineTo(size.width, 20.0); // Adjust the height of the triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TriangleClipperForEducation extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 20.0);
    path.lineTo(size.width - 20.0, 0.0); // Adjust the length of the triangle
    path.lineTo(size.width - 20, 20.0); // Adjust the height of the triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
