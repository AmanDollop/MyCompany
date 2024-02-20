import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        body: Obx(() {
          controller.count.value;
          if(controller.apiResponseValue.value){
            return Center(
              child: CW.commonProgressBarView(color: Col.primary),
            );
          }
          else{
            return Stack(
              children: [
                Column(
                  children: [
                    CW.commonNetworkImageView(
                        path: 'assets/images/edit_profile_back_image.png',
                        isAssetImage: true,
                        height: 290.px,
                        width: double.infinity),
                    Expanded(
                      child: Form(
                        key: controller.key,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 18.px),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: [
                            firstNameTextField(),
                            SizedBox(height: 16.px),
                            lastNameTextField(),
                            SizedBox(height: 16.px),
                            emailTextField(),
                            SizedBox(height: 16.px),
                            hobbiesAndInterestTextField(),
                            SizedBox(height: 16.px),
                            skillsTextField(),
                            SizedBox(height: 16.px),
                            languageKnownTextField(),
                            SizedBox(height: 16.px),
                            dobTextField(),
                            SizedBox(height: 16.px),
                            bloodGroupTextField(),
                            SizedBox(height: 16.px),
                            SizedBox(
                              height: 30.px,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        CW.commonRadioView(
                                          onChanged: (value) {
                                            CM.unFocusKeyBoard();
                                            controller.genderIndexValue.value = value;
                                            controller.genderType.value = controller.genderText[index];
                                            controller.count.value++;
                                          },
                                          index: index.toString(),
                                          selectedIndex: controller.genderIndexValue.value.toString(),
                                        ),
                                        genderLabelTextView(text: controller.genderText[index])
                                      ],
                                    );
                                  },
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal),
                            ),
                            SizedBox(height: 30.px),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                profileView(),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget profileView() => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12.px, right: 6.px),
          child: Column(
            children: [
              appBarView(),
              SizedBox(height: 18.px),
              profileImageView(),
              SizedBox(height: 6.px),
              userNameTextView(),
              SizedBox(height: 2.px),
              userDetailTextView()
            ],
          ),
        ),
      );

  Widget appBarView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              backButtonView(),
              SizedBox(width: 16.px),
              editProfileTextView(),
            ],
          ),
          saveButtonView(),
        ],
      );

  Widget backButtonView() => SizedBox(
        height: 45.px,
        width: 45.px,
        child: Center(
          child: IconButton(
            onPressed: () => controller.clickOnBackButton(),
            style: IconButton.styleFrom(
              backgroundColor: Col.inverseSecondary,
              maximumSize: Size(45.px, 45.px),
            ),
            splashRadius: 24.px,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back,
              color: Col.secondary,
              size: 22.px,
            ),
          ),
        ),
      );

  Widget editProfileTextView() => Text(
        'Edit Profile',
        style: Theme.of(Get.context!).textTheme.displaySmall,
      );

  Widget saveButtonView() => controller.saveButtonValue.value
      ? Padding(
        padding:  EdgeInsets.only(right: 20.px),
        child: SizedBox(height: 20.px,width: 20.px,child: CW.commonProgressBarView(),),
      )
      : CW.commonTextButton(
        onPressed: () => controller.clickOnSaveButton(),
        child: Text(
          'Save',
          style: Theme.of(Get.context!).textTheme.displaySmall,
        ),
      );

  Widget profileImageView() => InkWell(
        onTap: () => controller.clickOnProfileButton(),
        borderRadius: BorderRadius.circular(68.px),
        child: Container(
          height: 116.px,
          width: 116.px,
          padding: EdgeInsets.all(4.px),
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(58.px),
          ),
          child: Center(
            child: controller.image.value != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(55.px),
                  child: Image.file(
                    controller.image.value!,
                    height: 110.px,
                    width: 110.px,
                  ),
                )
                :  ClipRRect(
                  borderRadius: BorderRadius.circular(65.px),
                  child: CW.commonNetworkImageView(
                    path: '${AU.baseUrlAllApisImage}${controller.userPic.value}',
                    isAssetImage: false,
                    height: 130.px,
                    width: 130.px,
                    errorImageValue: true,
                    userShortName: controller.userShortName.value!='null'&&controller.userShortName.value.isNotEmpty
                        ? controller.userShortName.value
                        : '?',
                    // userShortNameColor: Col.primary
                  ),
                ),
          ),
        ),
      );

  Widget userNameTextView() => Text(
        controller.userFullName.value.isNotEmpty
            ? controller.userFullName.value
            : 'Employee Name',
        style: Theme.of(Get.context!).textTheme.displaySmall,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget userDetailTextView() => Text(
    controller.userDesignation.value.isNotEmpty?controller.userDesignation.value:'Developer',
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px),
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget commonIconImage({required String imagePath, double? height, double? width}) => SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: true,
              width: width ?? 24.px,
              height: height ?? 24.px),
        ),
      );

  Widget firstNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.firstNameController,
        labelText: 'First Name',
        hintText: 'First Name',
        keyboardType: TextInputType.name,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        validator: (value) => V.isValid(value: value, title: 'Please enter first name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget lastNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.lastNameController,
        labelText: 'Last Name',
        hintText: 'Last Name',
        keyboardType: TextInputType.name,

        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
    validator: (value) => V.isValid(value: value, title: 'Please enter last name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget emailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.emailController,
        labelText: 'Email Address',
        hintText: 'Email Address',
        keyboardType: TextInputType.emailAddress,
       textCapitalization: TextCapitalization.none,
        validator: (value) => V.isValid(value: value, title: 'Please enter email address'),
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget hobbiesAndInterestTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.hobbiesAndInterestController,
        labelText: 'Hobbies/Interest',
        hintText: 'Hobbies/Interest',

        prefixIcon: commonIconImage(imagePath: 'assets/icons/interest_hobbies_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget skillsTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.skillsController,
        labelText: 'Skills',
        hintText: 'Skills',

        prefixIcon: commonIconImage(imagePath: 'assets/icons/location_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget languageKnownTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.languageKnownController,
        labelText: 'Language Known',
        hintText: 'Language Known',

        prefixIcon: commonIconImage(imagePath: 'assets/icons/languages_known_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget dobTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.dobController,
    labelText: 'Date Of Birth',
    hintText: 'Date Of Birth',
    prefixIcon:
    commonIconImage(imagePath: 'assets/icons/calender_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    onTap: () => controller.clickOnDOBTextField(),
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
  );

  Widget bloodGroupTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.bloodGroupController,
    labelText: 'Blood Group',
    hintText: 'Blood Group',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon:
    commonIconImage(imagePath: 'assets/icons/blood_group_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    onTap: () => controller.clickOnBloodGroupTextField(),
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
    // validator: (value) => V.isValid(value: value, title: 'Please enter Blood Group'),
  );

  Widget genderLabelTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
  );

}
