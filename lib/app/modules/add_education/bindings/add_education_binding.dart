import 'package:get/get.dart';

import '../controllers/add_education_controller.dart';

class AddEducationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEducationController>(
      () => AddEducationController(),
    );
  }
}
