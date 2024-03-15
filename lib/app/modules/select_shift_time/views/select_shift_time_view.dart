import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/select_shift_time_controller.dart';

class SelectShiftTimeView extends GetView<SelectShiftTimeController> {
  const SelectShiftTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          // appBar: CW.commonAppBarView(
          //   title: 'Select Shift Time',
          //   isLeading: true,
          //   onBackPressed: () => controller.clickOnBackButton(),
          // ),
          body: WillPopScope(
            onWillPop: () => controller.clickOnBackButton(),
            child: Obx(() {
              controller.count.value;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.px, top: 12.px, right: 12.px),
                    child: CW.myAppBarView(
                        title: 'Select Shift Time',
                        onLeadingPressed: () => controller.clickOnBackButton(),
                        padding: EdgeInsets.zero
                    ),
                  ),
                  Expanded(
                    child: ModalProgress(
                      inAsyncCall: controller.apiResponseValue.value,
                      child: controller.shiftTimeModal.value != null
                          ? controller.shiftTimeList != null && controller.shiftTimeList!.isNotEmpty
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
                                              child: CustomOutlineButton(
                                                padding: EdgeInsets.only(left: 14.px, right: 0.px,top: 2.px,bottom: 2.px),
                                                onPressed: () {
                                                  controller.shiftTimeIndexValue.value = controller.shiftTimeList?[index].shiftName.toString() ?? '';
                                                  controller.shiftTimeId.value = controller.shiftTimeList?[index].shiftId.toString() ?? '';
                                                  controller.count.value++;
                                                },
                                                radius: 10.px,
                                                strokeWidth: 1.px,
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: controller.shiftTimeIndexValue.value == controller.shiftTimeList?[index].shiftName.toString()
                                                      ? [
                                                    Col.primary,
                                                    Col.primaryColor,
                                                  ]
                                                      : [
                                                    Col.gray,
                                                    Col.gray,
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: cardTextView(
                                                        text: controller.shiftTimeList?[index].shiftName != null && controller.shiftTimeList![index].shiftName!.isNotEmpty
                                                            ? '${controller.shiftTimeList?[index].shiftName}'
                                                            : 'Shift Time',
                                                        color: controller.shiftTimeIndexValue.value == controller.shiftTimeList?[index].shiftName.toString()
                                                            ? Col.primary
                                                            : Col.inverseSecondary
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
                                      color: Colors.transparent,
                                      child: Center(
                                        child: CW.myElevatedButton(
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
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget cardTextView({required String text,Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: color),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
}
