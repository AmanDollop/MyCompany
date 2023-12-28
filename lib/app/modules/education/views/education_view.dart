import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';

import '../controllers/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Education',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: const Center(
        child: Text(
          'EducationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
