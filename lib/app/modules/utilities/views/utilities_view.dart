import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/utilities_controller.dart';

class UtilitiesView extends GetView<UtilitiesController> {
  const UtilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(

        body: Obx(() {
          controller.count.value;
          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.titleList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.clickOnCards(headingCardIndex: index),
                borderRadius: BorderRadius.circular(10.px),
                child: Ink(
                  height: 100.px,
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
                    padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
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
                          child: Text(
                            controller.titleList[index],
                            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700,fontSize: 10.px),
                            maxLines:  2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
