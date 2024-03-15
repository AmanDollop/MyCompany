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
    return CW.commonScaffoldBackgroundColor(
      child: GestureDetector(
        onTap: () => CM.unFocusKeyBoard(),
        child: SafeArea(
          child: Scaffold(
            body: Obx(() {
              controller.count.value;
              if(controller.apiResponseValue.value){
                return Center(
                  child: CW.commonProgressBarView(color: Col.primary),
                );
              }
              else{
                return Column(
                  children: [
                    appBarView(),
                    Expanded(
                      child: Form(
                        key: controller.key,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 0.px),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: [
                            profileView(),
                            SizedBox(height: 16.px),
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
                                        genderLabelTextView(text: controller.genderText[index],color: Col.inverseSecondary)
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
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget profileView() => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12.px, right: 6.px),
          child: Column(
            children: [
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

  Widget appBarView() => CW.myAppBarView(
      title: 'Edit Profile',
      onLeadingPressed: () => controller.clickOnBackButton(),
      actionValue: true,
      action: saveButtonView(),
      padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
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

  Widget firstNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.firstNameController,
        focusNode: controller.focusNodeForFirstName,
        labelText: 'First Name',
        hintText: 'First Name',
        keyboardType: TextInputType.name,
        prefixIconPath: 'assets/icons/user_icon.png',
        validator: (value) => V.isValid(value: value, title: 'Please enter first name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget lastNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.lastNameController,
        focusNode: controller.focusNodeForLastName,
        labelText: 'Last Name',
        hintText: 'Last Name',
        keyboardType: TextInputType.name,

        prefixIconPath: 'assets/icons/user_icon.png',
        validator: (value) => V.isValid(value: value, title: 'Please enter last name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget emailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.emailController,
    focusNode: controller.focusNodeForEmail,
        labelText: 'Email Address',
        hintText: 'Email Address',
        keyboardType: TextInputType.emailAddress,
       textCapitalization: TextCapitalization.none,
        validator: (value) => V.isValid(value: value, title: 'Please enter email address'),
        prefixIconPath: 'assets/icons/email_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget hobbiesAndInterestTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.hobbiesAndInterestController,
        focusNode: controller.focusNodeForHobbiesAndInterest,
        labelText: 'Hobbies/Interest',
        hintText: 'Hobbies/Interest',

        prefixIconPath: 'assets/icons/interest_hobbies_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget skillsTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.skillsController,
        focusNode: controller.focusNodeForSkills,
        labelText: 'Skills',
        hintText: 'Skills',

        prefixIconPath: 'assets/icons/location_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget languageKnownTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.languageKnownController,
        focusNode: controller.focusNodeForLanguageKnown,
        labelText: 'Language Known',
        hintText: 'Language Known',

        prefixIconPath: 'assets/icons/languages_known_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget dobTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.dobController,
    focusNode: controller.focusNodeForDob,
    labelText: 'Date Of Birth',
    hintText: 'Date Of Birth',
    prefixIconPath: 'assets/icons/calender_icon.png',
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
    focusNode: controller.focusNodeForBloodGroup,
    labelText: 'Blood Group',
    hintText: 'Blood Group',
    prefixIconPath: 'assets/icons/blood_group_icon.png',
    onChanged: (value) {
      controller.count.value++;
    },
    onTap: () => controller.clickOnBloodGroupTextField(),
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
    // validator: (value) => V.isValid(value: value, title: 'Please enter Blood Group'),
  );

  Widget genderLabelTextView({required String text,Color? color}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: color),
  );

}
