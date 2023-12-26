import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
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
          return Stack(
            children: [
              Column(
                children: [
                  CW.commonNetworkImageView(
                      path: 'assets/images/edit_profile_back_image.png',
                      isAssetImage: true,
                      height: 346.px,
                      width: double.infinity),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.px, vertical: 30.px),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: [
                        firstNameTextField(),
                        SizedBox(height: 20.px),
                        lastNameTextField(),
                        SizedBox(height: 20.px),
                        emailTextField(),
                        SizedBox(height: 20.px),
                        mobileTextField(),
                        SizedBox(height: 20.px),
                        designationTextField(),
                      ],
                    ),
                  )
                ],
              ),
              profileView()
            ],
          );
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
              SizedBox(height: 22.px),
              profileImageView(),
              SizedBox(height: 6.px),
              userNameTextView(),
              SizedBox(height: 6.px),
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

  Widget saveButtonView() => CW.commonTextButton(
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
          height: 136.px,
          width: 136.px,
          padding: EdgeInsets.all(4.px),
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(68.px),
          ),
          child: Center(
            child: controller.image.value != null
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65.px),
                      child: Image.file(
                        controller.image.value!,
                        height: 130.px,
                        width: 130.px,
                      ),
                    ),
                  )
                : Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65.px),
                      child: CW.commonNetworkImageView(
                        path: controller.userPic.value.isNotEmpty
                            ? '${AU.baseUrlAllApisImage}${controller.userPic.value}'
                            : 'assets/images/profile.png',
                        errorImage: 'assets/images/profile.png',
                        isAssetImage:
                            controller.userPic.value.isNotEmpty ? false : true,
                        height: 130.px,
                        width: 130.px,
                      ),
                    ),
                  ),
          ),
        ),
      );

  Widget userNameTextView() => Text(
        controller.firstNameController.text.isNotEmpty || controller.lastNameController.text.isNotEmpty
            ? '${controller.firstNameController.text} ${controller.lastNameController.text}'
            : 'User Name',
        style: Theme.of(Get.context!).textTheme.headlineSmall,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget userDetailTextView() => Text(
    controller.developerType.value.isNotEmpty?controller.developerType.value:'Developer Type',
        style: Theme.of(Get.context!).textTheme.displaySmall,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget commonIconImage(
          {required String imagePath, double? height, double? width}) =>
      SizedBox(
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
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
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
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
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
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget mobileTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.mobileNumberController,
        labelText: 'Mobile Number',
        hintText: 'Mobile Number',
        keyboardType: TextInputType.number,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget designationTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.designationController,
        labelText: 'Designation',
        hintText: 'Designation',
        // keyboardType: TextInputType.emailAddress,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );
}
