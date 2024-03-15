import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/job_info_controller.dart';

class JobInfoView extends GetView<JobInfoController> {
  const JobInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            CM.unFocusKeyBoard();
          },
          child: Scaffold(
            // appBar: appBarView(),
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(() {
                    controller.count.value;
                    if (controller.apiResponseValue.value) {
                      return Center(
                        child: CW.commonProgressBarView(color: Col.primary),
                      );
                    } else {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
                        children: [
                          commonRowForContactDetailView(
                              imagePath: 'assets/icons/dob_icon.png',
                              title: 'Designation',
                              subTitle: controller.designation.value.isNotEmpty
                                  ?controller.designation.value:'No Data Available!'),
                          SizedBox(height: 5.px),
                          commonRowForContactDetailView(
                              imagePath: 'assets/icons/dob_icon.png',
                              title: 'Employee Id',
                              subTitle: controller.employeeID.value.isNotEmpty
                                  ?controller.employeeID.value:'No Data Available!'),
                          SizedBox(height: 5.px),
                          commonRowForContactDetailView(
                              imagePath: 'assets/icons/dob_icon.png',
                              title: 'Employee Type',
                              subTitle: controller.employeeType.value.isNotEmpty
                                  ?controller.employeeType.value:'No Data Available!'),
                          SizedBox(height: 5.px),
                          commonRowForContactDetailView(
                              imagePath: 'assets/icons/dob_icon.png',
                              title: 'Joining Date',
                              subTitle: controller.joiningDate.value.isNotEmpty
                                  ?controller.joiningDate.value:'No Data Available!'),

                          SizedBox(height: 5.px),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.profileMenuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, bool isAssetImage = true,Color? imageColor}) => SizedBox(
    width: height ?? 24.px,
    height: width ?? 24.px,
    child: Center(
      child: CW.commonNetworkImageView(
          path: imagePath,
          color: imageColor,
          isAssetImage: isAssetImage,
          width: width ?? 24.px,
          height: height ?? 24.px),
    ),
  );


  Widget commonRowForContactDetailView({
    required String imagePath,
    required String title,
    required String subTitle,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonIconImageForTextField(imagePath: imagePath, imageColor: Col.primary),
            SizedBox(width: 10.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTitleTextView(title: title, textAlign: TextAlign.start, color: Col.gray, fontWeight: FontWeight.w500),
                SizedBox(height: 6.px),
                if (subTitle.isNotEmpty)
                  commonTitleTextView(title: subTitle, textAlign: TextAlign.end, maxLines: 3,color: Col.inverseSecondary),
              ],
            ),
          ],
        ),
        if (subTitle.isNotEmpty)
          SizedBox(height: 4.px),
        CW.commonDividerView(leftPadding: 32.px),
        SizedBox(height: 10.px),
      ],
    );
  }

  Widget commonTitleTextView({required String title, TextAlign? textAlign, int? maxLines, Color? color, FontWeight? fontWeight}) => Text(
        title,
        style: Theme.of(Get.context!)
            .textTheme
            .displayLarge
            ?.copyWith(fontSize: 14.px, color: color, fontWeight: fontWeight),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
      );
}
