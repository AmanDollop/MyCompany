import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/select_department_controller.dart';

class SelectDepartmentView extends GetView<SelectDepartmentController> {
  const SelectDepartmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Select Department',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: WillPopScope(
        onWillPop: () => controller.clickOnBackButton(),
        child: Obx(() {
          controller.count.value;
          return ModalProgress(
            inAsyncCall: controller.apiResponseValue.value,
            child: controller.departmentModal.value != null
                ? controller.departmentList != null && controller.departmentList!.isNotEmpty
                ? Column(
              children: [
                Expanded(
                  child: CW.commonGridView(
                    length: controller.departmentList!.length,
                    child: (index) {
                      final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                      return SizedBox(
                        width: controller.departmentList?.length == 1?cellWidth*2:cellWidth ,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: index % 2 == 0 ? C.margin : C.margin / 2,
                              right: index % 2 == 0 ? C.margin / 2 : C.margin,
                              top: C.margin,
                              bottom: 0.px),
                          child: InkWell(
                            onTap: () {
                              controller.departmentIndexValue.value = controller.departmentList?[index].departmentName.toString() ?? '';
                              controller.departmentId.value = controller.departmentList?[index].departmentId.toString() ?? '';
                              controller.count.value++;
                            },
                            borderRadius: BorderRadius.circular(10.px),
                            child: Ink(
                              height: 60.px,
                              padding: EdgeInsets.only(left: 16.px, right: 12.px),
                              decoration: BoxDecoration(
                                color: controller.departmentIndexValue.value == controller.departmentList?[index].departmentName.toString()
                                    ? Col.primary.withOpacity(.06)
                                    : Col.gray.withOpacity(.3),
                                border: Border.all(
                                    color: controller.departmentIndexValue.value == controller.departmentList?[index].departmentName.toString()
                                        ? Col.primary
                                        : Col.gray,
                                    width: 1.px),
                                borderRadius: BorderRadius.circular(6.px),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: cardTextView(
                                      text: controller.departmentList?[index].departmentName != null && controller.departmentList![index].departmentName!.isNotEmpty
                                          ? '${controller.departmentList?[index]
                                          .departmentName}'
                                          : 'Department Name',
                                    ),
                                  ),
                                  CW.commonRadioView(
                                    onChanged: (value) {
                                      CM.unFocusKeyBoard();
                                      controller.departmentIndexValue.value = controller.departmentList?[index].departmentName.toString() ?? '';
                                      controller.departmentId.value = controller.departmentList?[index].departmentId.toString() ?? '';
                                      controller.count.value++;
                                    },
                                    index: controller.departmentList![index].departmentName.toString(),
                                    selectedIndex: controller.departmentIndexValue.value.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    height: 60.px,
                  ),
                ),
                SizedBox(height: 25.px),
                Container(
                  height: 80,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 3.px),
                  color: Col.inverseSecondary,
                  child: Center(
                    child: CW.commonElevatedButton(
                        onPressed: controller.departmentIndexValue.value != '' && controller.departmentId.value !=''
                            ? () => controller.clickOnContinueButton()
                            : () => null,
                        buttonText: controller.departmentIndexValue.value != '' && controller.departmentId.value !=''
                            ? 'Continue'
                            : 'Select Department'),
                  ),
                ),
              ],
            ): CW.commonNoDataFoundText()
                : CW.commonNoDataFoundText(text: controller.apiResponseValue.value?'':'Something went wrong!'),
          );
        }),
      ),
    );
  }

  Widget cardTextView({required String text}) =>
      Text(
        text,
        style: Theme
            .of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
