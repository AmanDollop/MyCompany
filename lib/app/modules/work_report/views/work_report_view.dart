import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';

import '../controllers/work_report_controller.dart';

class WorkReportView extends GetView<WorkReportController> {
  const WorkReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: controller.menuName.value,
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: Obx(() {
        controller.count.value;
        if (AC.isConnect.value) {
          return ModalProgress(
            inAsyncCall: false,
            child: const Center(
              child: Text(
                'WorkReportView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else {
          return CW.commonNoNetworkView();
        }
      }),
    );
  }
}
