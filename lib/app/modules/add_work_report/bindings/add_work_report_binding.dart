import 'package:get/get.dart';

import '../controllers/add_work_report_controller.dart';

class AddWorkReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWorkReportController>(
      () => AddWorkReportController(),
    );
  }
}
