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
                          SizedBox(width: 10.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                userNameTextView(
                                    text: controller.firstName.value!='null'&&controller.firstName.value.isNotEmpty &&
                                        controller.lastName.value!='null'&&controller.lastName.value.isNotEmpty
                                        ? '${controller.firstName.value}${controller.lastName.value}'
                                        : 'User Name',
                                    color: Col.inverseSecondary,
                                    fontSize: 18.px),
                                SizedBox(height: 4.px),
                                userDetailTextView(
                                  text:
                                  controller.developerType.value!='null'&&controller.developerType.value.isNotEmpty
                                          ? controller.developerType.value
                                          : 'Developer',
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
            CW.commonDividerView(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  companyTextView(),
                  SizedBox(width: 10.px),
                  Flexible(
                    child: userNameTextView(
                        text: controller.companyName.value!='null'&&controller.companyName.value.isNotEmpty
                            ? controller.companyName.value
                            : 'Company Name',
                        color: Col.primary,
                        maxLines: 2,
                        textAlign: TextAlign.end),
                  )
                ],
              ),
            ),
            CW.commonDividerView(),
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.px),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.iconList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.clickOnList(index: index),
                  borderRadius: BorderRadius.circular(6.px),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 12.px),
                    child: Row(
                      children: [
                        CW.commonNetworkImageView(
                            path: controller.iconList[index],
                            isAssetImage: true,
                            height: 24.px,
                            width: 24.px),
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
                color: Col.inverseSecondary, shape: BoxShape.circle),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(31.px),
                child: CW.commonNetworkImageView(
                    path: controller.userPic.value.isNotEmpty
                        ? '${AU.baseUrlAllApisImage}${controller.userPic.value}'
                        : 'assets/images/profile.png',
                    isAssetImage:
                        controller.userPic.value.isNotEmpty ? false : true,
                    width: 66.px,
                    height: 66.px),
              ),
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
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge
            ?.copyWith(color: color, fontSize: fontSize),
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
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
        maxLines: 1,
        textAlign: TextAlign.start,
      );
}
