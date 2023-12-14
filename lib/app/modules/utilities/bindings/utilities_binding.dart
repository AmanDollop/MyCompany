import 'package:get/get.dart';

import '../controllers/utilities_controller.dart';

class UtilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilitiesController>(
      () => UtilitiesController(),
    );
  }
}
