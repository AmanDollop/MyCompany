import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_bank_controller.dart';

class AddBankView extends GetView<AddBankController> {
  const AddBankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBankView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddBankView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
