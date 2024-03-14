import 'package:get/get.dart';

import '../controllers/work_report_detail_controller.dart';

class WorkReportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkReportDetailController>(
      () => WorkReportDetailController(),
    );
  }
}
