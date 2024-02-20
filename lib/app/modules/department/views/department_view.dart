import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/department_controller.dart';

class DepartmentView extends GetView<DepartmentController> {
  const DepartmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Your Department',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: Obx(() {
        return ModalProgress(
          inAsyncCall: controller.apiResValue.value,
          child: controller.apiResValue.value
              ? shimmerView()
              : controller.getDepartmentEmployeeModal.value != null
              ? controller.getDepartmentEmployeeList != null && controller.getDepartmentEmployeeList!.isNotEmpty
              ? GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 16.px),
            itemCount: controller.getDepartmentEmployeeList?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.clickOnCards(myTeamCardIndex: index),
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
                              path: '${AU.baseUrlAllApisImage}${controller.getDepartmentEmployeeList?[index].userProfilePic}',
                              isAssetImage: false,
                              errorImage: 'assets/images/profile.png',
                              fit: BoxFit.fill,
                              width: 40.px,
                              height: 40.px,
                              errorImageValue: true,
                              userShortName: controller.getDepartmentEmployeeList?[index].shortName != null && controller.getDepartmentEmployeeList![index].shortName!.isNotEmpty
                                  ? '${controller.getDepartmentEmployeeList?[index].shortName}'
                                  : '?'
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.px),
                      Flexible(
                        child: cardTextView(
                            text: controller.getDepartmentEmployeeList?[index].userFullName != null &&
                                controller.getDepartmentEmployeeList![index].userFullName!.isNotEmpty
                                ? '${controller.getDepartmentEmployeeList?[index].userFullName}'
                                : '?',
                            maxLines: 2,
                            fontSize: 10.px,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700),
                      ),
                      // SizedBox(height: 2.px),
                      Flexible(
                        child: cardTextView(
                            text: controller.getDepartmentEmployeeList?[index].userDesignation != null &&
                                controller.getDepartmentEmployeeList![index].userDesignation!.isNotEmpty
                                ? '${controller.getDepartmentEmployeeList?[index].userDesignation}'
                                : '?',
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
          )
              : CW.commonNoDataFoundText()
              : CW.commonNoDataFoundText(),
        );
      }),
    );
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
            CW.commonShimmerViewForImage(width: 44.px, height: 44.px,radius: 22.px),
            SizedBox(height: 6.px),
            CW.commonShimmerViewForImage(width: 80.px, height: 14.px,radius: 4.px),
            SizedBox(height: 5.px),
            CW.commonShimmerViewForImage(width: 60.px, height: 10.px,radius: 4.px),
          ],
        ),
      );
    },
  );

}
