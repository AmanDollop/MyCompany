import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/my_team_controller.dart';

class MyTeamView extends GetView<MyTeamController> {
  const MyTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(() {
                  controller.count.value;
                  if (AC.isConnect.value) {
                    return ModalProgress(
                      inAsyncCall: controller.apiResValue.value,
                      child: controller.apiResValue.value
                          ? shimmerView()
                          : controller.getMyTeamMemberModal.value != null
                              ? controller.myTeamMemberList != null && controller.myTeamMemberList!.isNotEmpty
                                  ? Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ListView(
                                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                          children: [
                                            myTeamListView(),
                                          ],
                                        ),
                                        addButtonView()
                                      ],
                                    )
                                  : CW.commonNoDataFoundText()
                              : CW.commonNoDataFoundText(),
                    );
                  } else {
                    return CW.commonNoNetworkView();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget appBarView() => CW.myAppBarView(
    title: 'Assign To',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
  );

  Widget cardTextView({required String text, Color? color, FontWeight? fontWeight}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: 10.px,
            color: color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );

  void showOverlay({required BuildContext context, required String imagePath, required String userShortName}) {
    controller.overlayEntry = CW.showOverlay(
        context: context,
        imagePath: imagePath,
        userShortName: userShortName,
        height: 200.px,
        width: 200.px,
        borderRadius: 100.px);
  }

  Widget myTeamListView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.px,
        mainAxisSpacing: 10.px,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.myTeamMemberList?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => controller.clickOnMyTeamCards(myTeamCardIndex: index),
          onLongPress: () {
            showOverlay(
              context: context,
              userShortName: controller.myTeamMemberList?[index].shortName != null && controller.myTeamMemberList![index].shortName!.isNotEmpty
                  ? '${controller.myTeamMemberList?[index].shortName}'
                  : '?',
              imagePath: '${AU.baseUrlAllApisImage}${controller.myTeamMemberList?[index].userProfilePic}',
            );
          },
          onLongPressCancel: () {
            controller.overlayEntry.remove();
          },
          onLongPressEnd: (details) {
            controller.overlayEntry.remove();
          },
          child: Ink(
            height: 106.px,
            width: 100.px,
            padding: EdgeInsets.only(left: 3.px),
            decoration: BoxDecoration(
              color: controller.selectedMyTeamMemberList.contains(controller.myTeamMemberList![index])
                  ? Col.primary.withOpacity(.2)
                  : Col.gCardColor,
              border: Border.all(
                  color: controller.selectedMyTeamMemberList.contains(controller.myTeamMemberList![index])
                      ? Col.primary
                      : Col.gCardColor),
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          path: '${AU.baseUrlAllApisImage}${controller.myTeamMemberList?[index].userProfilePic}',
                          isAssetImage: false,
                          errorImage: 'assets/images/profile.png',
                          width: 40.px,
                          height: 40.px,
                          errorImageValue: true,
                          userShortName: controller.myTeamMemberList?[index].shortName != null && controller.myTeamMemberList![index].shortName!.isNotEmpty
                              ? '${controller.myTeamMemberList?[index].shortName}'
                              : '?'),
                    ),
                  ),
                ),
                SizedBox(height: 6.px),
                cardTextView(
                    text: controller.myTeamMemberList?[index].userFullName != null && controller.myTeamMemberList![index].userFullName!.isNotEmpty
                        ? '${controller.myTeamMemberList?[index].userFullName}'
                        : '?',color: Col.inverseSecondary),
                cardTextView(
                    text: controller.myTeamMemberList?[index].userDesignation != null && controller.myTeamMemberList![index].userDesignation!.isNotEmpty
                        ? '${controller.myTeamMemberList?[index].userDesignation}'
                        : '?',
                    color: Col.gTextColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addButtonView() => Container(
        height: 80.px,
        padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
        color: Col.gBottom,
        child: Center(
          child: CW.myElevatedButton(
            onPressed: () => controller.clickOnAddButton(),
            buttonText: 'Add',
            borderRadius: 10.px,
          ),
        ),
      );

  Widget shimmerView() => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.px),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.px,
          mainAxisSpacing: 10.px,
        ),
        itemBuilder: (context, index) {
          return Ink(
            height: 132.px,
            padding: EdgeInsets.only(left: 3.px),
            decoration: BoxDecoration(
              color: Col.gCardColor,
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CW.commonShimmerViewForImage(width: 44.px, height: 44.px, radius: 22.px),
                SizedBox(height: 6.px),
                CW.commonShimmerViewForImage(width: 80.px, height: 14.px, radius: 2.px),
                SizedBox(height: 5.px),
                CW.commonShimmerViewForImage(width: 60.px, height: 10.px, radius: 2.px),
              ],
            ),
          );
        },
      );
}
