import 'package:get/get.dart';

import '../controllers/work_report_controller.dart';

class WorkReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkReportController>(
      () => WorkReportController(),
    );
  }
}
