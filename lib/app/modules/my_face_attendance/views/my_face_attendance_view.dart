import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/my_face_attendance_controller.dart';

class MyFaceAttendanceView extends GetView<MyFaceAttendanceController> {
  const MyFaceAttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'My Face Attendance',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        children: [
          Text('Face Add Date/Time : 10 Oct 2023, 07:04 AM',
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 40.px),
          Center(
            child: Container(
              height: 200.px,
              width: 200.px,
              decoration: BoxDecoration(
                color: Col.gray.withOpacity(.3),
                borderRadius: BorderRadius.circular(24.px),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          SizedBox(height: 30.px),
          Center(child: CW.commonElevatedButton(onPressed: ()=> controller.clickOnChangeFaceButton(),buttonText: 'Change Face',width: 150.px,height: 38.px),)
        ],
      ),
    );
  }
}
