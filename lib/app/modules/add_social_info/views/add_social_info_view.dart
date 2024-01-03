import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/add_social_info_controller.dart';

class AddSocialInfoView extends GetView<AddSocialInfoController> {
  const AddSocialInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title:controller.profileMenuName.value.isNotEmpty?controller.profileMenuName.value:'Social Info',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                children: [
                  twitterTextField(),
                  SizedBox(height: 20.px),
                  facebookTextField(),
                  SizedBox(height: 20.px),
                  instagramTextField(),
                  SizedBox(height: 20.px),
                  linkedinTextField(),
                  SizedBox(height: 20.px),
                ],
              ),
              Container(
                height: 80.px,
                padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                color: Col.inverseSecondary,
                child: Center(
                  child: CW.commonElevatedButton(
                      onPressed: () => controller.clickOnSaveButton(),
                      buttonText: 'Save',
                      isLoading: controller.saveButtonValue.value),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, Color? imageColor, bool isAssetImage = true}) => SizedBox(
    width: height ?? 24.px,
    height: width ?? 24.px,
    child: Center(
      child: CW.commonNetworkImageView(
          path: imagePath,
          isAssetImage: isAssetImage,
          color: imageColor,
          width: width ?? 24.px,
          height: height ?? 24.px),
    ),
  );

  Widget twitterTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.twitterController,
    labelText: 'Twitter',
    hintText: 'Twitter',
    prefixIcon: commonIconImageForTextField(imagePath: controller.twitterController.text.isNotEmpty?'assets/images/twitter_dark_image.png':'assets/images/twitter_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget facebookTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.facebookController,
    labelText: 'Facebook',
    hintText: 'Facebook',
    prefixIcon: commonIconImageForTextField(imagePath: controller.facebookController.text.isNotEmpty?'assets/images/facebook_dark_image.png':'assets/images/facebook_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget instagramTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.instagramController,
    labelText: 'Instagram',
    hintText: 'Instagram',
    prefixIcon: commonIconImageForTextField(imagePath: controller.instagramController.text.isNotEmpty?'assets/images/instagram_dark_image.png':'assets/images/instagram_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget linkedinTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.linkedinController,
    labelText: 'Linkedin',
    hintText: 'Linkedin',
    prefixIcon: commonIconImageForTextField(imagePath: controller.linkedinController.text.isNotEmpty?'assets/images/linkdin_dark_image.png':'assets/images/linkdin_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

}
