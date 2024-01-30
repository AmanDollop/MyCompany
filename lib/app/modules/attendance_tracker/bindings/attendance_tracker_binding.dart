import 'package:get/get.dart';

import '../controllers/attendance_tracker_controller.dart';

class AttendanceTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceTrackerController>(
      () => AttendanceTrackerController(),
    );
  }
}
