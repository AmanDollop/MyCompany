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
                              controller.breakCheckBoxValue.value = '';
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
                    itemCount: controller.breakTitleList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.breakTitleList[index],style: Theme.of(context).textTheme.titleLarge),
                            InkWell(
                              onTap: () {
                                controller.breakCheckBoxValue.value = controller.breakTitleList[index].toString();
                                controller.count.value++;
                              },
                              borderRadius: BorderRadius.circular(6.px),
                              child: controller.breakCheckBoxValue.value == controller.breakTitleList[index]
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
                CW.commonElevatedButton(
                  onPressed: controller.breakCheckBoxValue.value != ''
                      ? () async {
                          controller.currentDateTimeForBreak.value = await controller.getInternetDateTime();
                          controller.breakValue.value = !controller.breakValue.value;
                          controller.breakDialogConfirmButtonValue.value = true;
                          Get.back();
                        }
                      : () => null,
                  width: 200.px,
                  height: 40.px,
                  buttonText: controller.breakCheckBoxValue.value != ''
                      ? 'Confirm'
                      : 'Select break type',
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
