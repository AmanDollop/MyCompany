import 'package:get/get.dart';

import '../controllers/select_shift_time_controller.dart';

class SelectShiftTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectShiftTimeController>(
      () => SelectShiftTimeController(),
    );
  }
}
