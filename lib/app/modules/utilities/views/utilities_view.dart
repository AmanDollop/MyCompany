import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/utilities_controller.dart';

class UtilitiesView extends GetView<UtilitiesController> {
  const UtilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(
        // appBar: CW.commonAppBarView(
        //   title: 'Utilities',
        //   isLeading: true,
        //   onBackPressed: () => controller.willPop(),
        // ),
        body: Obx(() {
          controller.count.value;
          return CW.commonGridView(
            length: controller.titleList.length,
            child: (index) {
              final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
              return SizedBox(
                width: cellWidth.px,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: index % 2 == 0 ? C.margin : C.margin / 2,
                      right: index % 2 == 0 ? C.margin / 2 : C.margin ,
                      top: 0,
                      bottom: C.margin),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10.px),
                    child: Ink(
                      height: 114.px,
                      padding: EdgeInsets.only(left: 3.px),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 24.px,
                            color: Col.secondary.withOpacity(.05),
                          )
                        ],
                        color: controller.colorList[index],
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                      child: Ink(
                        padding: EdgeInsets.symmetric(horizontal: 8.px,vertical: 8.px),
                        decoration: BoxDecoration(
                          color: Col.inverseSecondary,
                          borderRadius: BorderRadius.circular(6.px),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40.px,
                              height: 40.px,
                              decoration: BoxDecoration(
                                color: controller.colorList[index],
                                borderRadius: BorderRadius.circular(6.px),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/shoping_light.png',
                                  width: 24.px,
                                  height: 24.px,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.px),
                            Flexible(
                              child: cardTextView(
                                text: controller.titleList[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            height: 114.px,
          );
        }),
      ),
    );
  }

  Widget cardTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500,fontSize: 14.px),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
