import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_detail_controller.dart';

class LeaveDetailView extends GetView<LeaveDetailController> {
  const LeaveDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Leave Detail',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
          actions: [
            CW.commonIconButton(
                onPressed: () => controller.clickOnEditButton(),
                isAssetImage: true,
                imagePath: 'assets/icons/edit_pen_icon.png',
                color: Col.inverseSecondary,
            ),
            SizedBox(width: 5.px)
          ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        children: [
          commonColumnView(text1: 'Leave Type', text2: 'Medical Leave (Paid)'),
          SizedBox(height: 6.px),
          commonColumnView(text1: 'Leave Day Type', text2: 'Medical Leave (Paid)'),
          SizedBox(height: 6.px),
          commonColumnView(text1: 'Date', text2: 'Feb 19,2024  - Feb 22, 2024'),
          SizedBox(height: 6.px),
          commonColumnView(text1: 'Approved by', text2: 'Admin'),
          SizedBox(height: 6.px),
          commonColumnView(text1: 'Reason', text2: 'Lorem ipsum dolor sit amet, consectetur adipiscing  sed do eiusmod tempor incididunt ut labore Lorem ipsum dolor sit amet, consectetur adipiscing  sed do eiusmod tempor incididunt ut labore'),
          SizedBox(height: 6.px),
          commonColumnView(text1: 'Attachment', text2: 'assets/images/img.png', attachmentValue: true),
          SizedBox(height: 6.px),
        ],
      ),
    );
  }

  Widget commonColumnView({required String text1, required String text2, bool attachmentValue = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.px),
          attachmentValue
              ? CW.commonNetworkImageView(
                  path: text2,
                  isAssetImage: true,
                  height: 110,
                  width: 150,
                )
              : Text(
                  text2,
                  style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          SizedBox(height: 2.px),
          CW.commonDividerView()
        ],
      );
}
