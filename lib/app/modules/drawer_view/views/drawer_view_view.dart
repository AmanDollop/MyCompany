import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/drawer_view_controller.dart';

class DrawerViewView extends GetView<DrawerViewController> {
  const DrawerViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Drawer(
        width: 75.w,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(20.px))),
        backgroundColor: Col.scaffoldBackgroundColor,
        child: ListView(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            // SizedBox(height: 16.px),
            Stack(
              alignment: Alignment.center,
              children: [
                CW.commonNetworkImageView(
                    path: 'assets/images/drawer_view_back_image.png',
                    isAssetImage: true,
                    height: 142.px,
                    width: double.infinity),
                Padding(
                  padding: EdgeInsets.only(top: 24.px),
                  child: InkWell(
                    onTap: () => controller.clickOnUserProfileView(),
                    borderRadius: BorderRadius.circular(8.px),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.px),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userProfileView(),
                          // SizedBox(width: 10.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                userNameTextView(
                                    text: controller.userFullName.value !=
                                                'null' &&
                                            controller
                                                .userFullName.value.isNotEmpty
                                        ? controller.userFullName.value
                                        : 'Employee Name',
                                    color: Col.inverseSecondary,
                                    fontSize: 16.px),
                                SizedBox(height: 2.px),
                                userDetailTextView(
                                  text: controller.developer.value != 'null' &&
                                          controller.developer.value.isNotEmpty
                                      ? controller.developer.value
                                      : 'Designation',
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Col.inverseSecondary,
                            size: 24.px,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.px),
            CW.commonDividerView(color: Col.gray.withOpacity(.4), wight: 1.px),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 10.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  companyTextView(),
                  SizedBox(width: 6.px),
                  Flexible(
                    child: userNameTextView(
                        text: controller.getCompanyDetails?.companyName != null && controller.getCompanyDetails!.companyName!.isNotEmpty
                            ? '${controller.getCompanyDetails?.companyName}'
                            : 'Company Name',
                        fontSize: 14.px,
                        color: Col.primary,
                        maxLines: 2,
                        textAlign: TextAlign.end),
                  )
                ],
              ),
            ),
            CW.commonDividerView(color: Col.gray.withOpacity(.4), wight: 1.px),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.iconList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.clickOnList(index: index),
                  borderRadius: BorderRadius.circular(6.px),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.px, horizontal: 12.px),
                    child: Row(
                      children: [
                        CW.commonNetworkImageView(
                            path: controller.iconList[index],
                            isAssetImage: true,
                            height: 22.px,
                            width: 22.px,
                            color: Col.darkGray.withOpacity(.8)),
                        SizedBox(width: 12.px),
                        titleTextView(text: controller.titleList[index])
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  Widget userProfileView() => Container(
        width: 72.px,
        height: 72.px,
        margin: EdgeInsets.only(right: 12.px),
        decoration: BoxDecoration(
            color:  Col.inverseSecondary,
            shape: BoxShape.circle),
        child:  Center(
                child: controller.userPic.value != 'null' && controller.userPic.value.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(31.px),
                  child: CW.commonNetworkImageView(
                      path: controller.userPic.value.isNotEmpty
                          ? '${AU.baseUrlAllApisImage}${controller.userPic.value}'
                          : 'assets/images/profile.png',
                      isAssetImage: controller.userPic.value.isNotEmpty ? false : true,
                      errorImage: 'assets/images/profile.png',
                      width: 66.px,
                      height: 66.px),
                ): Text(
                  controller.userShortName.value != 'null' &&
                          controller.userShortName.value.isNotEmpty
                      ? controller.userShortName.value
                      : '?',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                          fontWeight: FontWeight.w700, color: Col.primary)),
              ),
      );

  Widget userNameTextView(
          {required String text,
          Color? color,
          int? maxLines,
          TextAlign? textAlign,
          double? fontSize}) =>
      Text(
        text,
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),
        maxLines: maxLines ?? 1,
        textAlign: textAlign ?? TextAlign.start,
        overflow: TextOverflow.ellipsis,
      );

  Widget userDetailTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(color: Col.inverseSecondary),
        maxLines: 2,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      );

  Widget companyTextView() => Text(
        'Company',
        style: Theme.of(Get.context!).textTheme.titleLarge,
        maxLines: 2,
        textAlign: TextAlign.start,
      );

  Widget titleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600, color: Col.darkGray.withOpacity(.8)),
        maxLines: 1,
        textAlign: TextAlign.start,
      );
}
