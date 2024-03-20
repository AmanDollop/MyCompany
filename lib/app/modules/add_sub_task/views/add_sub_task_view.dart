import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import 'package:dotted_border/dotted_border.dart';
import '../controllers/add_sub_task_controller.dart';

class AddSubTaskView extends GetView<AddSubTaskController> {
  const AddSubTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => CM.unFocusKeyBoard(),
          child: Scaffold(
            // appBar: CW.commonAppBarView(
            //   title: controller.pageName.value,
            //   isLeading: true,
            //   onBackPressed: () => controller.clickOnBackButton(),
            // ),
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(
                    () {
                      controller.count.value;
                      return AC.isConnect.value
                          ? Stack(
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
                                      assignView(context: context),
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
                            )
                          : CW.commonNoNetworkView();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.pageName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
  );

  Widget suffixIconForTextFormFiled({required String iconPath}) => SizedBox(
        height: 22.px,
        width: 22.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: iconPath,
              isAssetImage: true,
              height: 22.px,
              width: 22.px,
              color: Col.gTextColor),
        ),
      );

  Widget subTaskTextFormFiled() => CW.commonTextField(
        labelText: 'Enter Task',
        hintText: 'Enter Task',
        focusNode: controller.focusNodeSubTaskName,
        controller: controller.subTaskNameController,
        validator: (value) => V.isValid(value: value, title: 'Please enter task'),
      );

  Widget selectPriorityTextFormFiled() => CW.commonTextField(
        labelText: 'Select Priority',
        hintText: 'Select Priority',
        focusNode: controller.focusNodeSelectPriority,
        controller: controller.selectPriorityController,
        validator: (value) => V.isValid(value: value, title: 'Please select priority'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_drop_down, color: Col.gTextColor),
        onTap: () => controller.clickOnSelectPriorityTextFormFiled(),
      );

  Widget taskStartDateTextFormFiled() => CW.commonTextField(
        labelText: 'Task Start Date',
        hintText: 'Task Start Date',
        controller: controller.taskStartDateController,
        focusNode: controller.focusNodeTaskStartDate,
        validator: (value) => V.isValid(value: value, title: 'Please select task start date'),
        suffixIcon: suffixIconForTextFormFiled(
            iconPath: 'assets/icons/working_days_icon.png'),
        readOnly: true,
        onTap: () => controller.clickOnTaskStartDateTextFormFiled(),
      );

  Widget dueStartDateTextFormFiled() => CW.commonTextField(
        labelText: 'Task Due Date',
        hintText: 'Task Due Date',
        controller: controller.taskDueDateController,
        validator: (value) => V.isValid(value: value, title: 'Please select task due date'),
        focusNode: controller.focusNodeTaskDueDate,
        suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/working_days_icon.png'),
        readOnly: true,
        onTap: () => controller.clickOnTaskDueDateTextFormFiled(),
      );

