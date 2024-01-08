import 'package:get/get.dart';

import '../controllers/shift_detail_controller.dart';

class ShiftDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftDetailController>(
      () => ShiftDetailController(),
    );
  }
}
