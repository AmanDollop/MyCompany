// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/common/my_drop_down/my_drop_down.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/department_controller.dart';

class DepartmentView extends GetView<DepartmentController> {
  const DepartmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
        controller.isDropDownOpenValue.value = false;
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Your Department',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          return ModalProgress(
            inAsyncCall: controller.apiResValue.value,
            child: controller.apiResValue.value
                ? shimmerView()
                : Stack(
                    children: [
                      Container(
                        color: controller.isDropDownOpenValue.value
                            ? Col.gray.withOpacity(.4)
                            : Colors.transparent,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                          children: [
                            CW.commonTextField(
                              isSearchLabelText: false,
                              hintText: '',
                            ),
                            SizedBox(height: 12.px),
                            buildFilterChips(),
                            SizedBox(height: 12.px),
                            controller.apiResValueForDepartment.value
                                ? shimmerView()
                                : controller.getDepartmentEmployeeModal.value != null
                                ? controller.getDepartmentEmployeeList != null && controller.getDepartmentEmployeeList!.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: controller
                                            .getDepartmentEmployeeList?.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10.px,
                                          mainAxisSpacing: 10.px,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () =>
                                                controller.clickOnCards(
                                                    myTeamCardIndex: index),
                                            onLongPress: () {
                                              showOverlay(
                                                context: context,
                                                userShortName: controller
                                                                .getDepartmentEmployeeList?[
                                                                    index]
                                                                .shortName !=
                                                            null &&
                                                        controller
                                                            .getDepartmentEmployeeList![
                                                                index]
                                                            .shortName!
                                                            .isNotEmpty
                                                    ? '${controller.getDepartmentEmployeeList?[index].shortName}'
                                                    : '?',
                                                imagePath:
                                                    '${AU.baseUrlAllApisImage}${controller.getDepartmentEmployeeList?[index].userProfilePic}',
                                              );
                                            },
                                            onLongPressCancel: () {
                                              controller.overlayEntry.remove();
                                            },
                                            onLongPressEnd: (details) {
                                              controller.overlayEntry.remove();
                                            },
                                            child: Ink(
                                              height: 132.px,
                                              padding: EdgeInsets.only(left: 3.px),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 24.px,
                                                    color: Col.secondary
                                                        .withOpacity(.05),
                                                  )
                                                ],
                                                color: Col.inverseSecondary,
                                                borderRadius:
                                                    BorderRadius.circular(8.px),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 44.px,
                                                    height: 44.px,
                                                    margin: EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      color: Col.primary,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    22.px),
                                                        child: CW.commonNetworkImageView(
                                                            path:
                                                                '${AU.baseUrlAllApisImage}${controller.getDepartmentEmployeeList?[index].userProfilePic}',
                                                            isAssetImage: false,
                                                            errorImage:
                                                                'assets/images/profile.png',
                                                            fit: BoxFit.fill,
                                                            width: 40.px,
                                                            height: 40.px,
                                                            errorImageValue:
                                                                true,
                                                            userShortName: controller
                                                                            .getDepartmentEmployeeList?[
                                                                                index]
                                                                            .shortName !=
                                                                        null &&
                                                                    controller
                                                                        .getDepartmentEmployeeList![
                                                                            index]
                                                                        .shortName!
                                                                        .isNotEmpty
                                                                ? '${controller.getDepartmentEmployeeList?[index].shortName}'
                                                                : '?'),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.px),
                                                  Flexible(
                                                    child: cardTextView(
                                                        text: controller
                                                                        .getDepartmentEmployeeList?[
                                                                            index]
                                                                        .userFullName !=
                                                                    null &&
                                                                controller
                                                                    .getDepartmentEmployeeList![
                                                                        index]
                                                                    .userFullName!
                                                                    .isNotEmpty
                                                            ? '${controller.getDepartmentEmployeeList?[index].userFullName}'
                                                            : '?',
                                                        maxLines: 2,
                                                        fontSize: 10.px,
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  // SizedBox(height: 2.px),
                                                  Flexible(
                                                    child: cardTextView(
                                                        text: controller
                                                                        .getDepartmentEmployeeList?[
                                                                            index]
                                                                        .userDesignation !=
                                                                    null &&
                                                                controller
                                                                    .getDepartmentEmployeeList![
                                                                        index]
                                                                    .userDesignation!
                                                                    .isNotEmpty
                                                            ? '${controller.getDepartmentEmployeeList?[index].userDesignation}'
                                                            : '?',
                                                        maxLines: 2,
                                                        fontSize: 10.px,
                                                        color: Col.darkGray,
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : CW.commonNoDataFoundText()
                                : CW.commonNoDataFoundText()
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                        child: selectPriorityTextFormFiled(),
                      )
                    ],
                  ),
          );
        }),
      ),
    );
  }

  Widget selectPriorityTextFormFiled() => MyDropdown(
        items: controller.branchList ?? [],
        nameList: controller.branchNameList ?? [],
        selectedItem: controller.selectedBranchValue.value,
        hintText: 'Select Branch',
        textEditingController: controller.selectBranchController,
        isOpenValue: controller.isDropDownOpenValue.value,
        onTapForTextFiled: () {
          controller.isDropDownOpenValue.value = !controller.isDropDownOpenValue.value;
          controller.count.value++;
        },
        clickOnListOfDropDown: (value) => controller.clickOnListOfDropDown(value:value),
      );

  Widget buildFilterChips() => Wrap(
        spacing: 8.px,
        runSpacing: 0.px,
        children: controller.departmentList!.map((department) {
          return FilterChip(
            label: Text(
              department.departmentName ?? '',
              style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                  fontSize: 10.px,
                  color: controller.selectedDepartments.value == department.departmentName
                      ? Col.inverseSecondary
                      : Col.text,
                  fontWeight: FontWeight.w600),
            ),
            selected: controller.selectedDepartments.value == department.departmentName
                ? true
                : false,
            onSelected: (bool selected) => controller.clickOnDepartmentListFilter(selected:selected,dId:department.departmentId ?? '',dName: department.departmentName ?? ''),
            backgroundColor: Col.primary.withOpacity(.2),
            checkmarkColor: Col.inverseSecondary,
            selectedColor: Col.primary,
            elevation: 0,
          );
        }).toList(),
      );

  Widget cardTextView({required String text, double? fontSize, Color? color, int? maxLines, FontWeight? fontWeight, TextAlign? textAlign}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 14.px,
            color: color),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      );

  void showOverlay({required BuildContext context, required String imagePath, required String userShortName}) {
      controller.overlayEntry = CW.showOverlay(
        context: context,
        imagePath: imagePath,
        userShortName: userShortName,
        height: 200.px,
        width: 200.px,
        borderRadius: 100.px);
  }

  Widget shimmerView() => ListView(
    padding:  EdgeInsets.symmetric(horizontal: 12.px,vertical: 16.px),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      if(controller.apiResValue.value)
      CW.commonShimmerViewForImage(width: double.infinity, height: 44.px, radius: 12.px),
      if(controller.apiResValue.value)
      SizedBox(height: 6.px),
      if(controller.apiResValue.value)
      Row(
        children: [
          Expanded(child: CW.commonShimmerViewForImage(width: double.infinity, height: 14.px, radius: 2.px)),
          SizedBox(width: 6.px),
          Expanded(child: CW.commonShimmerViewForImage(width: double.infinity, height: 14.px, radius: 2.px)),
          SizedBox(width: 6.px),
          Expanded(child: CW.commonShimmerViewForImage(width: double.infinity, height: 14.px, radius: 2.px)),
        ],
      ),
      if(controller.apiResValue.value)
      SizedBox(height: 6.px),
      GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return Ink(
                height: 132.px,
                padding: EdgeInsets.only(left: 3.px),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24.px,
                      color: Col.secondary.withOpacity(.05),
                    )
                  ],
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CW.commonShimmerViewForImage(width: 44.px, height: 44.px, radius: 22.px),
                    SizedBox(height: 6.px),
                    CW.commonShimmerViewForImage(width: 80.px, height: 14.px, radius: 4.px),
                    SizedBox(height: 5.px),
                    CW.commonShimmerViewForImage(width: 60.px, height: 10.px, radius: 4.px),
                  ],
                ),
              );
            },
          ),
    ],
  );

}

