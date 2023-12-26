import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PersonalInfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PersonalInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
