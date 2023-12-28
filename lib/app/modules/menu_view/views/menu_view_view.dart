
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/menu_view_controller.dart';

class MenuViewView extends GetView<MenuViewController> {
  const MenuViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.willPop(),
      child: Scaffold(
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
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10.px),
                  physics: const ScrollPhysics(),
                  itemCount: controller.titleList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.px,
                    mainAxisSpacing: 10.px,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.px),
                      child: Ink(
                        height: 100.px,
                        padding: EdgeInsets.all(2.px),
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
                              width: 60.px,
                              height: 60.px,
                              decoration: BoxDecoration(
                                color: Col.inverseSecondary,
                                borderRadius: BorderRadius.circular(6.px),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/shoping_dark.png',
                                  width: 34.px,
                                  height: 34.px,
                                ),
                              ),
                            ),
                            Flexible(
                              child: cardTextView(
                                text: controller.titleList[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget titleTextView() => Text('What are you looking for?',style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 16.px));

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
    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700,fontSize: 10.px),
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );



}
