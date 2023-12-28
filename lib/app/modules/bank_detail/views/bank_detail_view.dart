import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';

import '../controllers/bank_detail_controller.dart';

class BankDetailView extends GetView<BankDetailController> {
  const BankDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Bank Detail',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: const Center(
        child: Text(
          'BankDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
