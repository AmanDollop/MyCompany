import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
        backgroundColor: Col.scaffoldBackgroundColor,
        child: SafeArea(
          child: ListView(
            physics: const ScrollPhysics(),
            children: [
              SizedBox(height: 16.px),
              InkWell(
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
                            userNameTextView(text: 'Testing Dollop'),
                            userDetailTextView(text: 'Flutter'),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Col.darkGray,
                        size: 24.px,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.px),
              CW.commonDividerView(),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    companyTextView(),
                    SizedBox(width: 10.px),
                    Flexible(
                      child: userNameTextView(
                          text: 'Dollop Info-tech',
                          color: Col.primary,
                          maxLines: 2,
                          textAlign: TextAlign.end),
                    )
                  ],
                ),
              ),
              CW.commonDividerView(),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 10.px),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.iconList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => controller.clickOnList(index:index),
                    borderRadius: BorderRadius.circular(6.px),
                    child: Column(
                      children: [
                        SizedBox(height: 14.px),
                        Row(
                          children: [
                            CW.commonNetworkImageView(path: controller.iconList[index], isAssetImage: true,height: 24.px,width: 24.px),
                            SizedBox(width: 12.px),
                            titleTextView(text: controller.titleList[index])
                          ],
                        ),
                        SizedBox(height: 14.px),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget userProfileView() => Container(
        width: 60.px,
        height: 60.px,
        decoration: BoxDecoration(
          color: Col.scaffoldBackgroundColor,
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage('assets/images/profile.png'),
              fit: BoxFit.cover),
        ),
      );

  Widget userNameTextView(
          {required String text,
          Color? color,
          int? maxLines,
          TextAlign? textAlign}) =>
      Text(
        text,
        style:
            Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(color: color),
        maxLines: maxLines ?? 1,
        textAlign: textAlign ?? TextAlign.start,
        overflow: TextOverflow.ellipsis,
      );

  Widget userDetailTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .labelMedium
            ?.copyWith(fontWeight: FontWeight.w500),
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
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 1,
        textAlign: TextAlign.start,
      );
}
