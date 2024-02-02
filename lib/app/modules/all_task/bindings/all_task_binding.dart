import 'package:get/get.dart';

import '../controllers/all_task_controller.dart';

class AllTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllTaskController>(
      () => AllTaskController(),
    );
  }
}
