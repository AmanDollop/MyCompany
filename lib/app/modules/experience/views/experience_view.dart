import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';

import '../controllers/experience_controller.dart';

class ExperienceView extends GetView<ExperienceController> {
  const ExperienceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Experience',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: const Center(
        child: Text(
          'ExperienceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
