import 'package:get/get.dart';

import '../controllers/job_info_controller.dart';

class JobInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobInfoController>(
      () => JobInfoController(),
    );
  }
}
