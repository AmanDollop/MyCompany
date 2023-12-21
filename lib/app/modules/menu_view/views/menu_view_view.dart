
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../controllers/menu_view_controller.dart';

class MenuViewView extends GetView<MenuViewController> {
  const MenuViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(
        // appBar: CW.commonAppBarView(
        //   title: 'Menu',
        //   isLeading: true,
        //   onBackPressed: () =>controller.willPop(),
        // ),
        body: Obx(() {
          controller.count.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Col.inverseSecondary,
                padding: EdgeInsets.only(top: 16.px,right:12.px,left: 12.px,),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleTextView(),
                  SizedBox(height: 10.px),
                  textFieldView(),
                ],
              ),),
              Expanded(
                child: CW.commonGridView(
                  length: controller.titleList.length,
                  child: (index) {
                    final cellWidth = MediaQuery.of(Get.context!).size.width / 3;
                    return SizedBox(
                      width: cellWidth,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: index % 3 == 0 ? C.margin : C.margin / 3,
                            right: index % 3 == 3-1 ? C.margin : C.margin/3 ,
                            top: C.margin / 2,),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10.px),
                          child: Ink(
                            height: 100.px,
                            padding: EdgeInsets.only(bottom: 12.px),
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
                                Container(
                                  width: 40.px,
                                  height: 40.px,
                                  decoration: BoxDecoration(
                                    color: Col.inverseSecondary,
                                    borderRadius: BorderRadius.circular(6.px),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/shoping_dark.png',
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
                    );
                  },
                  height: 100.px,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget titleTextView() => Text('What are you looking for?',style: Theme.of(Get.context!).textTheme.displayLarge);

  Widget textFieldView() => CW.commonTextFieldForMultiline(
      isBorder: true,
      labelText: 'Search your Company',
      hintText: 'Search your Company',
      labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
      hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
      // style: Theme.of(Get.context!).textTheme.bodyLarge,
      elevation: 0,
      prefixIcon: SizedBox(
        width: 24.px,
        height: 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: 'assets/icons/search_icon.png',
              isAssetImage: true,
              width: 24.px,
              height: 24.px),
        ),
      ),
      maxLines: 1
  );

  Widget cardTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.w500,fontSize: 14.px),
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );



}
