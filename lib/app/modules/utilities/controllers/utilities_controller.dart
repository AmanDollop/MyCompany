import 'dart:ui';

import 'package:get/get.dart';
import 'package:task/app/modules/bottom_navigation/views/bottom_navigation_view.dart';

class UtilitiesController extends GetxController {

  final count = 0.obs;

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

}
