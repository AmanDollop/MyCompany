import 'package:get/get.dart';

import '../controllers/add_sub_task_controller.dart';

class AddSubTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSubTaskController>(
      () => AddSubTaskController(),
    );
  }
}
