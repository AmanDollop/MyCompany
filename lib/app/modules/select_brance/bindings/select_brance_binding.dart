import 'package:get/get.dart';

import '../controllers/select_brance_controller.dart';

class SelectBranceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectBranceController>(
      () => SelectBranceController(),
    );
  }
}
