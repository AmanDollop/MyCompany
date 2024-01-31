import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTaskView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
