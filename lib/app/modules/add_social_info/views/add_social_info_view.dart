import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import '../controllers/add_social_info_controller.dart';

class AddSocialInfoView extends GetView<AddSocialInfoController> {
  const AddSocialInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: (){
            CM.unFocusKeyBoard();
          },
          child: Scaffold(
            body: Obx(() {
              controller.count.value;
              return Column(
                children: [
                  appBarView(),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Form(
                          key: controller.key,
                          child: ListView(
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
                        ),
                        Container(
                          height: 80.px,
                          padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                          color: Colors.transparent,
                          child: Center(
                            child: CW.myElevatedButton(
                                onPressed: () => controller.clickOnSaveButton(),
                                buttonText: 'Save',
                                isLoading: controller.saveButtonValue.value),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.profileMenuName.value.isNotEmpty?controller.profileMenuName.value:'Social Info',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

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
    focusNode: controller.focusNodeForTwitter,
    // prefixIconPath: 'assets/images/twitter_dark_image.png',
    prefixIcon: commonIconImageForTextField(imagePath: controller.twitterController.text.isNotEmpty?'assets/images/twitter_dark_image.png':'assets/images/twitter_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    validator: (value) {
      if(value == null || value.isEmpty){
        return null;
      }
      if (!isValidTwitterUrl(value: value)) {
        return 'Invalid twitter url';
      }
      return null;
    },
  );

  Widget facebookTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.facebookController,
    labelText: 'Facebook',
    hintText: 'Facebook',
    focusNode: controller.focusNodeForFacebook,
    // prefixIconPath: 'assets/images/facebook_light_image.png',
    prefixIcon: commonIconImageForTextField(imagePath: controller.facebookController.text.isNotEmpty?'assets/images/facebook_dark_image.png':'assets/images/facebook_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    validator: (value) {
      if(value == null || value.isEmpty){
        return null;
      }
      if (!isValidFacebookUrl(value: value)) {
        return 'Invalid facebook url';
      }
      return null;
    },
  );

  Widget instagramTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.instagramController,
    labelText: 'Instagram',
    hintText: 'Instagram',
    focusNode: controller.focusNodeForInstagram,
    // prefixIconPath: 'assets/images/instagram_light_image.png',
    prefixIcon: commonIconImageForTextField(imagePath: controller.instagramController.text.isNotEmpty?'assets/images/instagram_dark_image.png':'assets/images/instagram_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    validator: (value) {
      if(value == null || value.isEmpty){
        return null;
      }
      if (!isValidInstagramUrl(value: value)) {
        return 'Invalid instagram url';
      }
      return null;
    },
  );

  Widget linkedinTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.linkedinController,
    labelText: 'Linkedin',
    hintText: 'Linkedin',
    focusNode: controller.focusNodeForLinkedin,
    // prefixIconPath: 'assets/images/linkdin_light_image.png',
    prefixIcon: commonIconImageForTextField(imagePath: controller.linkedinController.text.isNotEmpty?'assets/images/linkdin_dark_image.png':'assets/images/linkdin_light_image.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    validator: (value) {
      if(value == null || value.isEmpty){
        return null;
      }
      if (!isValidLinkedInUrl(value: value)) {
        return 'Invalid linkedin url';
      }
      return null;
    },
  );

  bool isValidTwitterUrl({String? value}) {
    RegExp twitterUrlRegex = RegExp(r'^https?://(?:www\.)?twitter\.com/');
    return twitterUrlRegex.hasMatch(value ?? '');
  }

  bool isValidFacebookUrl({String? value}) {
    RegExp facebookUrlRegex = RegExp(r'^https?://(?:www\.)?facebook\.com/');
    return facebookUrlRegex.hasMatch(value ?? '');
  }

  bool isValidInstagramUrl({String? value}) {
    RegExp instagramUrlRegex = RegExp(r'^https?://(?:www\.)?instagram\.com/');
    return instagramUrlRegex.hasMatch(value??'');
  }

  bool isValidLinkedInUrl({String? value}) {
    RegExp linkedinUrlRegex = RegExp(r'^https?://(?:www\.)?linkedin\.com/in/');
    return linkedinUrlRegex.hasMatch(value ?? '');
  }

}
