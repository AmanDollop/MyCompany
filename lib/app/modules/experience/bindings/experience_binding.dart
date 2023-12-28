import 'package:get/get.dart';

import '../controllers/experience_controller.dart';

class ExperienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceController>(
      () => ExperienceController(),
    );
  }
}
