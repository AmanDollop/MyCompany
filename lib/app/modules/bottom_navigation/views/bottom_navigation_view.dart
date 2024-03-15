import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/drawer_view/views/drawer_view_view.dart';
import 'package:task/common/bottom_bar/GButton.dart';
import 'package:task/common/bottom_bar/GnavStyle.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/bottom_navigation_controller.dart';

final selectedBottomNavigationIndex = 0.obs;
final scrollPositionBottomNavigationValue = 0.0.obs;

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        // key: controller.scaffoldKey,
        drawerEdgeDragWidth: 30.w,
        drawer: const DrawerViewView(),
        backgroundColor: Colors.transparent,
        /*appBar: selectedBottomNavigationIndex.value == 0
            ? CW.commonAppBarView(
            homeAppBarValue: true,
            title: 'Hello, ${controller.userFullName.value.isNotEmpty?controller.userFullName.value:'Employee Name'}',
            leadingWidth: 60.px,
            isLeading: true,
            leading: Builder(
              builder: (context) => Center(
                child: SizedBox(
                  height: 45.px,
                  width: 45.px,
                  child: Center(
                    child: InkWell(
                      onTap: () => controller.clickOnDrawerButton(context: context),
                      borderRadius: BorderRadius.circular(14.px),
                      child: Ink(
                        height: 46.px,
                        width: 46.px,
                        decoration: BoxDecoration(color: Col.inverseSecondary, borderRadius: BorderRadius.circular(14.px)),
                        child: Center(
                          child: CW.commonNetworkImageView(
                              path: 'assets/icons/drawer_menu_icon.png',
                              isAssetImage: true,
                              width: 24.px,
                              height: 24.px),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onNotificationPressed: () => controller.clickOnNotificationButton())
            : selectedBottomNavigationIndex.value == 1
                ? CW.commonAppBarView(
                    title: 'Utilities',
                    isLeading: true,
                    onBackPressed: () => controller.willPop(pageIndex:1),
                  )
                : CW.commonAppBarView(
                    title: 'Menu',
                    isLeading: true,
                    onBackPressed: () => controller.willPop(pageIndex: 2),
                  ),*/
        body: controller.pageCalling(
          selectedIndex: selectedBottomNavigationIndex.value.toInt(),
        ),
        bottomNavigationBar: scrollPositionBottomNavigationValue.value <= 100
            ? Container(
                decoration: BoxDecoration(
                  color: Col.gTop,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.px),
                      topRight: Radius.circular(24.px)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24.px,
                      color: Col.secondary.withOpacity(.2),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 12.px, bottom: 14.px, left: 20.px, right: 20.px),
                  child: GNav(
                    padding: EdgeInsets.zero,
                    // backgroundColor: Colors.red,
                    duration: const Duration(milliseconds: 50),
                    tabBackgroundColor: Col.primary.withOpacity(.1),
                    tabs: [
                      GButton(
                        textSize: 20,
                        icon: selectedBottomNavigationIndex.value == 0
                            ? selectedCommonButtonView(
                                imagePath: 'assets/bottom_bar_icons/dark_home_icon.png',
                                title: 'Home')
                            : unSelectedCommonButtonView(
                                imagePath: 'assets/bottom_bar_icons/light_home_icon.png',
                                title: 'Home'),
                      ),
                      GButton(
                        icon: selectedBottomNavigationIndex.value == 1
                            ? selectedCommonButtonView(
                                imagePath:
                                    'assets/bottom_bar_icons/dark_utilities_icon.png',
                                title: 'Utilities')
                            : unSelectedCommonButtonView(
                                imagePath:
                                    'assets/bottom_bar_icons/light_utilities_icon.png',
                                title: 'Utilities'),
                      ),
                      GButton(
                        icon: selectedBottomNavigationIndex.value == 2
                            ? selectedCommonButtonView(
                                imagePath:
                                    'assets/bottom_bar_icons/dark_menu_icon.png',
                                title: 'Menus')
                            : unSelectedCommonButtonView(
                                imagePath:
                                    'assets/bottom_bar_icons/light_menu_icon.png',
                                title: 'Menu'),
                      ),
                    ],
                    selectedIndex: selectedBottomNavigationIndex.value,
                    onTabChange: (index) {
                      selectedBottomNavigationIndex.value = index;
                      controller.count.value++;
                    },
                  ),
                ),
              )
            : const SizedBox(),
      );
    });
  }

  Widget selectedCommonButtonView({required String imagePath, required String title}) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff75EEC3),
              Color(0xff6AE8F7),
            ],
          ),
          borderRadius: BorderRadius.circular(25.px),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.px, vertical: 12.px),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                width: 20.px,
                height: 20.px,
                color: Col.gBottom,
              ),
              SizedBox(width: 14.px),
              selectedTitleTextView(title: title,),
            ],
          ),
        ),
      );

  Widget selectedTitleTextView({required String title}) => Text(
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w700, color: Col.gBottom),
        title,
      );

  Widget unSelectedCommonButtonView({required String imagePath, required String title}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.px, vertical: 12.px),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 18.px,
              height: 18.px,
            ),
            SizedBox(width: 14.px),
            unSelectedTitleTextView(title: title),
          ],
        ),
      );

  Widget unSelectedTitleTextView({required String title}) => Text(
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w500, color: Col.gray),
        title,
      );
}
