import 'package:get/get.dart';

import '../controllers/leave_detail_controller.dart';

class LeaveDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveDetailController>(
      () => LeaveDetailController(),
    );
  }
}
