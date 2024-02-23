import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/upcoming_celebrations_controller.dart';

class UpcomingCelebrationsView extends GetView<UpcomingCelebrationsController> {
  const UpcomingCelebrationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Upcoming Celebration',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: Obx(() {
        return ModalProgress(
          inAsyncCall: controller.apiResValue.value,
          child: AC.isConnect.value
              ? controller.getUpcomingCelebrationModal.value != null
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(left: 12.px,right: 12.px, top: 16.px),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'All',
                    //         style: Theme.of(Get.context!)
                    //             .textTheme
                    //             .bodyLarge
                    //             ?.copyWith(fontWeight: FontWeight.w500),
                    //       ),
                    //       Container(
                    //         height: 30.px,
                    //         width: 30.px,
                    //         decoration: BoxDecoration(
                    //             color: Col.primary.withOpacity(.1),
                    //             borderRadius: BorderRadius.circular(6.px)),
                    //         child: Center(
                    //           child: CW.commonNetworkImageView(
                    //               path: 'assets/icons/filter_icon.png',
                    //               isAssetImage: true,
                    //               width: 12.px,
                    //               height: 12.px),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 16.px),
                    upcomingCelebrationsView(),
                    SizedBox(height: 50.px),
                  ],
                )
              : controller.apiResValue.value
                  ? const SizedBox()
                  : CW.commonNoDataFoundText()
              : CW.commonNoNetworkView(),
        );
      }),
    );
  }

  Widget upcomingCelebrationsView() {
    if (controller.upcomingCelebrationList.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.px,
            mainAxisSpacing: 0.px,
            childAspectRatio: .8
        ),
        itemCount: controller.upcomingCelebrationList.length,
        itemBuilder: (context, index) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          final cardWidth = (screenWidth - 30) / 2; // Adjust as needed
          final cardHeight = cardWidth * 0.8; // Adjust the aspect ratio as needed

          return Container(
            width: cardWidth,
            height: cardHeight,
            margin:  EdgeInsets.only(left: index % 2 == 0 ? 10.px : 2.px,right: index % 2 == 0 ? 2.px : 10.px),
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.px),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CW.commonNetworkImageView(
                    path: controller.upcomingCelebrationList[index].celebrationType == 'Birthday'
                        ? 'assets/images/birthday_background_image.png'
                        : 'assets/images/work_anniversary_background_image.png',
                    isAssetImage: true,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: cardWidth,
                    padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 0),
                    margin: EdgeInsets.symmetric(horizontal: 12.px,vertical: 0),
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
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(27.px),
                              child: CW.commonNetworkImageView(
                                path: '${AU.baseUrlAllApisImage}${controller.upcomingCelebrationList[index].userProfilePic}',
                                isAssetImage: false,
                                errorImageValue: true,
                                userShortName: controller.upcomingCelebrationList[index].shortName != null && controller.upcomingCelebrationList[index].shortName!.isNotEmpty
                                    ? '${controller.upcomingCelebrationList[index].shortName}'
                                    : '?',
                                width: 50.px,
                                height: 50.px,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].userFullName != null && controller.upcomingCelebrationList[index].userFullName!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].userFullName}'
                                : '?',
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontSize: 10.px),
                        SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].userDesignation != null && controller.upcomingCelebrationList[index].userDesignation!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].userDesignation}'
                                : '?',
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            fontSize: 8.px,
                            textAlign: TextAlign.center),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].branchName != null && controller.upcomingCelebrationList[index].branchName!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].branchName} - ${controller.upcomingCelebrationList[index].departmentName}'
                                : '?',
                            fontWeight: FontWeight.w600,
                            maxLines: 2,
                            fontSize: 8.px,
                            textAlign: TextAlign.center),
                        SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].celebrationYear != null && controller.upcomingCelebrationList[index].celebrationYear!.isNotEmpty
                                ? '(${controller.upcomingCelebrationList[index].celebrationYear})'
                                : '?',
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            fontSize: 8.px),
                        SizedBox(height: 6.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].celebrationDate != null && controller.upcomingCelebrationList[index].celebrationDate!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].celebrationDate}'
                                : '?',
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontSize: 10.px),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return controller.apiResValue.value
          ? const SizedBox()
          : CW.commonNoDataFoundText();
    }
  }

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
}

/*Widget upcomingCelebrationsView() {
    return LayoutBuilder(builder: (context, constraints) {
      final itemWidth = constraints.maxWidth / .8;
      if (controller.upcomingCelebrationList.isNotEmpty) {
        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: .8,
          crossAxisSpacing: 0.px,
          mainAxisSpacing: 0.px,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: List.generate(controller.upcomingCelebrationList.length, (index) {
          return Container(
            width: itemWidth,
            // alignment: Alignment.center,
            margin:   EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.px),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CW.commonNetworkImageView(
                    path: controller.upcomingCelebrationList[index].celebrationType == 'Birthday'
                        ? 'assets/images/birthday_background_image.png'
                        : 'assets/images/work_anniversary_background_image.png',
                    isAssetImage: true,
                    height: 212.px,
                  ),
                  Container(
                    width: itemWidth,
                    padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 0),
                    margin: EdgeInsets.symmetric(horizontal: 12.px,vertical: 0),
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
                            child: controller.upcomingCelebrationList[index].userProfilePic != null &&
                                controller.upcomingCelebrationList[index].userProfilePic!.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(25.px),
                              child: CW.commonNetworkImageView(
                                path: '${AU.baseUrlAllApisImage}${controller.upcomingCelebrationList[index].userProfilePic}',
                                isAssetImage: false,
                                errorImage: 'assets/images/profile.png',
                                width: 50.px,
                                height: 50.px,
                              ),
                            )
                                : Text(
                              controller.upcomingCelebrationList[index].shortName != null && controller.upcomingCelebrationList[index].shortName!.isNotEmpty
                                  ? '${controller.upcomingCelebrationList[index].shortName}'
                                  : '?',
                              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].userFullName != null && controller.upcomingCelebrationList[index].userFullName!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].userFullName}'
                                : '?',
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontSize: 10.px),
                        SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].userDesignation != null && controller.upcomingCelebrationList[index].userDesignation!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].userDesignation}'
                                : '?',
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            fontSize: 8.px,
                            textAlign: TextAlign.center),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].branchName != null && controller.upcomingCelebrationList[index].branchName!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].branchName} - ${controller.upcomingCelebrationList[index].departmentName}'
                                : '?',
                            fontWeight: FontWeight.w600,
                            maxLines: 2,
                            fontSize: 8.px,
                            textAlign: TextAlign.center),
                        SizedBox(height: 2.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].celebrationYear != null && controller.upcomingCelebrationList[index].celebrationYear!.isNotEmpty
                                ? '(${controller.upcomingCelebrationList[index].celebrationYear})'
                                : '?',
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            fontSize: 8.px),
                        SizedBox(height: 6.px),
                        cardTextView(
                            text: controller.upcomingCelebrationList[index].celebrationDate != null && controller.upcomingCelebrationList[index].celebrationDate!.isNotEmpty
                                ? '${controller.upcomingCelebrationList[index].celebrationDate}'
                                : '?',
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontSize: 10.px),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        );
      } else {
        return controller.apiResValue.value
            ? const SizedBox()
            : CW.commonNoDataFoundText();
      }
    });
  }*/