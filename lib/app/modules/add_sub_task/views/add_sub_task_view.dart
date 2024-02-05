import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
      onTap: () {
        CM.unFocusKeyBoard();
      },
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.px, vertical: 16.px),
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
                      SizedBox(height: 10.px),
                      commonCheckBoxView(
                        text: 'Pending Attendance If Task Not Completed',
                        value: controller.notCompletedTaskValue.value,
                        onChanged: (value) {
                          controller.notCompletedTaskValue.value =
                              !controller.notCompletedTaskValue.value;
                          controller.count.value++;
                        },
                      ),
                      SizedBox(height: 10.px),
                      commonCheckBoxView(
                        text: 'Repeat Task',
                        value: controller.repeatTaskValue.value,
                        onChanged: (value) {
                          controller.repeatTaskValue.value =
                              !controller.repeatTaskValue.value;
                          controller.count.value++;
                        },
                      ),
                      SizedBox(height: 10.px),
                      remarkTextFormFiled(),
                      SizedBox(height: 10.px),
                      attachFile(),
                      SizedBox(height: 10.h),
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
                        onPressed: () => controller.clickOnAddAndUpdateButton(),
                        buttonColor: controller.notCompletedTaskValue.value &&
                                controller.repeatTaskValue.value
                            ? Col.primary
                            : Col.primary.withOpacity(.7),
                        buttonText: controller.pageName.value == 'Add Sub Task'
                            ? 'Add Sub Task'
                            : 'Update Sub Task',
                        borderRadius: 10.px),
                  ),
                )
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
        labelText: 'Enter Sub Task',
        hintText: 'Enter Sub Task',
        controller: controller.subTaskNameController,
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter sub task'),
      );

  Widget selectPriorityTextFormFiled() => CW.commonTextField(
      labelText: 'Select Priority',
      hintText: 'Select Priority',
      controller: controller.selectPriorityController,
      validator: (value) =>
          V.isValid(value: value, title: 'Please select priority'),
      readOnly: true,
      suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary));

  Widget taskStartDateTextFormFiled() => CW.commonTextField(
      labelText: 'Task Start Date',
      hintText: 'Task Start Date',
      controller: controller.taskStartDateController,
      validator: (value) =>
          V.isValid(value: value, title: 'Please select task start date'),
      suffixIcon: suffixIconForTextFormFiled(
          iconPath: 'assets/icons/working_days_icon.png'),
      readOnly: true);

  Widget dueStartDateTextFormFiled() => CW.commonTextField(
      labelText: 'Task Due Date',
      hintText: 'Task Due Date',
      controller: controller.taskDueDateController,
      validator: (value) =>
          V.isValid(value: value, title: 'Please select task due date'),
      suffixIcon: suffixIconForTextFormFiled(
          iconPath: 'assets/icons/working_days_icon.png'),
      readOnly: true);

  Widget dueTimeTextFormFiled() => CW.commonTextField(
      labelText: 'Due Time',
      hintText: 'Due Time',
      controller: controller.dueTimeController,
      validator: (value) =>
          V.isValid(value: value, title: 'Please select due time'),
      suffixIcon:
          suffixIconForTextFormFiled(iconPath: 'assets/icons/watch_icon.png'),
      readOnly: true);

  Widget commonCheckBoxView(
          {required String text,
          required bool value,
          required ValueChanged<bool?>? onChanged}) =>
      Container(
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

  Widget remarkTextFormFiled() => CW.commonTextFieldForMultiline(
      labelText: 'Remark',
      hintText: 'Remark',
      controller: controller.subTaskNameController,
      maxLines: 3);

  Widget attachFile() {
    return Center(
      child: InkWell(
        onTap: () => controller.clickOnAttachFileButton(),
        borderRadius: BorderRadius.circular(12.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(10.px),
          padding: EdgeInsets.all(12.px),
          child: SizedBox(
            width: double.infinity,
            height: 66.px,
            child: controller.result.value?.paths != null && controller.result.value!.paths.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: controller.docType.value != 'Image'
                            ? CW.commonNetworkImageView(
                                path: controller.docType.value,
                                isAssetImage: true,
                                height: 66.px)
                            : Container(
                                height: 66.px,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Col.primary,width: .5.px),
                                  borderRadius: BorderRadius.circular(6.px)
                                ),
                                child: Center(
                                  child: Image.file(
                                    File(controller.imagePath.value),
                                    fit: BoxFit.contain,
                                    height: 60.px,
                                    width: 100.px,
                                  ),
                                ),
                              ),
                      ),
                      InkWell(
                        onTap: () => controller.result.value = null,
                        child: Ink(
                          height: 30.px,
                          width: 30.px,
                          decoration: BoxDecoration(
                              color: Col.primary,
                              borderRadius: BorderRadius.circular(6.px)),
                          child: Icon(Icons.close,
                              color: Col.inverseSecondary, size: 20.px),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CW.commonNetworkImageView(
                          path: 'assets/icons/attach_file_icon.png',
                          isAssetImage: true,
                          width: 24.px,
                          height: 24.px),
                      SizedBox(width: 10.px),
                      Text(
                        'Attach File',
                        style: Theme.of(Get.context!).textTheme.titleMedium,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
