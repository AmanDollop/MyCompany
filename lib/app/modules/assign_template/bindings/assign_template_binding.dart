import 'package:get/get.dart';

import '../controllers/assign_template_controller.dart';

class AssignTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignTemplateController>(
      () => AssignTemplateController(),
    );
  }
}
