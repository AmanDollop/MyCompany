import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/drawer_view/controllers/drawer_view_controller.dart';
import 'package:task/app/modules/home/dialog/break_dialog.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';
import '../../../../common/common_methods/cm.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;

  final count = 0.obs;

  final scrollController = ScrollController().obs;

  final breakValue = false.obs;

  final breakDialogConfirmButtonValue = false.obs;

  final checkInOrCheckOutValue = true.obs;

  final breakCheckBoxValue = ''.obs;

  final bannerIndex = 0.obs;

  final bannerList = [
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYRNamIIDEJN4sHp3UuQVpYfwhrsNUZEld0aTCqAs4qMG-X9Wb3IGmvN3CbeSnvDzl_4c&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6g3P5972LeN4_5J9Dua6oCYn3cBzjSUGys5dhj4qerMbHQY5-TRyMzrmuRe3m6SPz4WU&usqp=CAU'
  ];

  final colorList = [
    const Color(0xff5FE079),
    const Color(0xffF36155),
    const Color(0xffF6BD4C),
    const Color(0xffA785F3),
    const Color(0xffCE46C4),
    const Color(0xff3BACA9),
    const Color(0xff7558B4),
    const Color(0xff9D9F22),
    const Color(0xff7AAEDD),
    const Color(0xffA2610C),
    const Color(0xffB04DF6),
    const Color(0xff7558B4),
    const Color(0xff9D9F22),
    const Color(0xff7AAEDD),
    const Color(0xffA2610C),
  ].obs;

  final titleList = [
    'Take Order',
    'Sales Summery',
    'Leave Tracker',
    'Assets',
    'My Expense',
    'Work report',
    'Tasks',
    'Payslip',
    'Parcel In/ Out',
    'My Visits',
    'Documents',
    'Tasks',
    'Payslip',
    'Parcel In/ Out',
  ].obs;

  final breakTitleList = [
    'Lunch Break',
    'Tea Break',
    'Personal Break',
    'Dinner Break',
  ].obs;

  GetLatLong? getLatLong;

  @override
  Future<void> onInit() async {
    super.onInit();
    Get.put(DrawerViewController());
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    await callingGetLatLongMethod();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    scrollController.value.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  Location location = Location();

  Future<void> callingGetLatLongMethod() async {
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      print('getLatLong::::::   $getLatLong');

      if (getLatLong != null) {
        // location.onLocationChanged.listen((event) {
        //   getLatLong?.latitude = event.latitude;
        //   print('getLatLong?.latitude::::::  ${getLatLong?.latitude}');
        //   getLatLong?.longitude = event.longitude;
        //   print('getLatLong?.longitude::::::::  ${getLatLong?.longitude}');
        // });
        // await callingApi();
      } else {
        if (AC.isConnect.value) {
          locationAlertDialog();
        }
      }
    } catch (e) {
      CM.error();
    }
  }

  locationAlertDialog() async {
    await CD.commonIosPermissionDialog(clickOnPermission: () async {
      Get.back();
      await onInit();
    });
  }

  willPop() {
    CD.commonIosExitAppDialog(
      clickOnCancel: () {
        Get.back();
      },
      clickOnExit: () {
        exit(0);
      },
    );
  }

  void clickOnDrawerButton({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }

  void clickOnNotificationButton() {
    Get.toNamed(Routes.NOTIFICATION);
  }

  void clickOnSwitchButton() {
    breakCheckBoxValue.value = '';
    breakValue.value = false;
    animationController.forward();
    checkInOrCheckOutValue.value = !checkInOrCheckOutValue.value;
    count.value++;
  }

  Future<void> clickOnBreakButton() async {
    if (!breakValue.value) {
      await showDialog(
          context: Get.context!,
          builder: (context) {
            return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: const BreakDialog());
          });
      if (breakCheckBoxValue.value != '' &&
          breakDialogConfirmButtonValue.value) {
        print('breakCheckBoxValue.value::::::  ${breakCheckBoxValue.value}');
        animationController.reverse();
      }
    } else {
      breakCheckBoxValue.value = '';
      breakValue.value = false;
      animationController.forward();
    }
  }

  void clickOnCirculars() {}

  void clickOnDiscussion() {}

  void clickOnUpcomingCelebrationsButton() {}

  void clickOnHeadingCards({required int headingCardIndex}) {}

  void clickOnMyTeamCards({required int myTeamCardIndex}) {}

  void clickOnYourDepartmentViewAllButton() {}

  void clickOnYourDepartmentCards({required int yourDepartmentCardIndex}) {}

  void clickOnGalleryViewAllButton() {}

}
