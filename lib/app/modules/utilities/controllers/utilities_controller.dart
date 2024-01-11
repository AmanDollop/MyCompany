import 'dart:ui';

import 'package:get/get.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';

class UtilitiesController extends GetxController {

  final count = 0.obs;


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

  willPop() {
    selectedBottomNavigationIndex.value=0;
  }

  void clickOnCards({required int headingCardIndex}) {}

}
