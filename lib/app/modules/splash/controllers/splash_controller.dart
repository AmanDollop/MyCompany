import 'dart:async';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  Database? database;
  String? token;

  @override
   void onInit()  {
    super.onInit();
    dataBaseCalling();
    Timer(
      const Duration(seconds: 3),
      () => callingNextScreen(),
    );
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

  Future<void> dataBaseCalling() async {
    database = await DataBaseHelper().openDataBase();
    if (database != null) {
      await DataBaseHelper().createTableInDataBase(database!);
      token = await DataBaseHelper().getParticularData(key: 'token');
    }
  }

  Future<void> callingNextScreen() async {
    print('userToken   :::::::::   $token');
    if (token != null && token!.isNotEmpty) {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } else {
      await CM.setString(key: AK.baseUrl, value: '');
      Get.offAllNamed(Routes.SEARCH_COMPANY);
    }
  }
}
