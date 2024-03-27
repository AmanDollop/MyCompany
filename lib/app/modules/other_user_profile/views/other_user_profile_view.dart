import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/other_user_profile_controller.dart';

class OtherUserProfileView extends GetView<OtherUserProfileController> {
  const OtherUserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(
                  () {
                    controller.count.value;
                    if (AC.isConnect.value) {
                      return ModalProgress(
                          inAsyncCall: controller.apiResValue.value,
                          child: controller.apiResValue.value
                              ? shimmerView()
                              : controller.userDataModal.value != null
                              ? controller.userData != null
                              ? ListView(
                                 padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                 children: [
                                   if(controller.personalInfo != null)
                                   personalInfoCardView(),
                                   if(controller.personalInfo != null)
                                   // SizedBox(height: 4.px),
                                   if(controller.contactInfo != null)
                                   contactInfoCardView(),
                                   if(controller.contactInfo != null)
                                   // SizedBox(height: 4.px),
                                   if(controller.jobInfo != null)
                                   jobInfoCardView(),
                                   if(controller.jobInfo != null)
                                   // SizedBox(height: 4.px),
                                   if(controller.socialInfo != null)
                                   socialInfoCardView(),
                                   // if(controller.socialInfo != null)
                                   // SizedBox(height: 4.px),
                                 ],
                               )
                              : CW.commonNoDataFoundText()
                              : CW.commonNoDataFoundText(),
                      );
                    } else {
                      return CW.commonNoNetworkView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: 'Employee Details',
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding:
            EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  Widget commonCardView({required Widget child,required String title}) => Container(
        margin: EdgeInsets.only(bottom: 10.px),
       padding: EdgeInsets.all(10.px),
        decoration: BoxDecoration(color: Col.gCardColor, borderRadius: BorderRadius.circular(6.px)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                   title,
                   style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(color: Col.primary),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
            SizedBox(height: 6.px),
            child,
          ],
        ),
      );

  Widget commonRowTextViewForCard({required String text1, required String text2}) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(text1,
                       style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(color: Col.gTextColor),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 0.px),
                  child: Text(':',
                      style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(color: Col.gTextColor, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(text2, style: Theme.of(Get.context!).textTheme.labelLarge),
          ),
        ],
      );

  Widget personalInfoCardView() => commonCardView(
      title: 'Personal Info',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.px),
              child: CW.commonNetworkImageView(
                  path:  '${AU.baseUrlAllApisImage}${controller.personalInfo?.userProfilePic}',
                  isAssetImage: false,
                  width: 80.px,
                  height: 80.px,
                  errorImageValue: true,
                  userShortName:  controller.personalInfo?.shortName != null && controller.personalInfo!.shortName!.isNotEmpty
                      ? controller.personalInfo?.shortName
                      : '?',
                  // userShortNameValue: true
              ),
            ),
            SizedBox(height: 10.px),
            if(controller.personalInfo?.userFullName != null && controller.personalInfo!.userFullName!.isNotEmpty)
            commonRowTextViewForCard(text1: 'Name', text2: '${controller.personalInfo?.userFullName}'),
            if(controller.personalInfo?.gender != null && controller.personalInfo!.gender!.isNotEmpty)
            commonRowTextViewForCard(text1: 'Gender', text2: '${controller.personalInfo?.gender}'),
            if(controller.personalInfo?.memberDateOfBirth != null && controller.personalInfo!.memberDateOfBirth!.isNotEmpty)
            commonRowTextViewForCard(text1: 'DOB', text2: CMForDateTime.dateFormatForDateMonthYear(date: '${controller.personalInfo?.memberDateOfBirth}')),
            if(controller.personalInfo?.skills != null && controller.personalInfo!.skills!.isNotEmpty)
            commonRowTextViewForCard(text1: 'Professional Skills', text2: '${controller.personalInfo?.skills}'),
          ],
        ),
      );

  Widget contactInfoCardView() => commonCardView(
    title: 'Contact Info',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(controller.contactInfo?.personalEmail != null && controller.contactInfo!.personalEmail!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Email', text2: '${controller.contactInfo?.personalEmail}'),
        if(controller.contactInfo?.userMobile != null && controller.contactInfo!.userMobile!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Contact', text2: '${controller.contactInfo?.userMobile}'),
        if(controller.contactInfo?.whatsappNumber != null && controller.contactInfo!.whatsappNumber!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Whatsapp Number', text2: '${controller.contactInfo?.whatsappNumber}'),
        if(controller.contactInfo?.userEmail != null && controller.contactInfo!.userEmail!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Company Email', text2: '${controller.contactInfo?.userEmail}'),
        if(controller.contactInfo?.currentAddress != null && controller.contactInfo!.currentAddress!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Current Address', text2: '${controller.contactInfo?.currentAddress}'),
      ],
    ),
  );

  Widget jobInfoCardView() => commonCardView(
    title: 'Job Info',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(controller.jobInfo?.userDesignation != null && controller.jobInfo!.userDesignation!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Designation', text2: '${controller.jobInfo?.userDesignation}'),
        if(controller.jobInfo?.employeeId != null && controller.jobInfo!.employeeId!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Employee ID', text2: '${controller.jobInfo?.employeeId}'),
        if(controller.jobInfo?.employeeTypeView != null && controller.jobInfo!.employeeTypeView!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Employment Type', text2: '${controller.jobInfo?.employeeTypeView}'),
        if(controller.jobInfo?.dateOfJoining != null && controller.jobInfo!.dateOfJoining!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Joining Date', text2: CMForDateTime.dateFormatForDateMonthYear(date: '${controller.jobInfo?.dateOfJoining}')),
        if(controller.jobInfo?.branchName != null && controller.jobInfo!.branchName!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Branch', text2: '${controller.jobInfo?.branchName}'),
        if(controller.jobInfo?.departmentName != null && controller.jobInfo!.departmentName!.isNotEmpty)
        commonRowTextViewForCard(text1: 'Department', text2: '${controller.jobInfo?.departmentName}'),
      ],
    ),
  );

  Widget commonContainerForSocialButton({required String imagePath, GestureTapCallback? onTap, double? height, double? width}) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18.px),
    child: Container(
      height: height ?? 30.px,
      width: width ?? 30.px,
      margin: EdgeInsets.only(right: 4.px),
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

  Widget socialInfoCardView() => commonCardView(
    title: 'Social Info',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        commonContainerForSocialButton(
          imagePath: controller.socialInfo?.twitter != null && controller.socialInfo!.twitter!.isNotEmpty
              ? 'assets/images/twitter_dark_image.png'
              : 'assets/images/twitter_light_image.png',
          onTap: () => controller.clickOnTwitterButton(),
          width: controller.socialInfo?.twitter != null && controller.socialInfo!.twitter!.isNotEmpty
                 ? 26.px
                 : 30.px,
          height: controller.socialInfo?.twitter != null && controller.socialInfo!.twitter!.isNotEmpty
              ? 26.px
              : 30.px,
        ),
        SizedBox(width: 5.px),
        commonContainerForSocialButton(
          imagePath: controller.socialInfo?.linkedin != null && controller.socialInfo!.linkedin!.isNotEmpty
              ? 'assets/images/linkdin_dark_image.png'
              : 'assets/images/linkdin_light_image.png',
          onTap: () => controller.clickOnLinkedinButton(),
          width: controller.socialInfo?.linkedin != null && controller.socialInfo!.linkedin!.isNotEmpty
              ? 26.px
              : 30.px,
          height: controller.socialInfo?.linkedin != null && controller.socialInfo!.linkedin!.isNotEmpty
              ? 26.px
              : 30.px,
        ),
        SizedBox(width: 5.px),
        commonContainerForSocialButton(
          imagePath: controller.socialInfo?.instagram != null && controller.socialInfo!.instagram!.isNotEmpty
              ? 'assets/images/instagram_dark_image.png'
              : 'assets/images/instagram_light_image.png',
          onTap: () => controller.clickOnInstagramButton(),
          width: controller.socialInfo?.instagram != null && controller.socialInfo!.instagram!.isNotEmpty
              ? 26.px
              : 30.px,
          height: controller.socialInfo?.instagram != null && controller.socialInfo!.instagram!.isNotEmpty
              ? 26.px
              : 30.px,
        ),
        SizedBox(width: 5.px),
        commonContainerForSocialButton(
          imagePath: controller.socialInfo?.facebook != null && controller.socialInfo!.facebook!.isNotEmpty
              ? 'assets/images/facebook_dark_image.png'
              : 'assets/images/facebook_light_image.png',
          onTap: () => controller.clickOnFacebookButton(),
          width: controller.socialInfo?.facebook != null && controller.socialInfo!.facebook!.isNotEmpty
              ? 26.px
              : 30.px,
          height: controller.socialInfo?.facebook != null && controller.socialInfo!.facebook!.isNotEmpty
              ? 26.px
              : 30.px,
        ),
      ],
    ),
  );

  Widget commonRowShimmerViewForCard() => Row(
    children: [
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: CW.commonShimmerViewForImage(height: 12.px,radius: 2.px),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 0.px),
              child: CW.commonShimmerViewForImage(width: 4.px,height: 12.px,radius: 1.px),
            ),
          ],
        ),
      ),
      Expanded(
        child: CW.commonShimmerViewForImage(height: 12.px,radius: 2.px),
      ),
    ],
  );

  Widget commonSocialButtonCardForSimmer() => Container(
      height:  30.px,
      width:  30.px,
      margin: EdgeInsets.only(right: 4.px),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Col.primaryWithOpacity
      ),
    child: Center(
       child: CW.commonShimmerViewForImage(width: 16.px,height: 16.px,radius: 2.px),
    ),
  );

  Widget commonCardViewForShimmer({bool profileValue = false,bool socialInfoValue = false}) => Container(
    margin: EdgeInsets.only(bottom: 10.px),
    padding: EdgeInsets.all(10.px),
    decoration: BoxDecoration(color: Col.gCardColor, borderRadius: BorderRadius.circular(6.px)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CW.commonShimmerViewForImage(width: 200.px,height: 25.px,radius: 2.px),
        SizedBox(height: 6.px),
        socialInfoValue
            ? Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 commonSocialButtonCardForSimmer(),
                 commonSocialButtonCardForSimmer(),
                 commonSocialButtonCardForSimmer(),
                 commonSocialButtonCardForSimmer(),
              ],
             )
            : Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 if(profileValue)
                   CW.commonShimmerViewForImage(width: 80.px,height: 80.px,radius: 40.px),
                 if(profileValue)
                   SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
                 SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
                 SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
                 SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
                 SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
                 SizedBox(height: 5.px),
                 commonRowShimmerViewForCard(),
               ],
             ),
      ],
    ),
  );

  Widget shimmerView() => ListView(
    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
    children: [
      commonCardViewForShimmer(profileValue: true),
      SizedBox(height: 10.px),
      commonCardViewForShimmer(),
      SizedBox(height: 10.px),
      commonCardViewForShimmer(),
      SizedBox(height: 10.px),
      commonCardViewForShimmer(socialInfoValue: true),
      SizedBox(height: 10.px),
    ],
  );

}
