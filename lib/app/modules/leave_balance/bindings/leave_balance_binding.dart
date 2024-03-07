import 'package:get/get.dart';

import '../controllers/leave_balance_controller.dart';

class LeaveBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveBalanceController>(
      () => LeaveBalanceController(),
    );
  }
}
