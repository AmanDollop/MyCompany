import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../controllers/select_brance_controller.dart';

class SelectBranceView extends GetView<SelectBranceController> {
  const SelectBranceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          // appBar: CW.commonAppBarView(
          //   title: 'Select Branch',
          //   isLeading: true,
          //   onBackPressed: () => controller.clickOnBackButton(),
          // ),
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () => controller.clickOnBackButton(),
            child: Obx(() {
              controller.count.value;
              return ModalProgress(
                inAsyncCall: controller.apiResponseValue.value,
                child: controller.branchModel.value != null
                    ? controller.branchList != null &&
                            controller.branchList!.isNotEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.px, top: 12.px, right: 12.px),
                                child: CW.myAppBarView(
                                  title: 'Select Branch',
                                  onLeadingPressed: () => controller.clickOnBackButton(),
                                  padding: EdgeInsets.zero
                                ),
                              ),
                              Expanded(
                                child: CW.commonGridView(
                                  length: controller.branchList!.length,
                                  child: (index) {
                                    final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                                    return SizedBox(
                                      width: controller.branchList?.length == 1
                                          ? cellWidth * 2
                                          : cellWidth,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: index % 2 == 0 ? C.margin : C.margin / 2,
                                            right: index % 2 == 0 ? C.margin / 2 : C.margin,
                                            top: C.margin,
                                            bottom: 0.px),
                                        child: CustomOutlineButton(
                                          padding: EdgeInsets.only(left: 14.px, right: 0.px,top: 2.px,bottom: 2.px),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: controller.branchId.value == controller.branchList?[index].branchId.toString()
                                                ? [
                                                    Col.primary,
                                                    Col.primaryColor,
                                                  ]
                                                : [
                                                    Col.gray,
                                                    Col.gray,
                                                  ],
                                          ),
                                          onPressed: () {
                                            controller.branchIndexValue.value = controller.branchList?[index].branchName.toString() ?? '';
                                            controller.branchId.value = controller.branchList?[index].branchId.toString() ?? '';
                                            controller.count.value++;
                                          },
                                          radius: 10.px,
                                          strokeWidth: 1.px,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: cardTextView(
                                                  text: controller.branchList?[index].branchName != null && controller.branchList![index].branchName!.isNotEmpty
                                                      ? '${controller.branchList?[index].branchName}'
                                                      : 'Branch Name',
                                                  color: controller.branchId.value == controller.branchList?[index].branchId.toString()
                                                      ? Col.primary
                                                      : Col.inverseSecondary
                                                ),
                                              ),
                                              CW.commonRadioView(
                                                onChanged: (value) {
                                                  CM.unFocusKeyBoard();
                                                  controller.branchIndexValue.value = controller.branchList?[index].branchName.toString() ?? '';
                                                  controller.branchId.value = controller.branchList?[index].branchId.toString() ?? '';
                                                  controller.count.value++;
                                                },
                                                index: controller.branchList![index].branchName.toString(),
                                                selectedIndex: controller.branchIndexValue.value.toString(),
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
                                padding: EdgeInsets.symmetric(
                                  vertical: 4.px,
                                  horizontal: 12.px,
                                ),
                                color: Colors.transparent,
                                child: Center(
                                  child: CW.myElevatedButton(
                                      onPressed: controller.branchIndexValue.value != '' && controller.branchId.value != ''
                                          ? () => controller.clickOnContinueButton()
                                          : () => null,
                                      buttonText: controller.branchIndexValue.value != '' && controller.branchId.value != ''
                                          ? 'Continue'
                                          : 'Select Branch'),
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
        ),
      ),
    );
  }

  Widget cardTextView({required String text,Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: color),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
}
