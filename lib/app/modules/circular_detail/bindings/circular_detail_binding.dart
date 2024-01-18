import 'package:get/get.dart';

import '../controllers/circular_detail_controller.dart';

class CircularDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircularDetailController>(
      () => CircularDetailController(),
    );
  }
}
