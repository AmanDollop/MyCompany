import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(title: controller.menuName.value,isLeading: true,onBackPressed: () => controller.clickOnBackButton(),),
      body: const Center(
        child: Text(
          'TaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10.px),
        child: CW.commonOutlineButton(
            onPressed: () => controller.clickOnAddNewTaskButton(),
            child: Icon(
              Icons.add,
              color: Col.inverseSecondary,
              size: 22.px,
            ),
            height: 50.px,
            width: 50.px,
            backgroundColor: Col.primary,
            borderColor: Colors.transparent,
            borderRadius: 25.px),
      ),
    );
  }
}
