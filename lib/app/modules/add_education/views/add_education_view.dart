import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

import '../controllers/add_education_controller.dart';

class AddEducationView extends GetView<AddEducationController> {
  const AddEducationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Obx(() {
        controller.count.value;
        return Scaffold(
          appBar: CW.commonAppBarView(
              title: 'Add Achievements / Education',
              isLeading: true,
              onBackPressed: () => controller.clickOnBackButton()),
          body: Obx(() {
            controller.count.value;
            return achievementsView();
          }),
        );
      }),
    );
  }

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

  Widget achievementsView() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Form(
            key: controller.key,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
              children: [
                SizedBox(height: 5.px),
                achievementNameTextField(),
                SizedBox(height: 20.px),
                universityLocationTextField(),
                SizedBox(height: 20.px),
                yearTextField(),
                SizedBox(height: 20.px),
                remarkTextField(),
                SizedBox(height: 20.px),
                SizedBox(
                  height: 30.px,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CW.commonRadioView(
                              onChanged: (value) {
                                CM.unFocusKeyBoard();
                                controller.achievementAndEducationType.value = value.toString();
                                controller.count.value++;
                              },
                              index: index.toString(),
                              selectedIndex: controller.achievementAndEducationType.value,
                            ),
                            labelTextView(text: controller.labelTypeText[index])
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
          Container(
            height: 80.px,
            padding: EdgeInsets.only(
                left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
            color: Col.inverseSecondary,
            child: Center(
              child: CW.commonElevatedButton(
                  onPressed: controller.achievementAndEducationType.value != 'null' && controller.achievementAndEducationType.value.isNotEmpty
                      ? !controller.sendAddRequestButtonValue.value
                      ? () => controller.clickOnSendAddRequestButton()
                      : () => null
                      : () => null,
                  buttonText: 'Send Add Request',
                  isLoading: controller.sendAddRequestButtonValue.value,
                  buttonColor:
                      controller.achievementAndEducationType.value != 'null' &&
                              controller.achievementAndEducationType.value.isNotEmpty
                          ? Col.primary
                          : Col.primary.withOpacity(.5)),
            ),
          )
        ],
      );

  Widget achievementNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.achievementNameController,
        labelText: 'Class/Achievement',
        hintText: 'Class/Achievement',
        keyboardType: TextInputType.name,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter achievement name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget universityLocationTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.universityLocationController,
        labelText: 'University Location',
        hintText: 'University Location',
        keyboardType: TextInputType.name,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter university location'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget yearTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.yearController,
        labelText: 'Year',
        hintText: 'Year',
        keyboardType: TextInputType.name,
        prefixIcon:
            commonIconImage(imagePath: 'assets/icons/calender_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnYearTextField(),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter year'),
      );

  Widget remarkTextField() => CW.commonTextFieldForMultiline(
        fillColor: Colors.transparent,
        textInputAction: TextInputAction.newline,
        controller: controller.remarkController,
        labelText: 'Remark',
        hintText: 'Remark',
        keyboardType: TextInputType.multiline,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget labelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w500),
      );
}
