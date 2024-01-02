import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/add_social_info_controller.dart';

class AddSocialInfoView extends GetView<AddSocialInfoController> {
  const AddSocialInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title:'Social Info',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body:Stack(
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
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget facebookTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.facebookController,
    labelText: 'Facebook',
    hintText: 'Facebook',
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget instagramTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.instagramController,
    labelText: 'Instagram',
    hintText: 'Instagram',
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget linkedinTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.linkedinController,
    labelText: 'Linkedin',
    hintText: 'Linkedin',
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

}
