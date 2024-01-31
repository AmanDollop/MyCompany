import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/home/controllers/home_controller.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

class BreakDialog extends GetView<HomeController> {
  const BreakDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      controller.breakDialogConfirmButtonValue.value = false;
      return Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
        backgroundColor: Col.inverseSecondary,
        child: SizedBox(
          height: 300.px,
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.px, top: 6.px),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Break Type',
                        style: Theme.of(Get.context!).textTheme.displayLarge,
                      ),
                      CW.commonIconButton(
                          onPressed: () {
                            Get.back();
                            if (!controller.breakDialogConfirmButtonValue.value) {
                              controller.breakTypeIdCheckBoxValue.value = '';
                            }
                          },
                          isAssetImage: false,
                          icon: Icons.cancel,
                          size: 22.px)
                    ],
                  ),
                ),
                CW.commonDividerView(),
                SizedBox(height: 16.px),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.px),
                    itemCount: controller.getBreakDetailsList?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${controller.getBreakDetailsList?[index].breakTypeName}',style: Theme.of(context).textTheme.titleLarge),
                            InkWell(
                              onTap: () {
                                controller.breakTypeIdCheckBoxValue.value = '${controller.getBreakDetailsList?[index].breakTypeId}';
                                controller.count.value++;
                              },
                              borderRadius: BorderRadius.circular(6.px),
                              child: controller.breakTypeIdCheckBoxValue.value == controller.getBreakDetailsList?[index].breakTypeId
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 2.px),
                                      child: SizedBox(
                                        height: 16.px,
                                        width: 16.px,
                                        child: Icon(
                                          Icons.check_box,
                                          color: Col.primary,
                                          size: 22.px,
                                        ),
                                      ),
                                    )
                                  : Ink(
                                      height: 16.px,
                                      width: 16.px,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Col.gray, width: 1.px),
                                        borderRadius:
                                        BorderRadius.circular(4.px),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 6.px),
                Center(
                  child: SizedBox(
                    width: 200.px,
                    height: 40.px,
                    child: CW.commonElevatedButton(
                      onPressed: controller.breakTypeIdCheckBoxValue.value != ''
                          ? controller.confirmBreakButtonValue.value
                          ? () => null
                          : () => controller.clickOnConfirmBreakButton()
                          : () => null,
                      progressBarHeight: 20.px,
                      progressBarWidth: 20.px,
                      isLoading: controller.confirmBreakButtonValue.value,
                      buttonText: controller.breakTypeIdCheckBoxValue.value != ''
                          ? 'Confirm'
                          : 'Select break type',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
