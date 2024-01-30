import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);

  /// 0 = Education
  /// 1 = Achievement

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        if(controller.educationOrAchievementsModal.value != null){
          return ModalProgress(inAsyncCall: controller.apiResponseValue.value, child: Padding(
            padding: EdgeInsets.all(12.px),
            child: Column(
              children: [
                tabBarView(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.px),
                    child: AnimatedCrossFade(
                      crossFadeState:
                      controller.tabBarValue.value == 'Education'
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 1000),
                      firstCurve: Curves.fastOutSlowIn,
                      secondCurve: Curves.fastOutSlowIn,
                      firstChild: educationListView(),
                      secondChild: achievementsListView(),
                    ),
                  ),
                ),
                SizedBox(height: 12.px)
              ],
            ),
          ),);
        }else{
          return CW.commonNoDataFoundText(text: controller.apiResponseValue.value?'':'Data not found!');
        }
      }),
      floatingActionButton: controller.accessType.value != '1' &&
          controller.isChangeable.value != '1'
          ? Padding(
        padding: EdgeInsets.only(bottom: 10.px),
        child: CW.commonOutlineButton(
            onPressed: () => controller.clickOnAddViewButton(),
            child: Icon(
              Icons.add,
              color: Col.inverseSecondary,
              size: 22.px,
            ),
            height: 50.px,
            width: 50.px,
            backgroundColor: Col.primary,
            borderColor: Colors.transparent,
            borderRadius: 25.px),
      )
          : const SizedBox(),
    );
  }

  Widget tabBarView() => AnimatedContainer(
    height: 44.px,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 6.px),
    decoration: BoxDecoration(color: Col.primary, borderRadius: BorderRadius.circular(6.px)
    ),
    duration: const Duration(milliseconds: 500),
    child:  Row(
      children: [
        Expanded(
          child: educationButtonView(),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: achievementButtonView(),
        ),
      ],
    ),
  );

  Widget achievementButtonView()=> CW.commonElevatedButton(
    onPressed: () => controller.clickOnAchievementsTab(),
    buttonText: 'Achievement',
    height: 36.px,
    borderRadius: 6.px,
    buttonColor: controller.tabBarValue.value == 'Achievement'
        ? Col.inverseSecondary
        : Col.primary,
    buttonTextColor: controller.tabBarValue.value == 'Achievement'
        ? Col.primary
        : Col.inverseSecondary,
  );

  Widget educationButtonView()=> CW.commonElevatedButton(
    onPressed: () => controller.clickOnEducationTab(),
    buttonText: 'Education',
    height: 36.px,
    borderRadius: 6.px,
    buttonColor: controller.tabBarValue.value == 'Education'
        ? Col.inverseSecondary
        : Col.primary,
    buttonTextColor: controller.tabBarValue.value == 'Education'
        ? Col.primary
        : Col.inverseSecondary,
  );

  ///TODO Education View

  Widget educationListView() => controller.getEducationList.isNotEmpty
      ? ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.getEducationList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.px),
            child: backgroundCardView(index: index),
          );
        },
      )
      : CW.commonNoDataFoundText(text: controller.apiResponseValue.value?'':'Education not found!');

  Widget backgroundCardView({required int index}) => InkWell(
        onTap: () => controller.clickOnEducationData(index:index),
        borderRadius: BorderRadius.circular(4.px),
        child: Container(
          padding: EdgeInsets.all(14.px),
          decoration: BoxDecoration(
            color: const Color(0xffF1F0FD),
            borderRadius: BorderRadius.circular(4.px),
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
                  text: controller.getEducationList[index].classAchievement != null && controller.getEducationList[index].classAchievement!.isNotEmpty
                      ? '${controller.getEducationList[index].classAchievement}'
                      : 'Data not found!'),
              SizedBox(height: 2.px),
              cardSubTitleTextView(text: controller.getEducationList[index].universityLocation != null && controller.getEducationList[index].universityLocation!.isNotEmpty
                  ? '${controller.getEducationList[index].universityLocation}'
                  : 'Data not found!'),
              cardSubTitleTextView(text: controller.getEducationList[index].year != null && controller.getEducationList[index].year!.isNotEmpty
                  ? '${controller.getEducationList[index].year}'
                  : 'Data not found!'),
            ],
          ),
        ),
      );


  ///TODO Achievements View

  Widget achievementsListView() => controller.getAchievementsList.isNotEmpty
      ? ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.getAchievementsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.px),
            child: backgroundCardViewForAchievements(index: index),
          );
        },
      )
      : CW.commonNoDataFoundText(text:controller.apiResponseValue.value?'': 'Achievements not found!');

  Widget backgroundCardViewForAchievements({required int index}) => InkWell(
    onTap: () => controller.clickOnAchievementsData(index:index),
    borderRadius: BorderRadius.circular(4.px),
    child: Container(
          padding: EdgeInsets.all(14.px),
          decoration: BoxDecoration(
            color: const Color(0xffE9F9F0),
            borderRadius: BorderRadius.circular(4.px),
            border: Border.all(
              color: const Color(0xffC1EDD5),
              width: 1.px,
            ),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              cardTitleTextView(
                  text: controller.getAchievementsList[index].classAchievement != null && controller.getAchievementsList[index].classAchievement!.isNotEmpty
                      ? '${controller.getAchievementsList[index].classAchievement}'
                      : 'Data not found!'),
              SizedBox(height: 2.px),
              cardSubTitleTextView(text: controller.getAchievementsList[index].universityLocation != null && controller.getAchievementsList[index].universityLocation!.isNotEmpty
                  ? '${controller.getAchievementsList[index].universityLocation}'
                  : 'Data not found!'),
              cardSubTitleTextView(text: controller.getAchievementsList[index].year != null && controller.getAchievementsList[index].year!.isNotEmpty
                  ? '${controller.getAchievementsList[index].year}'
                  : 'Data not found!'),
            ],
          ),
        ),
  );

  Widget cardTitleTextView({required String text}) => Text(
        text,
        style: Theme
            .of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      );

  Widget cardSubTitleTextView({required String text}) => Text(
        text,
        style: Theme
            .of(Get.context!)
            .textTheme
            .labelSmall,
      );
}

/*class TriangleClipperForAchievements extends CustomClipper<Path> {
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
}*/
///TODO Education View
/*Widget triangleCardViewForEducation() => Positioned(
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
      );*/
///TODO Achievements View
/*Widget triangleCardViewForAchievements() => Positioned(
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
      );*/