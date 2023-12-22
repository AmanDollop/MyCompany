import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/select_shift_time_controller.dart';

class SelectShiftTimeView extends GetView<SelectShiftTimeController> {
  const SelectShiftTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Select Shift Time',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: WillPopScope(
        onWillPop: () => controller.clickOnBackButton(),
        child: Obx(() {
          controller.count.value;
          return ModalProgress(
            inAsyncCall: controller.apiResponseValue.value,
            child: controller.shiftTimeModal.value != null
                ? controller.shiftTimeList != null &&
                        controller.shiftTimeList!.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: CW.commonGridView(
                              length: controller.shiftTimeList!.length,
                              child: (index) {
                                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                                return SizedBox(
                                  width: cellWidth,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                                        top: C.margin,
                                        bottom: 0.px),
                                    child: InkWell(
                                      onTap: () {
                                        controller.shiftTimeIndexValue.value = controller.shiftTimeList?[index].shiftName.toString() ?? '';
                                        controller.shiftTimeId.value = controller.shiftTimeList?[index].shiftId.toString() ?? '';
                                        controller.count.value++;
                                      },
                                      borderRadius: BorderRadius.circular(10.px),
                                      child: Ink(
                                        height: 60.px,
                                        padding: EdgeInsets.only(left: 16.px, right: 12.px),
                                        decoration: BoxDecoration(
                                          color: controller.shiftTimeIndexValue.value == controller.shiftTimeList?[index].shiftName.toString()
                                              ? Col.primary.withOpacity(.06)
                                              : Col.gray.withOpacity(.3),
                                          border: Border.all(
                                              color: controller.shiftTimeIndexValue.value == controller.shiftTimeList?[index].shiftName.toString()
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
                                                text: controller.shiftTimeList?[index].shiftName != null && controller.shiftTimeList![index].shiftName!.isNotEmpty
                                                    ? '${controller.shiftTimeList?[index].shiftName}'
                                                    : 'Shift Time',
                                              ),
                                            ),
                                            CW.commonRadioView(
                                              onChanged: (value) {
                                                CM.unFocusKeyBoard();
                                                controller.shiftTimeIndexValue.value = controller.shiftTimeList?[index].shiftName.toString() ?? '';
                                                controller.shiftTimeId.value = controller.shiftTimeList?[index].shiftId.toString() ?? '';
                                                controller.count.value++;
                                              },
                                              index: controller.shiftTimeList![index].shiftName.toString(),
                                              selectedIndex: controller.shiftTimeIndexValue.value.toString(),
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
                            padding: EdgeInsets.symmetric(vertical: 4.px,horizontal: 12.px,),
                            color: Col.inverseSecondary,
                            child: Center(
                              child: CW.commonElevatedButton(
                                  onPressed: controller.shiftTimeIndexValue.value != '' && controller.shiftTimeId.value != ''
                                      ? () => controller.clickOnContinueButton()
                                      : () => null,
                                  buttonText: controller.shiftTimeIndexValue.value != '' && controller.shiftTimeId.value != ''
                                      ? 'Continue'
                                      : 'Select Shift Time'),
                            ),
                          ),
                        ],
                      )
                    : CW.commonNoDataFoundText()
                : CW.commonNoDataFoundText(
                    text: controller.apiResponseValue.value
                        ? ''
                        : 'Something went wrong!'),
          );
        }),
      ),
    );
  }

  Widget cardTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
