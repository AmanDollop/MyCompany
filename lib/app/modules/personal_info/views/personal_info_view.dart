import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarView(),
        floatingActionButton: Padding(
          padding:  EdgeInsets.only(bottom: 10.px),
          child: CW.commonOutlineButton(onPressed: () => controller.clickOnEditViewButton(),child: Icon(Icons.edit,color: Col.inverseSecondary,size: 22.px,),height: 50.px,width: 50.px,backgroundColor: Col.primary,borderColor: Colors.transparent,borderRadius: 25.px),
        ),
        body: Obx(() {
          controller.count.value;
          if (controller.apiResponseValue.value) {
            return Center(
              child: CW.commonProgressBarView(color: Col.primary),
            );
          }
          else {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
                  children: [
                    profileView(),
                    SizedBox(height: 25.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/user_icon.png',
                        title: 'User Name',
                        subTitle: controller.userFirstName.value.isNotEmpty &&
                                controller.userLastName.value.isNotEmpty
                            ? '${controller.userFirstName.value} ${controller.userLastName.value}'
                            : 'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/email_icon.png',
                        title: 'Email Address',
                        subTitle: controller.email.value.isNotEmpty
                            ?controller.email.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/contact_phone_icon.png',
                        title: 'Mobile Number',
                        subTitle: controller.mobileNumber.value.isNotEmpty
                            ?controller.mobileNumber.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/dob_icon.png',
                        title: 'Date of Birth',
                        subTitle: controller.dob.value.isNotEmpty
                            ? controller.dob.value
                            : 'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/blood_group_icon.png',
                        title: 'Blood Group',
                        subTitle: controller.bloodGroup.value.isNotEmpty
                            ?controller.bloodGroup.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/gender_icon.png',
                        title: 'Gender',
                        subTitle: controller.gender.value.isNotEmpty
                            ?controller.gender.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/interest_hobbies_icon.png',
                        title: 'Interest/Hobbies',
                        subTitle: controller.interestHobbies.value.isNotEmpty
                            ?controller.interestHobbies.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/location_icon.png',
                        title: 'Special Skills',
                        subTitle: controller.specialSkills.value.isNotEmpty
                            ?controller.specialSkills.value:'No Data Available!'),
                    SizedBox(height: 5.px),
                    commonRowForContactDetailView(
                        imagePath: 'assets/icons/languages_known_icon.png',
                        title: 'Languages Known',
                        subTitle: controller.languagesKnown.value.isNotEmpty
                            ?controller.languagesKnown.value:'No Data Available!'),
                    SizedBox(height: 20.px),
                  ],
                ),
                /*Container(
                  color: Col.inverseSecondary,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 12.px),
                    child: CW.commonElevatedButton(
                        onPressed: () => controller.clickOnEditViewButton(),
                        buttonText: 'Edit Detail'),
                  ),
                )*/
              ],
            );
          }
        }),
      ),
    );
  }

  AppBar appBarView() => CW.commonAppBarView(
        title: 'Personal Info',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      );

  Widget profileView() => Center(
    child: Container(
      height: 116.px,
      width: 116.px,
      padding: EdgeInsets.all(2.px),
      decoration: BoxDecoration(
        color: Col.primary,
        borderRadius: BorderRadius.circular(58.px),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(55.px),
          child: CW.commonNetworkImageView(path: 'assets/images/profile.png', isAssetImage: true),
        ),
      ),
    ),
  );

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, bool isAssetImage = true, Color? imageColor}) => SizedBox(
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

  Widget commonRowForContactDetailView({required String imagePath, required String title, required String subTitle,}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonIconImageForTextField(
                imagePath: imagePath, imageColor: Col.darkGray),
            SizedBox(width: 10.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTitleTextView(
                    title: title,
                    textAlign: TextAlign.start,
                    color: Col.darkGray,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 6.px),
                if (subTitle.isNotEmpty)
                  commonTitleTextView(
                      title: subTitle, textAlign: TextAlign.end, maxLines: 3),
              ],
            ),
          ],
        ),
        if (subTitle.isNotEmpty) SizedBox(height: 4.px),
        CW.commonDividerView(leftPadding: 20.px),
        SizedBox(height: 10.px),
      ],
    );
  }

  Widget commonTitleTextView({required String title, TextAlign? textAlign, int? maxLines, Color? color, FontWeight? fontWeight}) =>
      Text(
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
