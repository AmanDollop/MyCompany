import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Notification',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.px,horizontal: 0.px),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                elevation: .5,
                color: Col.backgroundFillColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: .5.px,
                      color: Col.gray.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(8.px)),
                margin: EdgeInsets.symmetric(horizontal: 12.px),
                child: ListTile(
                  // contentPadding: EdgeInsets.zero,
                  // visualDensity: VisualDensity(vertical: -2.px),
                  leading: Container(
                    height: 45,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Col.inverseSecondary,
                      borderRadius:
                      BorderRadius.circular(8.px),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Col.gray,
                      size: 20.px,
                    ),
                  ),
                  horizontalTitleGap: 10.px,
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Notification Title',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                              '25 Jan 2024',
                              style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px,fontWeight: FontWeight.w500),
                              maxLines: 1,
                              textAlign: TextAlign.end),
                        ),
                    ],
                  ),
                  subtitle: Text('Notification Detail',
                    maxLines: 2,
                    style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px,fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 8.px),
            ],
          );
        },
      ),
    );
  }
}
