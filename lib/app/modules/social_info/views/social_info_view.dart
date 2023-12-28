import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';

import '../controllers/social_info_controller.dart';

class SocialInfoView extends GetView<SocialInfoController> {
  const SocialInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Social Info',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: const Center(
        child: Text(
          'SocialInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
