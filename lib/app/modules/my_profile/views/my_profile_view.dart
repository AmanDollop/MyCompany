import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_packages/model_progress_bar/model_progress_bar.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'My Profile',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.apiResponseValue.value,
          child: CW.commonRefreshIndicator(
            onRefresh: () async {
              controller.apiResponseValue.value=true;
              await controller.onInit();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          profileImageView(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                nameTextView(),
                                userDetailTextView(),
                              ],
                            ),
                          ),
                          editButtonView()
                        ],
                      ),
                      SizedBox(height: 20.px),
                      commonRowForEmailAndNumber(
                          title: 'Mobile Number',
                          name: controller.mobileNumber.value != 'null' &&
                                  controller.mobileNumber.isNotEmpty &&
                                  controller.countryCode.value != 'null' &&
                                  controller.countryCode.isNotEmpty
                              ? '${controller.countryCode} ${controller.mobileNumber}'
                              : '+91 1234567890'),
                      SizedBox(height: 2.px),
                      commonRowForEmailAndNumber(
                          title: 'Email Address',
                          name: controller.email.value != 'null' &&
                                  controller.email.isNotEmpty
                              ? '${controller.email}'
                              : 'test@gmai.com'),
                    ],
                  ),
                ),
                commonDividerView(),
                SizedBox(height: 6.px),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          commonContainerForSocialButton(
                            imagePath: controller.twitterUrl.value.isNotEmpty
                                ?'assets/images/twitter_dark_image.png':'assets/images/twitter_light_image.png',
                            onTap: () => controller.clickOnTwitterButton(),
                          ),
                          SizedBox(width: 10.px),
                          commonContainerForSocialButton(
                          imagePath: controller.linkedinUrl.isNotEmpty?'assets/images/linkdin_dark_image.png':'assets/images/linkdin_light_image.png',
                            onTap: () => controller.clickOnLinkedinButton(),
                          ),
                          SizedBox(width: 10.px),
                          commonContainerForSocialButton(
                           imagePath: controller.instagramUrl.isNotEmpty?'assets/images/instagram_dark_image.png':'assets/images/instagram_light_image.png',
                            onTap: () => controller.clickOnInstagramButton(),
                          ),
                          SizedBox(width: 10.px),
                          commonContainerForSocialButton(
                           imagePath: controller.facebookUrl.isNotEmpty?'assets/images/facebook_dark_image.png':'assets/images/facebook_light_image.png',
                            onTap: () => controller.clickOnFacebookButton(),
                          ),
                        ],
                      ),
                      commonContainerForSocialButton(
                        imagePath: 'assets/icons/edit_icon.png',
                        onTap: () => controller.clickOnEditSocialInfoButton(),
                        width: 36.px,
                        height: 36.px
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.px),
                commonDividerView(),
                if(controller.hideMyReportingPerson.value == '0')
                SizedBox(height: 16.px),
                reportingPersonListView(),
                SizedBox(height: 16.px),
                listView(),
                SizedBox(height: 30.px),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget profileImageView() {
    return Container(
      width: 66.px,
      height: 66.px,
      margin: EdgeInsets.only(right: 12.px),
      decoration: BoxDecoration(color: Col.primary, shape: BoxShape.circle),
      child: Center(
        child: controller.userPic.value != 'null' &&
            controller.userPic.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(31.px),
          child: CW.commonNetworkImageView(
              path: controller.userPic.value.isNotEmpty
                  ? '${AU.baseUrlAllApisImage}${controller.userPic.value}'
                  : 'assets/images/profile.png',
              isAssetImage:
              controller.userPic.value.isNotEmpty ? false : true,
              errorImage: 'assets/images/profile.png',
              width: 62.px,
              height: 62.px),
        )
            : Text(
            controller.userShortName.value != 'null' &&
                controller.userShortName.value.isNotEmpty
                ? controller.userShortName.value
                : '?',
            style: Theme.of(Get.context!)
                .textTheme
                .displaySmall
                ?.copyWith(
                fontWeight: FontWeight.w700,
                color: Col.inverseSecondary)),
      ),
    );
  }

  Widget nameTextView() => Text(
      controller.userFullName.value != 'null' &&
              controller.userFullName.isNotEmpty
          ? controller.userFullName.value
          : 'Employee Name',
      style: Theme.of(Get.context!)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis);

  Widget userDetailTextView() => Text(
      controller.developer.value != 'null' && controller.developer.isNotEmpty
          ? '${controller.developer}'
          : 'Designation',
      style: Theme.of(Get.context!)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500),
      maxLines: 1,
      overflow: TextOverflow.ellipsis);

  Widget editButtonView() => CW.commonIconButton(
      onPressed: () => controller.clickOnEditButton(),
      isAssetImage: true,
      imagePath: 'assets/icons/edit_icon.png',
      width: 40.px,
      size: 40.px);

  Widget commonRowForEmailAndNumber({required String title, required String name}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          Flexible(
            flex: 7,
            child: Text(
              name,
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );

  Widget commonDividerView() => Center(
        child: Dash(
            direction: Axis.horizontal,
            length: 99.w,
            dashLength: 5.px,
            dashThickness: .5.px,
            dashColor: Col.secondary),
      );

  Widget commonContainerForSocialButton({required String imagePath, GestureTapCallback? onTap,double? height,double? width}) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.px),
        child: Ink(
          height: height ?? 24.px,
          width:width?? 24.px,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                imagePath,
              ),
            ),
          ),
        ),
      );

  Widget commonCardForList({required Widget listWidget, required String titleText, VoidCallback? onPressedViewAllButton}) => Card(
        margin: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0.px),
        color: Col.inverseSecondary,
        shadowColor: Col.secondary.withOpacity(.1),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Col.gray.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleText != '')
              Padding(
                padding: EdgeInsets.only(left: 12.px, right: 12.px, top: 12.px,bottom: 2.px),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            listWidget
          ],
        ),
      );

  Widget commonCard({required String imagePath, required String text1, String? text2, bool text2Value = false, bool isAssetImage = true, double? imageWidth, double? imageHeight, double? cardHeight,int? maxLines}) => Ink(
        height: cardHeight ?? 134.px,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // width: 44.px,
              // height: 44.px,
              margin: EdgeInsets.only(top: 12.px),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: isAssetImage?
                  CW.commonNetworkImageView(
                    path: imagePath,
                    isAssetImage: isAssetImage,
                    width: imageWidth ?? 44.px,
                    height: imageHeight ?? 44.px,)
                  : Center(
                child: CW.commonCachedNetworkImageView(
                  path: imagePath,
                  width: imageWidth ?? 44.px,
                  height: imageHeight ?? 44.px,
                ),
              ),
            ),
            SizedBox(height: 6.px),
            Flexible(
              child: Text(
                text1,
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 10.px),
                maxLines: maxLines ?? 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            // if (text2Value)
            // SizedBox(height: 4.px),
            if (text2Value)
            Flexible(
                child: Text(
                  text2 ?? "",
                  style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: maxLines ?? 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      );

  Widget reportingPersonListView() {
      if (controller.getEmployeeDetails != null && controller.getEmployeeDetails!.isNotEmpty) {
        return commonCardForList(
          titleText: 'Reporting Person',
          listWidget: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.getEmployeeDetails?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
              childAspectRatio: .95
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.getEmployeeDetails?[index].menuClick != null && controller.getEmployeeDetails![index].menuClick!.isNotEmpty
                        ? controller.clickOnList(listIndex: index)
                        : CM.error(),
                borderRadius: BorderRadius.circular(8.px),
                child: commonCard(
                    imagePath: 'assets/images/profile.png',
                    text1: 'Testing Dollop',
                    text2Value: true,
                    text2: 'Flutter Developer',
                  maxLines: 1,
                ),
              );
            },
          ),
        );
      } else {
        return controller.apiResponseValue.value
            ? const SizedBox()
            : CW.commonNoDataFoundText();
      }

  }

  Widget listView() {
      if (controller.getEmployeeDetails != null && controller.getEmployeeDetails!.isNotEmpty) {
        return commonCardForList(
          titleText: 'Profile Menu',
          listWidget: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.getEmployeeDetails?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    controller.getEmployeeDetails?[index].menuClick != null &&
                            controller.getEmployeeDetails![index].menuClick!.isNotEmpty
                        ? controller.clickOnList(listIndex: index)
                        : CM.error(),
                borderRadius: BorderRadius.circular(8.px),
                child: commonCard(
                    // gradient: LinearGradient(colors: controller.cList[index]),
                    // imageHeight: 24.px,
                    // imageWidth: 24.px,
                    imagePath: controller.getEmployeeDetails?[index].profileMenuPhoto != null &&
                            controller.getEmployeeDetails![index].profileMenuPhoto!.isNotEmpty
                        ? '${AU.baseUrlAllApisImage}${controller.getEmployeeDetails![index].profileMenuPhoto}'
                        : 'assets/images/shoping_dark.png',
                    isAssetImage: controller.getEmployeeDetails?[index].profileMenuPhoto != null &&
                            controller.getEmployeeDetails![index].profileMenuPhoto!.isNotEmpty
                        ? false
                        : true,
                    text1: controller.getEmployeeDetails?[index].profileMenuName != null &&
                            controller.getEmployeeDetails![index].profileMenuName!.isNotEmpty
                        ? '${controller.getEmployeeDetails![index].profileMenuName}'
                        : 'Menu Name Not Found!',
                    cardHeight: 100.px),
              );
            },
          ),
        );
      } else {
        return controller.apiResponseValue.value
            ? const SizedBox()
            : CW.commonNoDataFoundText();
      }

  }
}
