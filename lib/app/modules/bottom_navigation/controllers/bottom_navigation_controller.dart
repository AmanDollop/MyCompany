import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:task/app/modules/home/controllers/home_controller.dart';
import 'package:task/app/modules/home/views/home_view.dart';
import 'package:task/app/modules/menu_view/controllers/menu_view_controller.dart';
import 'package:task/app/modules/menu_view/views/menu_view_view.dart';
import 'package:task/app/modules/utilities/controllers/utilities_controller.dart';
import 'package:task/app/modules/utilities/views/utilities_view.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';

class BottomNavigationController extends GetxController {

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Widget pageCalling({int? selectedIndex}){
    switch (selectedIndex) {
      case 0:
        // Get.delete<HomeController>();
        Get.lazyPut<HomeController>(
              () => HomeController(),
        );
        HomeController homeController = Get.find();
        return const HomeView();
      case 1:
        Get.delete<UtilitiesController>();
        Get.lazyPut<UtilitiesController>(
              () => UtilitiesController(),
        );
        UtilitiesController utilitiesController = Get.find();
        return const UtilitiesView();
      case 2:
        Get.delete<MenuViewController>();
        Get.lazyPut<MenuViewController>(
              () => MenuViewController(),
        );
        MenuViewController menuViewController = Get.find();
        return const MenuViewView();
      default:
        return const SizedBox();
    }
  }

  willPop({required int pageIndex}) {
    if(pageIndex==0){
     /* CD.commonIosExitAppDialog(
        clickOnCancel: () {
          Get.back();
        },
        clickOnExit: () {
          exit(0);
        },
      );*/
    }else{
      selectedBottomNavigationIndex.value=0;
    }
  }

  void clickOnDrawerButton({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }

  void clickOnNotificationButton() {
    Get.toNamed(Routes.NOTIFICATION);
  }


}
