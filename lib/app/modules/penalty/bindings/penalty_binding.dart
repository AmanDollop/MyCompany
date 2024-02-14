import 'package:get/get.dart';

import '../controllers/penalty_controller.dart';

class PenaltyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PenaltyController>(
      () => PenaltyController(),
    );
  }
}
