import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import 'package:dotted_border/dotted_border.dart';
import '../controllers/add_sub_task_controller.dart';

class AddSubTaskView extends GetView<AddSubTaskController> {
  const AddSubTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: controller.pageName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(
          () {
            controller.count.value;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Form(
                  key: controller.key,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                    children: [
                      subTaskTextFormFiled(),
                      SizedBox(height: 10.px),
                      selectPriorityTextFormFiled(),
                      SizedBox(height: 10.px),
                      taskStartDateTextFormFiled(),
                      SizedBox(height: 10.px),
                      dueStartDateTextFormFiled(),
                      SizedBox(height: 10.px),
                      dueTimeTextFormFiled(),
                      // SizedBox(height: 10.px),
                      // commonCheckBoxView(
                      //   text: 'Pending Attendance If Task Not Completed',
                      //   value: controller.notCompletedTaskValue.value,
                      //   onChanged: (value) {
                      //     controller.notCompletedTaskValue.value =
                      //         !controller.notCompletedTaskValue.value;
                      //     controller.count.value++;
                      //   },
                      // ),
                      // SizedBox(height: 10.px),
                      // commonCheckBoxView(
                      //   text: 'Repeat Task',
                      //   value: controller.repeatTaskValue.value,
                      //   onChanged: (value) {
                      //     controller.repeatTaskValue.value =
                      //         !controller.repeatTaskValue.value;
                      //     controller.count.value++;
                      //   },
                      // ),
                      SizedBox(height: 10.px),
                      assignView(),
                      SizedBox(height: 10.px),
                      remarkTextFormFiled(),
                      SizedBox(height: 10.px),
                      attachFile(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                addAndUpdateButtonView()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget suffixIconForTextFormFiled({required String iconPath}) => SizedBox(
        height: 22.px,
        width: 22.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: iconPath,
              isAssetImage: true,
              height: 22.px,
              width: 22.px,
              color: Col.secondary),
        ),
      );

  Widget subTaskTextFormFiled() => CW.commonTextField(
        labelText: 'Enter Task',
        hintText: 'Enter Task',
        controller: controller.subTaskNameController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter task'),
      );

  Widget selectPriorityTextFormFiled() => CW.commonTextField(
        labelText: 'Select Priority',
        hintText: 'Select Priority',
        controller: controller.selectPriorityController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select priority'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary),
        onTap: () => controller.clickOnSelectPriorityTextFormFiled(),
      );

  Widget taskStartDateTextFormFiled() => CW.commonTextField(
        labelText: 'Task Start Date',
        hintText: 'Task Start Date',
        controller: controller.taskStartDateController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select task start date'),
        suffixIcon: suffixIconForTextFormFiled(
            iconPath: 'assets/icons/working_days_icon.png'),
        readOnly: true,
        onTap: () => controller.clickOnTaskStartDateTextFormFiled(),
      );

  Widget dueStartDateTextFormFiled() => CW.commonTextField(
        labelText: 'Task Due Date',
        hintText: 'Task Due Date',
        controller: controller.taskDueDateController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select task due date'),
        suffixIcon: suffixIconForTextFormFiled(
            iconPath: 'assets/icons/working_days_icon.png'),
        readOnly: true,
        onTap: () => controller.clickOnTaskDueDateTextFormFiled(),
      );

  Widget dueTimeTextFormFiled() => CW.commonTextField(
        labelText: 'Due Time',
        hintText: 'Due Time',
        controller: controller.dueTimeController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select due time'),
        suffixIcon:
            suffixIconForTextFormFiled(iconPath: 'assets/icons/watch_icon.png'),
        readOnly: true,
        onTap: () => controller.clickOnDueTimeTextFormFiled(),
      );

  Widget commonCheckBoxView({required String text, required bool value, required ValueChanged<bool?>? onChanged}) => Container(
        padding: EdgeInsets.only(
            left: 20.px, top: 12.px, bottom: 12.px, right: 12.px),
        decoration: BoxDecoration(
            border: Border.all(color: Col.gray),
            borderRadius: BorderRadius.circular(10.px)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: Theme.of(Get.context!).textTheme.labelSmall),
            SizedBox(
              height: 24.px,
              width: 24.px,
              child: CW.commonCheckBoxView(
                changeValue: value,
                onChanged: onChanged,
              ),
            )
          ],
        ),
      );

  Widget assignView() => Container(
        // height: 100.px,
        width: double.infinity,
        padding: EdgeInsets.only(top: 8.px, bottom: 8.px, left: 18.px, right: 10.px),
        decoration: BoxDecoration(
            color: Col.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(12.px),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                assignTextView(text: 'Assign To'),
                addAssignButtonView()
              ],
            ),
            SizedBox(height: 5.px),
            ListTile(
              horizontalTitleGap: 12.px,
              contentPadding: EdgeInsets.only(right: 2.px),
              leading: profileView(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  assignTextView(
                      text: controller.userFullName.value != 'null' && controller.userFullName.value.isNotEmpty
                          ? controller.userFullName.value
                          : 'Employee Name'),
                  developerTypeTextView(
                      text: controller.developer.value != 'null' && controller.developer.value.isNotEmpty
                          ? controller.developer.value
                          : 'Designation'),
                ],
              ),
              trailing: removeButtonView(),
            ),
          ],
        ),
      );

  Widget assignTextView({required String text,Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: color),
      );

  Widget addAssignButtonView() => InkWell(
        borderRadius: BorderRadius.circular(6.px),
        onTap: () {},
        child: Container(
          width: 24.px,
          height: 24.px,
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(6.px),
          ),
          child: Center(
            child: CW.commonNetworkImageView(
              path: 'assets/icons/outline_add_icon.png',
              height: 12.px,
              width: 12.px,
              isAssetImage: true,
            ),
          ),
        ),
      );

  Widget profileView() => Container(
        width: 40.px,
        height: 40.px,
        decoration: BoxDecoration(color: Col.inverseSecondary, shape: BoxShape.circle),
        child: Center(
          child: controller.userPic.value != 'null' && controller.userPic.value.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(31.px),
                  child: CW.commonNetworkImageView(
                      path: controller.userPic.value.isNotEmpty
                          ? '${AU.baseUrlAllApisImage}${controller.userPic.value}'
                          : 'assets/images/profile.png',
                      isAssetImage: controller.userPic.value.isNotEmpty ? false : true,
                      errorImage: 'assets/images/profile.png',
                      width: 40.px,
                      height: 40.px),
                )
              : assignTextView(text: controller.userShortName.value != 'null' && controller.userShortName.value.isNotEmpty
              ? controller.userShortName.value
              : '?',color: Col.primary),
        ),
      );

  Widget developerTypeTextView({required String text}) =>
      Text(text, style: Theme.of(Get.context!).textTheme.labelSmall);

  Widget removeButtonView() => InkWell(
        borderRadius: BorderRadius.circular(8.px),
        onTap: () {},
        child: CW.commonNetworkImageView(
          path: 'assets/icons/substack_icon.png',
          height: 16.px,
          width: 16.px,
          isAssetImage: true,
        ),
      );

  Widget remarkTextFormFiled() => CW.commonTextFieldForMultiline(
      labelText: 'Task Note',
      hintText: 'Task Note',
      controller: controller.remarkController,
      maxLines: 3);

  Widget attachFile() {
    return Center(
      child: InkWell(
        onTap: () => controller.clickOnAttachFileButton(),
        borderRadius: BorderRadius.circular(10.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(12.px),
          // padding: EdgeInsets.all(12.px),
          child: Container(
            width: double.infinity,
            height: 100.px,
            padding: EdgeInsets.all(12.px),
            decoration: BoxDecoration(
                color: Col.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.px)),
            child: controller.docType.value.isNotEmpty
                ? selectedImageView()
                : attachRowTextView(),
          ),
        ),
      ),
    );
  }

  Widget selectedImageView() {
    if (controller.pageName.value == 'Update Task') {
      return Center(
        child: controller.docType.value == 'Image'
            ? controller.imagePathFoeAdd.value.isNotEmpty
                ? fileImageAndNetworkImageView(
                    isFileImage: true,
                    imagePath: controller.imagePathFoeAdd.value)
                : fileImageAndNetworkImageView(
                    imagePath: controller.imagePathFoeUpDate.value)
            : docImageView(imagePath: controller.docLogo.value),
      );
    } else {
      return Row(
        mainAxisAlignment: controller.imagePathFoeAdd.value.isNotEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Center(
            child: controller.docType.value != 'Image'
                ? docImageView(imagePath: controller.docLogo.value)
                : controller.imagePathFoeAdd.value.isNotEmpty
                    ? fileImageAndNetworkImageView(
                        isFileImage: true,
                        imagePath: controller.imagePathFoeAdd.value)
                    : attachRowTextView(),
          ),
          if (controller.imagePathFoeAdd.value.isNotEmpty)
            InkWell(
              onTap: () {
                controller.result.value = null;
                controller.imagePathFoeAdd.value = '';
              },
              child: Ink(
                height: 30.px,
                width: 30.px,
                decoration: BoxDecoration(
                    color: Col.primary,
                    borderRadius: BorderRadius.circular(6.px)),
                child:
                    Icon(Icons.close, color: Col.inverseSecondary, size: 20.px),
              ),
            )
        ],
      );
    }
  }

  Widget fileImageAndNetworkImageView({bool isFileImage = false, required String imagePath}) {
    return Container(
      height: 100.px,
      width: 100.px,
      padding: EdgeInsets.all(10.px),
      decoration: BoxDecoration(
        color: Col.primary.withOpacity(.2),
        border: Border.all(color: Col.primary, width: .5.px),
        borderRadius: BorderRadius.circular(6.px),
      ),
      child: Center(
        child: isFileImage
            ? Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              )
            : CW.commonNetworkImageView(
                path: imagePath,
                isAssetImage: false,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  Widget docImageView({required String imagePath}) => CW.commonNetworkImageView(
        path: imagePath,
        isAssetImage: true,
        height: 66.px,
        width: 66.px,
      );

  Widget attachRowTextView() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CW.commonNetworkImageView(
              path: 'assets/icons/attach_file_icon.png',
              isAssetImage: true,
              width: 20.px,
              height: 20.px),
          SizedBox(width: 5.px),
          Text(
            'Task Attachment',
            style: Theme.of(Get.context!)
                .textTheme
                .titleMedium
                ?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
          )
        ],
      );

  Widget addAndUpdateButtonView() => Container(
        height: 80.px,
        padding: EdgeInsets.only(
            left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
        color: Col.inverseSecondary,
        child: Center(
          child: CW.commonElevatedButton(
              onPressed: controller.addSubTaskButtonValue.value
                  ? () => null
                  : () => controller.clickOnAddAndUpdateButton(),
              // buttonColor: controller.notCompletedTaskValue.value &&
              //         controller.repeatTaskValue.value
              //     ? Col.primary
              //     : Col.primary.withOpacity(.7),
              buttonText:
                  controller.pageName.value == 'Add Task' ? 'Add' : 'Update',
              borderRadius: 10.px,
              isLoading: controller.addSubTaskButtonValue.value),
        ),
      );
}
