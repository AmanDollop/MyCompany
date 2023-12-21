import 'package:get/get.dart';

import '../controllers/select_department_controller.dart';

class SelectDepartmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectDepartmentController>(
      () => SelectDepartmentController(),
    );
  }
}
