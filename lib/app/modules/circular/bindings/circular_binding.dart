import 'package:get/get.dart';

import '../controllers/circular_controller.dart';

class CircularBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircularController>(
      () => CircularController(),
    );
  }
}