  Widget dueTimeTextFormFiled() => CW.commonTextField(
        labelText: 'Due Time',
        hintText: 'Due Time',
        controller: controller.dueTimeController,
        focusNode: controller.focusNodeDueTime,
        validator: (value) => V.isValid(value: value, title: 'Please select due time'),
        suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/watch_icon.png'),
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

  Widget assignView({required BuildContext context}) => Container(
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
                assignTextView(text: 'Assign To',color: Col.inverseSecondary),
                addAssignButtonView()
              ],
            ),
            SizedBox(height: 5.px),
            if(controller.selectedMyTeamMemberList.isNotEmpty)
              assignToListView(),
          ],
        ),
      );

  Widget assignToListView() => ListView.builder(
        // padding: EdgeInsets.only(top: 5.px),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.selectedMyTeamMemberList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CW.commonDividerView(),
              ListTile(
                horizontalTitleGap: 12.px,
                contentPadding: EdgeInsets.only(right: 2.px),
                leading: profileView(context: context,
                    imagePath: '${AU.baseUrlAllApisImage}${controller.selectedMyTeamMemberList[index].userProfilePic}',
                    userShortName: controller.selectedMyTeamMemberList[index].shortName != null && controller.selectedMyTeamMemberList[index].shortName!.isNotEmpty
                        ? '${controller.selectedMyTeamMemberList[index].shortName}'
                        :  '?'),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    assignTextView(
                        text: controller.selectedMyTeamMemberList[index].userFullName != null && controller.selectedMyTeamMemberList[index].userFullName!.isNotEmpty
                            ? '${controller.selectedMyTeamMemberList[index].userFullName}'
                            : 'Employee Name',color: Col.inverseSecondary),
                    developerTypeTextView(
                        text: controller.selectedMyTeamMemberList[index].userDesignation != null && controller.selectedMyTeamMemberList[index].userDesignation!.isNotEmpty
                            ? '${controller.selectedMyTeamMemberList[index].userDesignation}'
                            : 'Designation',color: Col.gTextColor),
                  ],
                ),
                trailing: removeButtonView(index:index),
              ),
              // if (index != controller.selectedMyTeamMemberList.length-1)
              //   CW.commonDividerView()
            ],
          );
        },
      );

  Widget assignTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: color),
      );

  Widget addAssignButtonView() {
    if(controller.selectedMyTeamMemberList.isEmpty){
      controller.assignToListViewValue.value = false;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(6.px),
      onTap: () => controller.clickOnAssignToAddButton(),
      child: Container(
        width: 24.px,
        height: 24.px,
        decoration: BoxDecoration(
          color: Col.gBottom,
          borderRadius: BorderRadius.circular(6.px),
        ),
        child: Center(
          child: controller.assignToListViewValue.value
              ? GradientImageWidget(
            assetPath:  'assets/icons/outline_minus_icon.png',
            height: 12.px,
            width: 12.px,
          ) :
          GradientImageWidget(
            assetPath: 'assets/icons/outline_add_icon.png',
            height: 12.px,
            width: 12.px,
          ),
        ),
      ),
    );
  }

  void showOverlay({required BuildContext context, required String imagePath, required String userShortName}) {
    controller.overlayEntry = CW.showOverlay(
        context: context,
        imagePath: imagePath,
        userShortName: userShortName,
        height: 200.px,
        width: 200.px,
        borderRadius: 100.px);
  }

  Widget profileView({required BuildContext context,required String imagePath,required String userShortName}) => GestureDetector(
        onLongPress: () {
          // Show overlay entry
          showOverlay(
            context: context,
            userShortName: userShortName,
            imagePath: imagePath,
          );
        },
        onLongPressCancel: () {
          controller.overlayEntry.remove();
        },
        onLongPressEnd: (details) {
          controller.overlayEntry.remove();
        },
        child: Container(
          width: 40.px,
          height: 40.px,
          decoration: BoxDecoration(
              color: Col.inverseSecondary, shape: BoxShape.circle),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(31.px),
              child: CW.commonNetworkImageView(
                path: imagePath,
                isAssetImage: false,
                width: 40.px,
                height: 40.px,
                errorImageValue: true,
                userShortName: userShortName,
              ),
            ),
          ),
        ),
      );

  Widget developerTypeTextView({required String text,Color? color}) => Text(text, style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(color: color));

  Widget removeButtonView({required int index}) => InkWell(
        borderRadius: BorderRadius.circular(8.px),
        onTap: () {
          controller.selectedMyTeamMemberList.remove(controller.selectedMyTeamMemberList[index]);
          controller.count.value++;
        },
        child: CW.commonNetworkImageView(
          path: 'assets/icons/substack_icon.png',
          height: 16.px,
          width: 16.px,
          isAssetImage: true,
          color: Col.primary
        ),
      );

  Widget remarkTextFormFiled() => CW.commonTextFieldForMultiline(
      labelText: 'Task Note',
      hintText: 'Task Note',
      controller: controller.remarkController,
      focusNode: controller.focusNodeRemark,
      isSearchLabelText: false,
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
        child: controller.docType.value == 'Unknown'
            ? attachRowTextView()
            : controller.docType.value == 'Image'
                ? controller.imagePathForAdd.value.isNotEmpty
                    ? fileImageAndNetworkImageView(
                        isFileImage: true,
                        imagePath: controller.imagePathForAdd.value)
                    : fileImageAndNetworkImageView(
                        imagePath: controller.imagePathFoeUpDate.value)
                : docImageView(imagePath: controller.docLogo.value),
      );
    } else {
      return Row(
        mainAxisAlignment: controller.imagePathForAdd.value.isNotEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Center(
            child: controller.docType.value != 'Image'
                ? docImageView(imagePath: controller.docLogo.value)
                : controller.imagePathForAdd.value.isNotEmpty
                    ? fileImageAndNetworkImageView(
                        isFileImage: true,
                        imagePath: controller.imagePathForAdd.value)
                    : attachRowTextView(),
          ),
          if (controller.imagePathForAdd.value.isNotEmpty)
            InkWell(
              onTap: () {
                controller.result.value = null;
                controller.imagePathForAdd.value = '';
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
          GradientImageWidget(
              assetPath: 'assets/icons/attach_file_icon.png',
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
        padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
        color: Col.gBottom,
        child: Center(
          child: CW.myElevatedButton(
              onPressed: controller.addSubTaskButtonValue.value
                  ? () => null
                  : controller.selectedMyTeamMemberList.isEmpty
                  ? () => null
                  : () => controller.clickOnAddAndUpdateButton(),
              buttonText: controller.pageName.value == 'Add Task' ? 'Add' : 'Update',
              borderRadius: 10.px,
              isLoading: controller.addSubTaskButtonValue.value,
          ),
        ),
      );
}
