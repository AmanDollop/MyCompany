import 'package:get/get.dart';

import '../controllers/sub_task_controller.dart';

class SubTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubTaskController>(
      () => SubTaskController(),
    );
  }
}
