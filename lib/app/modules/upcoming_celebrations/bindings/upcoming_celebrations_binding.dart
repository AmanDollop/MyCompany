import 'package:get/get.dart';

import '../controllers/upcoming_celebrations_controller.dart';

class UpcomingCelebrationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingCelebrationsController>(
      () => UpcomingCelebrationsController(),
    );
  }
}
