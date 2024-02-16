import 'package:get/get.dart';

import '../controllers/holiday_controller.dart';

class HolidayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HolidayController>(
      () => HolidayController(),
    );
  }
}
