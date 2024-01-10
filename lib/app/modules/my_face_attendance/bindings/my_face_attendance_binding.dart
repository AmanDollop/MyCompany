import 'package:get/get.dart';

import '../controllers/my_face_attendance_controller.dart';

class MyFaceAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFaceAttendanceController>(
      () => MyFaceAttendanceController(),
    );
  }
}
