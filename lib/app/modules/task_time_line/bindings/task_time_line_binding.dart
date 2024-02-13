import 'package:get/get.dart';

import '../controllers/task_time_line_controller.dart';

class TaskTimeLineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskTimeLineController>(
      () => TaskTimeLineController(),
    );
  }
}
